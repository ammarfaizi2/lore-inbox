Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289336AbSA3Pzq>; Wed, 30 Jan 2002 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSA3Pz2>; Wed, 30 Jan 2002 10:55:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:41988 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289336AbSA3PzK>;
	Wed, 30 Jan 2002 10:55:10 -0500
Date: Wed, 30 Jan 2002 13:54:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16VwCo-0000F0-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0201301354000.11594-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Daniel Phillips wrote:
> On January 30, 2002 03:46 pm, Rik van Riel wrote:
> > On Wed, 30 Jan 2002, Daniel Phillips wrote:

> > >      |-bash---bash---xinit-+-XFree86
> > >      |                     `-xfwm-+-xfce---gnome-terminal-+-bash---pstree
> >
> > It doesn't matter how deep the tree is, on exec() all
> > previously shared page tables will be blown away.
> >
> > In this part of the tree, I see exactly 2 processes
> > which could be sharing page tables (the two bash
> > processes).
>
> Sure, your point is that there is no problem and the speed of rmap on
> fork is not something to worry about?

No.  The point is that we should optimise for fork()+exec(),
not for a long series of consecutive fork()s all sharing the
same page tables.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

