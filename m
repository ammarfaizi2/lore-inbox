Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317712AbSFLOkn>; Wed, 12 Jun 2002 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317713AbSFLOkm>; Wed, 12 Jun 2002 10:40:42 -0400
Received: from gold.he.net ([216.218.149.2]:10512 "EHLO gold.he.net")
	by vger.kernel.org with ESMTP id <S317712AbSFLOkm>;
	Wed, 12 Jun 2002 10:40:42 -0400
Message-Id: <200206121440.HAA21382@gold.he.net>
Content-Type: text/plain; charset=US-ASCII
From: "J.S.Souza" <jssouza@pacbell.net>
Reply-To: jssouza@pacbell.net
To: xsdg <xsdg@openprojects.net>
Subject: Re: computer reboots before "Uncompressing Linux..." with 2.5.19-xfs
Date: Wed, 12 Jun 2002 07:40:14 -0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020612002229.A27386@216.254.117.126>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the exact same problem and few were able to help.  However, here's what 
I found was _my_ problem.  I wasn't enabling the x86 options in the kernel 
(duh!).  Make sure that when you compile, you enable "Intel IA32 CPU 
Microcode Support" and "Model Specific Register Support".  What I ended up 
doing was taking a stock RedHat .config file for i386 and looking at what 
they did for their options and started to delete things from there that I 
don't use or need.  Eventually, I just learned what was necessary for a basic 
i386 kernel.  Although I was compiling for 2.4.17 kernel.  Good luck, hope 
this was of some help.

			J.S.Souza

On Tuesday 11 June 2002 05:22 pm, xsdg wrote:
> Hola...
> I'm trying to get kernel 2.5.19-xfs working on one of my boxes...  The box
> is a P200-MMX, currently running 2.5.7-xfs and using grub as the
> bootloader.  Each time I try to boot the kernel, grub tells me...
>
> root (hd0,0)
>  Filesystem type is ext2fs, partition type 0x83
> kernel /boot/kernels/19.5.2k-xfs single
>  [Linux-bzImage, setup=0x1400, size=0x134aff]
>
> Then, after a small pause, the box reboots (note: it does _not_ print
> "Uncompressing Linux...").  I have tried the following:
> 1) Compile the kernel, optimized for P-MMX, on another box (PII-350
> Deschutes) using gcc 2.95.4
> 2) Recompile bzImage
> 3) Recompile bzImage
> 4) Remove framebuffer support.  Remove vid mode selection support. 
> Optimize for Pentium-Classic.  Recompile with everything else the same
> 5) Recompile on target box (gcc 2.95.4 also) with options the same as after
> #4
>
> All of my boxes are running Debian SID (not necessarily up-to-date).  I
> asked a number of times in #kernelnewbies on OPN, to no avail.  Any and all
> help would be greatly appreciated. (Please CC me in replies)
>
> 	--xsdg
