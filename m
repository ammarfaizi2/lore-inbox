Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSFLAjr>; Tue, 11 Jun 2002 20:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317280AbSFLAjr>; Tue, 11 Jun 2002 20:39:47 -0400
Received: from drtalus.aoe.vt.edu ([128.173.167.12]:42758 "EHLO
	drtalus.aoe.vt.edu") by vger.kernel.org with ESMTP
	id <S317279AbSFLAjp>; Tue, 11 Jun 2002 20:39:45 -0400
Message-Id: <200206120037.g5C0bFd18677@drtalus.aoe.vt.edu>
To: linux-kernel@vger.kernel.org
cc: xsdg <xsdg@openprojects.net>
Subject: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs 
In-Reply-To: Your message of "Wed, 12 Jun 2002 00:22:29 -0000."
             <20020612002229.A27386@216.254.117.126> 
Date: Tue, 11 Jun 2002 20:37:12 -0400
From: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020612002229.A27386@216.254.117.126>, xsdg writes:
>Then, after a small pause, the box reboots (note: it does _not_ print
>"Uncompressing Linux...").  I have tried the following:

Interesting problem.....  Interesting because I'm having the EXACT
SAME PROBLEM!!!!  ARRRRRGGGGHHH!!!!

(pause)

.... well, almost.  Mine doesn't reboot, it just hangs at the exact
same point where yours reboots on ANY kernel 2.4.0 and later.

The closest thing I found was a reply to a post from 1999 where a person
was having the kernel (or boot loader?) hang right before it uncompresses.
The reply was:

>I have a feeling that its the empty_8042 routine in arch/i386/boot/setup.S
>that's causing you problems.... without a keyboard attached, some
>controllers will hang there, sadly. If you feel brave, take a look in
>setup.S around lines 598 (where we enable a20) and 783 (the empty_8042
>routine itself)  and see if you can get rid of those calls to empty_8042
>or otherwise screw around in there so that it doesn't wait forever to
>empty the controller's buffers.

>1) Compile the kernel, optimized for P-MMX, on another box (PII-350 Deschutes)
>   using gcc 2.95.4

Have you tried building for a generic i386 target processor?

>2) Recompile bzImage
>3) Recompile bzImage

Well, if it didn't work the first time....   :)

>4) Remove framebuffer support.  Remove vid mode selection support.  Optimize
>   for Pentium-Classic.  Recompile with everything else the same
>5) Recompile on target box (gcc 2.95.4 also) with options the same as after #4

I'm inclined to think none of this ha anything to do with it, because
the kernel in which all of these items reside is never booting up...

My problem persisted despite my building a buck-naked 2.4.18 kernel.
It had no ANYTHING in it (not even module support) and was just 250K.
The results were the same.

I'm betting on a problem with the boot loader or bios incompatibility.
My machine has a PhoenixBios (4.06 I think-- I'll check tomorrow).
What does your machine have?

Regards,
Cengiz
