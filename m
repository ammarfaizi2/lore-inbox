Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTAZWyN>; Sun, 26 Jan 2003 17:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTAZWyN>; Sun, 26 Jan 2003 17:54:13 -0500
Received: from [213.86.99.237] ([213.86.99.237]:10206 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267034AbTAZWyJ>; Sun, 26 Jan 2003 17:54:09 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030126231232.GE394@kugai> 
References: <20030126231232.GE394@kugai>  <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu> 
To: Christian Zander <zander@minion.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Jan 2003 22:55:49 +0000
Message-ID: <30633.1043621749@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zander@minion.de said:
> The problem isn't necessarily lack of flexibility, but the lack of
> unity across kernel versions. I agree that kbuild is the preferable
> solution for Linux 2.5, but it isn't for all incarnations of Linux 2.4
> and definetely not for Linux 2.2.

/me blinks... what's wrong with 2.2? Looks fine to me...

imladris /home/dwmw2/working/mtd/drivers/mtd $ make LINUXDIR=/inst/linux/linux-2.2
make -C /inst/linux/linux-2.2 SUBDIRS=`pwd` modules
make[1]: Entering directory `/inst/linux/linux-2.2'
make -C  /home/dwmw2/working/mtd/drivers/mtd CFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE"
MAKING_MODULES=1 modules
make[2]: Entering directory `/home/dwmw2/working/mtd/drivers/mtd'
gcc296 -D__KERNEL__ -I/inst/linux/linux-2.2/include -I/home/dwmw2/working/mtd/drivers/mtd/../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE   -DEXPORT_SYMTAB -c afs.c
{standard input}: Assembler messages:
{standard input}:9: Warning: ignoring changed section attributes for .modinfo
gcc296 -D__KERNEL__ -I/inst/linux/linux-2.2/include -I/home/dwmw2/working/mtd/drivers/mtd/../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE   -DEXPORT_SYMTAB -c mtdcore.cmake[2]: *** Deleting file `mtdcore.o'
make[2]: *** [mtdcore.o] Interrupt
make[1]: *** [_mod_/home/dwmw2/working/mtd/drivers/mtd] Interrupt
make: *** [modules] Interrupt





--
dwmw2


