Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289214AbSA3Oz0>; Wed, 30 Jan 2002 09:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289216AbSA3OzH>; Wed, 30 Jan 2002 09:55:07 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:32402 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289214AbSA3OzC>;
	Wed, 30 Jan 2002 09:55:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Wed, 30 Jan 2002 15:59:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201301245240.11594-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201301245240.11594-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VwCo-0000F0-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 03:46 pm, Rik van Riel wrote:
> On Wed, 30 Jan 2002, Daniel Phillips wrote:
> > On January 30, 2002 10:07 am, Horst von Brand wrote:
> 
> > > But most of this will be lost on exec(2).
> 
> > > Also, it is my impression that
> > > the tree of _running_ processes isn't usually very deep (Say init --> X -->
> > > [Random processes] --> [compilations &c], this would make 5 or 6 deep, no
> > > more.
> 
> > Here's my tree - on a non-very-busy laptop.  Why is my X tree so much deeper?
> > I suppose if I was running java this would look considerably more interesting.
> 
> >      |-bash---bash---xinit-+-XFree86
> >      |                     `-xfwm-+-xfce---gnome-terminal-+-bash---pstree
> 
> It doesn't matter how deep the tree is, on exec() all
> previously shared page tables will be blown away.
> 
> In this part of the tree, I see exactly 2 processes
> which could be sharing page tables (the two bash
> processes).

Sure, your point is that there is no problem and the speed of rmap on fork
is not something to worry about?

-- 
Daniel
