Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269254AbRHYS3J>; Sat, 25 Aug 2001 14:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRHYS27>; Sat, 25 Aug 2001 14:28:59 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:57595
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S269254AbRHYS2q>; Sat, 25 Aug 2001 14:28:46 -0400
Date: Sat, 25 Aug 2001 14:29:00 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What version of the kernel fixes these VM issues?
In-Reply-To: <20010825163138Z16125-32384+506@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108251420510.20456-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Aug 2001, Daniel Phillips wrote:

> On August 25, 2001 05:00 am, Nicolas Pitre wrote:
> > This board has 32MB RAM, no swap.  Root fs is NFS.  On the serial console I
> > start a command line mp3 player.  In a first telnet session I start a build
> > of gcc 3.0 (./configure; make).  In a second telnet session I start 'top'.
> > Music plays while gcc builds and I can see the CPU usage within top.
> > Pretty real scenario, real life situation, expected system load, no trick.
>
> You're streaming the mp3 over nfs, right?  From your setup I'd guess there's
> no local hard disk.

No there isn't.

> > - The same behavior occurs with 2.4.8-ac4.
>
> How far back do you have to go before you get one that works?  I seem to
> recall the inactive_plenty changes came in at 2.4.8-pre1.  Could you try it
> with 2.4.7, please.

2.4.7 does the same, spinning in kswapd while everything else is stalled,
except for kernel BHs.


SysRq: Show Memory
Mem-info:
Free pages:        1016kB (     0kB HighMem)
( Active: 2554, inactive_dirty: 0, inactive_clean: 0, free: 254 (255 510 765) )
4*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1016kB)
= 0kB)
= 0kB)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
8192 pages of RAM
395 free pages
626 reserved pages
581 pages shared
0 pages swap cached
3 page tables cached
Buffer memory:     8000kB


So 2.4.7 was screwed the same way too.


Nicolas

