Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267035AbTAZXDH>; Sun, 26 Jan 2003 18:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbTAZXDH>; Sun, 26 Jan 2003 18:03:07 -0500
Received: from [213.86.99.237] ([213.86.99.237]:15070 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267035AbTAZXDG>; Sun, 26 Jan 2003 18:03:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030126235646.GI394@kugai> 
References: <20030126235646.GI394@kugai>  <20030126232839.GF394@kugai> <20030126220842.GB394@kugai> <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <28922.1043617222@passion.cambridge.redhat.com> <30455.1043621199@passion.cambridge.redhat.com> 
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
Date: Sun, 26 Jan 2003 23:04:28 +0000
Message-ID: <30887.1043622268@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zander@minion.de said:
>  Since Linux 2.2 and including any specifics involved in the process
> of customizing CFLAGS, ...? If that's the case, I admit ignorance and
> ask that my earlier remarks be ignored.

imladris /home/dwmw2/working/mtd/drivers/mtd $ make LINUXDIR=/inst/linux/linux-2.2 CFLAGS_afs.o=-DFISH EXTRA_CFLAGS=-DTURNIP
make -C /inst/linux/linux-2.2 SUBDIRS=`pwd` modules
make[1]: Entering directory `/inst/linux/linux-2.2'
make -C  /home/dwmw2/working/mtd/drivers/mtd CFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE"
MAKING_MODULES=1 modules
make[2]: Entering directory `/home/dwmw2/working/mtd/drivers/mtd'
gcc296 -D__KERNEL__ -I/inst/linux/linux-2.2/include -I/home/dwmw2/working/mtd/drivers/mtd/../../include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DMODULE -DTURNIP -DFISH -DEXPORT_SYMTAB -c afs.c
make[2]: *** Deleting file `afs.o'
make[2]: *** [afs.o] Interrupt
make[1]: *** [_mod_/home/dwmw2/working/mtd/drivers/mtd] Interrupt
make: *** [modules] Interrupt





--
dwmw2


