Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285248AbRLMW5h>; Thu, 13 Dec 2001 17:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRLMW51>; Thu, 13 Dec 2001 17:57:27 -0500
Received: from kullstam.ne.mediaone.net ([66.30.137.210]:37512 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S285248AbRLMW5U>; Thu, 13 Dec 2001 17:57:20 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre11 de2104X tulip driver problem
In-Reply-To: <20011213150346.A31843@Sophia.soo.com>
Organization: none
Date: 13 Dec 2001 17:57:13 -0500
In-Reply-To: <20011213150346.A31843@Sophia.soo.com>
Message-ID: <m2hequpw3a.fsf@euler.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"really mason@soo.com" <lnx-kern@Sophia.soo.com> writes:

> Just a tulip driver bug report:
> 
> i'm one of those dinosaurs using a 10base2 network and really
> old DLink-530 21040 and 21041 based ethercards.
> 
> This is what a recent kernel version (2.5.1-pre10) working
> tulip driver prints out when booting up:
> 
> kernel: tulip0: 21041 Media table, default media 0800 (Autosense).
> kernel: tulip0:  21041 media #0, 10baseT.
> kernel: tulip0:  21041 media #4, 10baseT-FDX.
> kernel: tulip0:  21041 media #1, 10base2.
> [...]
> kernel: eth0: Digital DC21041 Tulip rev 17 at 0xe0800f80, 21041 mode, 00:80:C8:3E:D0:BC, IRQ 12.
> [...]
> kernel: eth0: No 21041 10baseT link beat, Media switched to AUI.
> 
> Card still works on my 10base2 network even tho i haven't got
> an AUI port on the ethercard.
> ======================================================================
> 
> This is what the non working 2.5.1-pre11 tulip driver prints out:
> 
> kernel: de2104x PCI Ethernet driver v0.5.1 (Nov 20, 2001)
> kernel: de0: SROM-listed ports: TP
> kernel: eth0: 21041 at 0xe0800f80, 00:80:c8:3e:d0:bc, IRQ 12
> [...]
> kernel: eth0: set link 10baseT auto, mode 7ffc0040, sia 10c4,ffffef01,ffffffff,ffff0008
> kernel:                  set mode 7ffc0000, set sia ef01,ffff,8
> 
> ====================================================================

i have a DEC DE450 (based on 21041 AA chipset).  i guess, for
2104[01], tulip driver has been broken since 2.4.4 (yes, that's over
six months of brokeness).  yes, jeff garzik knows about it.  i've
emailed the list and sourceforge &c.

rememdies --

0) buy a new network card.

1) use the de4x5 driver instead.

2) use the older tulip driver 0.9.14.  download it from 
   http://sourceforge.net/projects/tulip/

if you go with 2, just download.  have /usr/src/linux be your linux
source (or a symlink to them).  go into tulip-0.9.14/src, make dep,
make.  then copy tulip.o into /lib/modules/2.[45].X/kernel/drivers/net/tulip
which replaces the kernels one.

best of luck.

-- 
J o h a n  K u l l s t a m
[kullstam@mediaone.net]
