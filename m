Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262654AbTDAVyd>; Tue, 1 Apr 2003 16:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262866AbTDAVyd>; Tue, 1 Apr 2003 16:54:33 -0500
Received: from 147.catv45.aar01.lan.ch ([212.60.45.147]:39691 "EHLO
	bolli.homeip.net") by vger.kernel.org with ESMTP id <S262654AbTDAVyc>;
	Tue, 1 Apr 2003 16:54:32 -0500
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 2 Apr 2003 00:05:40 +0200
From: "Beat Bolli" <bbolli@ymail.ch>
Message-ID: <000b01c2f89a$d5eb12c0$020ba8c0@bolli>
MIME-Version: 1.0
Subject: [2.4.21-pre7] Missing PCI-IDs for Intel 82801[DE]B
To: <linux-kernel@vger.kernel.org>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.0.6
	 at bolli.homeip.net has not found any known virus in this email.
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
X-MSMail-Priority: Normal
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After pulling the very fresh -pre7 from bk, I get the following errors in
drivers/ide/pci/piix.c:

make[4]: Entering directory `/home/bb/src/kernel/linux-2.4/drivers/ide/pci'
gcc-2.95 -D__KERNEL__ -I/home/bb/src/kernel/linux-2.4/include -Wall -Wstrict
-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame
-pointer -pipe -mpreferred-stack-boundary=2 -march=i586  -I../ -nostdinc -iw
ithprefix include -DKBUILD_BASENAME=piix  -c -o piix.o piix.c
In file included from piix.c:107:
piix.h:254: `PCI_DEVICE_ID_INTEL_82801EB_11' undeclared here (not in a
function)
piix.h:254: initializer element is not constant
piix.h:254: (near initialization for `piix_pci_info[15].device')
piix.h:282: `PCI_DEVICE_ID_INTEL_82801DB_10' undeclared here (not in a
function)
piix.h:282: initializer element is not constant
piix.h:282: (near initialization for `piix_pci_info[17].device')
piix.c: In function `piix_get_info':
piix.c:149: `PCI_DEVICE_ID_INTEL_82801DB_10' undeclared (first use in this
function)
piix.c:149: (Each undeclared identifier is reported only once
piix.c:149: for each function it appears in.)
piix.c:151: `PCI_DEVICE_ID_INTEL_82801EB_11' undeclared (first use in this
function)
piix.c: In function `piix_ratemask':
piix.c:284: `PCI_DEVICE_ID_INTEL_82801DB_10' undeclared (first use in this
function)
piix.c:286: `PCI_DEVICE_ID_INTEL_82801EB_11' undeclared (first use in this
function)
piix.c: In function `init_chipset_piix':
piix.c:612: `PCI_DEVICE_ID_INTEL_82801DB_10' undeclared (first use in this
function)
piix.c:614: `PCI_DEVICE_ID_INTEL_82801EB_11' undeclared (first use in this
function)
piix.c: At top level:
piix.c:803: `PCI_DEVICE_ID_INTEL_82801EB_11' undeclared here (not in a
function)
piix.c:803: initializer element is not constant
piix.c:803: (near initialization for `piix_pci_tbl[15].device')
piix.c:805: `PCI_DEVICE_ID_INTEL_82801DB_10' undeclared here (not in a
function)
piix.c:805: initializer element is not constant
piix.c:805: (near initialization for `piix_pci_tbl[17].device')
make[4]: *** [piix.o] Error 1
make[4]: Leaving directory `/home/bb/src/kernel/linux-2.4/drivers/ide/pci'

The device ids in question are missing from include/linux/pci_ids.h.

What I find in drivers/pci/pci.ids is this:

        24c0  82801DB ISA Bridge (LPC)
        24c2  82801DB USB (Hub #1)
        24c3  82801DB SMBus
        24c4  82801DB USB (Hub #2)
        24c5  82801DB AC'97 Audio
        24c6  82801DB AC'97 Modem
        24c7  82801DB USB (Hub #3)
        24cb  82801DB ICH4 IDE
        24cd  82801DB USB EHCI Controller

but no entries for 82801EB. Is pci_ids.h auto-generated from pci.ids?

Thanks

Beat Bolli

