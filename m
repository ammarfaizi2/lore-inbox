Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289148AbSA3Or0>; Wed, 30 Jan 2002 09:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289214AbSA3OrR>; Wed, 30 Jan 2002 09:47:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:59663 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289148AbSA3OrM>;
	Wed, 30 Jan 2002 09:47:12 -0500
Date: Wed, 30 Jan 2002 12:46:53 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16VsPE-0000DZ-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0201301245240.11594-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Daniel Phillips wrote:
> On January 30, 2002 10:07 am, Horst von Brand wrote:

> > But most of this will be lost on exec(2).

> > Also, it is my impression that
> > the tree of _running_ processes isn't usually very deep (Say init --> X -->
> > [Random processes] --> [compilations &c], this would make 5 or 6 deep, no
> > more.

> Here's my tree - on a non-very-busy laptop.  Why is my X tree so much deeper?
> I suppose if I was running java this would look considerably more interesting.

>      |-bash---bash---xinit-+-XFree86
>      |                     `-xfwm-+-xfce---gnome-terminal-+-bash---pstree

It doesn't matter how deep the tree is, on exec() all
previously shared page tables will be blown away.

In this part of the tree, I see exactly 2 processes
which could be sharing page tables (the two bash
processes).

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

