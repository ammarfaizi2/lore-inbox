Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRDEG2X>; Thu, 5 Apr 2001 02:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDEG2N>; Thu, 5 Apr 2001 02:28:13 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:4361 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S131347AbRDEG1y>; Thu, 5 Apr 2001 02:27:54 -0400
Date: Thu, 5 Apr 2001 16:21:39 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: James Simmons <jsimmons@linux-fbdev.org>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More about 2.4.3 timer problems
In-Reply-To: <Pine.LNX.4.31.0104042004280.1580-100000@linux.local>
Message-ID: <Pine.LNX.4.21.0104051606440.4943-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, James Simmons wrote:

:
:>Err, tried the patch you recommended me to apply to the 2.4.3 source code
:>(not the 2.4.3-pre6), but everything else started complaining it couldn't
:>see printk() any more.  Any advice?  Thanks...
:
:Can you tell us your hardware configuration and your kernel configuration.

This has been mentioned in an earlier message of mine, but basically, I have a
Cyrix M-II machine, 32 meg of ram, 3.4 gig HD, PCI and ISA buses, SiS chipset,
etc etc.

:What do you mean it couldn't see printk any more?

What I meant was that while kernel/printk.c got compiled to printk.o, none of
the modules compiled could then see the function printk(); when I did a depmod
-ae, the unresolved function (and the ONLY function) they all complained about
was printk, even though it appeared in the System.Map file, (c0xxxx T printk)
and, presumably, in the kernel image as well.

I noted that the patch touched printk.c, so wondered what the patch had
done... and I really didn't want to have to compile everything into my kernel
just to get it to work... it's almost like it was a question of scope...

The patch did work to eliminate the clock skew, aside from this printk
problem, but fortunately I was bright enough to have kept an older kernel
tarball around, so I could go back to unpatched version. 

Thanks for keeping in touch... me not being much of a programmer, I can't just
get my hands dirty and fix the patch problem, otherwise, I'd do it.  But
knowing my luck, I'd end up with a kernel that worked six times faster than
anything previously, but wind up destroying the hard disk and CMOS in two
minutes fifteen point three seconds.  And set my monitor on fire too...

-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!

