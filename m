Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRCASnr>; Thu, 1 Mar 2001 13:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRCASnh>; Thu, 1 Mar 2001 13:43:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54030 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129771AbRCASnY>; Thu, 1 Mar 2001 13:43:24 -0500
Subject: Re: ld-error on 2.4.2 and on 2.4.1
To: flo.n@gmx.de (Florian Nykrin)
Date: Thu, 1 Mar 2001 18:46:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010301193558.A15361@castor.olydorf.swh.mhn.de> from "Florian Nykrin" at Mar 01, 2001 07:35:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YY65-0008Jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc -E -D__KERNEL__ -I/usr/src/linux/include -D__BIG_KERNEL__
> -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
> as -o bbootsect.o bbootsect.s
> bbootsect.s: Assembler messages:
> bbootsect.s:253: Warning: indirect lcall without `*'
> ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
> ld: cannot open binary: No such file or directory

Debian Sid currently includes a binutils that drops the option the kernel
uses. If you look through the archive you'll find a patch to do deal with
this, or you can just go back to a slightly older binutils

Also gcc 2.95.3 cvs snapshots aren't yet a recommended build tool for the 
kernel. They are probably ok though. I've had no evidence to suggest they
miscompile anything.

Alan

