Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLPU2W>; Sat, 16 Dec 2000 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLPU2L>; Sat, 16 Dec 2000 15:28:11 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:40349 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S129348AbQLPU2F>;
	Sat, 16 Dec 2000 15:28:05 -0500
Date: Sat, 16 Dec 2000 20:45:19 +0100 (CET)
From: kees <kees@schoen.nl>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Dima Brodsky <dima@cs.ubc.ca>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Sound (emu10k1) broken in 2.2.18
In-Reply-To: <20001216105823.H3199@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012162042310.3635-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

In _my_ case I compiled the EMU10K straight into the kernel.
dmesg shows it's found. The funny thing is that a second machine with an
es1371 board alos fails with 2.2.18.

2.2.17 is ok. Taking that .config and 'make oldconfig' produces a kernel
that doesnt allow the emu10k to work. (as for the es1371).

Kees


On Sat, 16 Dec 2000, Peter Samuelson wrote:

> 
> [Dima Brodsky]
> > 	cat x > /dev/dsp
> 
> > 	bash: /dev/dsp: No such device
> > 
> > But an ls -l shows:
> > 
> > crw-rw-rw-   1 root     sys       14,   3 Dec 15 21:25 dsp
> > crw-rw-rw-   1 root     sys       14,  19 Dec 15 21:25 dsp1
> 
> 'ls -l' is useless, here.  Sure the device files exist, but bash is
> telling you that, kernel-side, they are not connected to anything.
> 
> - Do you have emu10k1 compiled in, or as a module?
> - Does your SBLive appear to have been detected?  (Check 'dmesg')
> - If emu10k1 is a module, is the module loaded?  Does it seem to detect
>   your SBLive when loaded?  (Again check 'dmesg')
> 
> Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
