Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRLBQyv>; Sun, 2 Dec 2001 11:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282836AbRLBQyi>; Sun, 2 Dec 2001 11:54:38 -0500
Received: from [195.63.194.11] ([195.63.194.11]:36108 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282904AbRLBQyP>; Sun, 2 Dec 2001 11:54:15 -0500
Message-ID: <3C0A5A61.62A0F885@evision-ventures.com>
Date: Sun, 02 Dec 2001 17:44:17 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> I do not plan to submit this patch to Linus/Marcelo.
> 
> This patch applies an obvious technique to the kernel:  increase the
> amount of code compiled in a single compilation unit, to increase the
> overall knowledge the compiler has of the code, to allow for better
> optimization and dead code removal.  KDE does this, with definite
> success, though they definitely are not the first to do this.
> 
> Simply, all ext2 files are #include'd into a single file, ext2_all.c,
> and all functions and data structures are declared static.
> 
> This technique can be used in the kernel, userspace applications, and
> userspace libraries to decrease icache footprint and overall size of
> your applications.
> 
> Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
> vmlinux, simply from making all the functions static.
> (*.orig is prior to my patch.  kernel is P2 SMP-based)
> > [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
> > -rw-r--r--    1 jgarzik  jgarzik   1030259 Dec  2 06:18 arch/i386/boot/bzImage
> > -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
> > -rwxr-xr-x    1 jgarzik  jgarzik   2814631 Dec  2 06:18 vmlinux*
> > -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*
r

size vmlinux
and 
size vmlinux.orig

would be a bit more telling whatever the reaons of the impact is.
