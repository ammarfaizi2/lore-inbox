Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVDRE2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVDRE2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVDRE2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:28:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:57352 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261443AbVDRE2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:28:19 -0400
Date: Mon, 18 Apr 2005 06:28:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
Subject: Re: More performance for the TCP stack by using additional hardware chip on NIC
Message-ID: <20050418042807.GC777@alpha.home.local>
References: <200504172337.j3HNbJsA004220@laptop11.inf.utfsm.cl> <edb06d05e65c7c2ce2ba008cc673aa29@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb06d05e65c7c2ce2ba008cc673aa29@mac.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:08:41AM -0400, Kyle Moffett wrote:
(...) 
> What I think would be _much_ more useful is a generic low-power 
> multi-proc MIPS/PPC system on a PCI card with a certain amount of
> RAM, etc that could be programmed at runtime by the master CPU.
> Then you lose none of the flexibility, it can be run in the same
> endian-mode as the host CPU, and it would allow you to program
> it for much more complicated DMA.

it would be really interesting, it would be sort of an I/O coprocessor,
but unfortunately, it would half the PCI bandwidth (which is already a
problem with 10 Gbps) be cause the data would have to go from the NIC
to the copro then from the copro to system RAM.

Or if this copro contains large amounts of RAM, then the applications
can manipulate data directly on the card (and the copro could provide
remote memcpy, memmove, etc...), thus eliminating copies. But in this
case, it would require many modifications on both the kernel and the
application.

> You could do anything from linux software RAID, audio processing,
> encryption, TCP/IP stack acceleration, extra scatter-gather for your
> disk controller, etc.
> If it was low-cost, IE: cheaper than adding extra full-speed CPUs to the
> system, and using a decent bi-endian, vector-capable CPU (Like PPC), you
> might find that people will buy them for the flexibility.  Such a thing
> might also be useful for the prezero folks, it could be used (when not
> otherwise occupied) for zeroing unused pages.
> 
> Personally, I think I'd buy one or two just to tinker with them :-D.

Then you should take a look at some hardware RAID controllers or even
some special intel NICs, both of which often come with an i960 or PPC
onboard. It might become a good start, and if you can show someting
interesting, we already know there's one guy here who can build the
full-speed CPU from the specs :-)

Cheers,
Willy

