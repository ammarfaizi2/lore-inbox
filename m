Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSFKBar>; Mon, 10 Jun 2002 21:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSFKBaq>; Mon, 10 Jun 2002 21:30:46 -0400
Received: from zok.SGI.COM ([204.94.215.101]:46752 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316579AbSFKBap>;
	Mon, 10 Jun 2002 21:30:45 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.21 no source for several objects
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 11:30:39 +1000
Message-ID: <8028.1023759039@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These objects are referenced in makefiles but no source exists.

arch/i386/kernel/Makefile
obj-$(CONFIG_EISA)              += eisa.o

drivers/acorn/char/Makefile
obj-$(CONFIG_L7200_KEYB)        += defkeymap-l7200.o keyb_l7200.o - no source for keyb_l7200.o

drivers/char/Makefile
obj-$(CONFIG_SERIAL_SA1100) += serial_sa1100.o

drivers/mtd/chips/Makefile
obj-$(CONFIG_MTD_INTELPROBE)    += intel_probe.o

drivers/net/Makefile
obj-$(CONFIG_VETH) += veth.o

drivers/video/Makefile
obj-$(CONFIG_FBCON_IPLAN2P16)     += fbcon-iplan2p16.o

fs/nls/Makefile
obj-$(CONFIG_NLS_ISO8859_10)    += nls_iso8859-10.o
obj-$(CONFIG_NLS_ABC)           += nls_abc.o

net/decnet/Makefile
decnet-$(CONFIG_DECNET_FW) += dn_fw.o

net/sched/Makefile
obj-$(CONFIG_NET_SCH_HPFQ)      += sch_hpfq.o
obj-$(CONFIG_NET_SCH_HFSC)      += sch_hfsc.o

None of these were picked up by the existing build system, they were
all detected by kbuild 2.5.  This is one of the advantages of having a
build system that knows about everything.

