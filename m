Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSLJGAm>; Tue, 10 Dec 2002 01:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbSLJGAm>; Tue, 10 Dec 2002 01:00:42 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:762 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266615AbSLJGAk>; Tue, 10 Dec 2002 01:00:40 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15861.33380.298591.730830@sofia.bsd2.kbnes.nec.co.jp>
Date: Tue, 10 Dec 2002 14:57:56 +0900
To: linux-kernel@vger.kernel.org
Cc: James Simmons <jsimmons@infradead.org>
Subject: 2.5.51 - drivers/ide/pci/nvidia.c is broken
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc-3.2 -Wp,-MD,drivers/ide/pci/.nvidia.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE -Idrivers/ide  -DKBUILD_BASENAME=nvidia -DKBUILD_MODNAME=nvidia   -c -o drivers/ide/pci/nvidia.o drivers/ide/pci/nvidia.c
In file included from drivers/ide/pci/nvidia.c:29:
drivers/ide/pci/nvidia.h:35: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared here (not in a function)
 ...

This symbol was removed from pci_ids.h when other NVIDIA symbols were
added.  Was that a typo?

--- linus-2.5/include/linux/pci_ids.h.orig	Tue Dec 10 12:39:12 2002
+++ linus-2.5/include/linux/pci_ids.h	Tue Dec 10 14:39:19 2002
@@ -946,6 +946,7 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL	0x017B
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL	0x017C
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202

