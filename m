Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264784AbRFXVtk>; Sun, 24 Jun 2001 17:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbRFXVta>; Sun, 24 Jun 2001 17:49:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2057 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264784AbRFXVtS>; Sun, 24 Jun 2001 17:49:18 -0400
Subject: Re: Some experience of linux on a Laptop
To: pzycrow@hotmail.com (John Nilsson)
Date: Sun, 24 Jun 2001 22:48:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com> from "John Nilsson" at Jun 24, 2001 10:51:56 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15EHkU-0000Wu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Features I would like in the kernel:
> 1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
> trigged before rootmount.

Already there. In fact Red Hat uses it for the scsi devices. That is what
initrd is for. 

> 2: Compile time optimization options in Make menuconfig

such as ?

> 3: Lilo/grub config in make menuconfig

make bzlilo does the lilo install - what else would you expect there

> 4: make bzImage && make modules && make modules install && cp 
> arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig

So really you want an outside GUI tool that lets you reconfigure build and
install kernels. Yeah I'd agree with that. Someone just needs to write the
killer gnome/kde config tool. I've got C code for parsing/loading config.in
files and deducing the dependancy constraints if anyone ever wants to try
and write such a tool 8)

> 5: Better support for toshiba computers... well try =)

modprobe toshiba and look at http://www.buzzard.org.uk/toshiba/

> 6: Wouldn't it be easier for svgalib/framebuffer/GGI/X11 and others if the 
> graphiccard drivers where kernel modules?

No. 

> 8: A way to change kernel without rebooting. I have no diskdrive or cddrive 
> in my laptop so I often do drastic things when I install a new distribution.

Thats actually an incredibly hard problem to solve. The only people who do
this level of stuff are some of the telephony folks, and the expensive 
tandem non-stop boxes.

Alan

