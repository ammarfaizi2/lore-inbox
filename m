Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290969AbSBLLqh>; Tue, 12 Feb 2002 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290974AbSBLLq1>; Tue, 12 Feb 2002 06:46:27 -0500
Received: from mail.turbolinux.co.jp ([210.171.55.67]:21772 "EHLO
	mail.turbolinux.co.jp") by vger.kernel.org with ESMTP
	id <S290969AbSBLLqK>; Tue, 12 Feb 2002 06:46:10 -0500
Date: Tue, 12 Feb 2002 20:44:52 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 8139too Allied Telesyn's 8139 compatible CadBus
Message-Id: <20020212204452.541db02d.go@turbolinux.co.jp>
Organization: Turbolinux
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is Allied Telesyn's 8139 compatible CadBus ethernet patch.
Japanese vendor, Melco and IO-data use this chip.
Status is completed.

Please apply it.

--- linux/drivers/net/8139too.c.orig	Sun Feb 10 15:31:47 2002
+++ linux/drivers/net/8139too.c	Sun Feb 10 15:34:23 2002
@@ -216,6 +216,7 @@
 	DFE538TX,
 	DFE690TXD,
 	FE2000VX,
+	ALLIED8139,
 	RTL8129,
 } board_t;
 
@@ -234,6 +235,7 @@
 	{ "D-Link DFE-538TX (RealTek RTL8139)", RTL8139_CAPS },
 	{ "D-Link DFE-690TXD (RealTek RTL8139)", RTL8139_CAPS },
 	{ "AboCom FE2000VX (RealTek RTL8139)", RTL8139_CAPS },
+	{ "Allied Telesyn 8139 CardBus", RTL8139_CAPS },
 	{ "RealTek RTL8129", RTL8129_CAPS },
 };
 
@@ -248,6 +250,7 @@
 	{0x1186, 0x1300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DFE538TX },
 	{0x1186, 0x1340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DFE690TXD },
 	{0x13d1, 0xab06, PCI_ANY_ID, PCI_ANY_ID, 0, 0, FE2000VX },
+	{0x1259, 0xa117, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ALLIED8139 },
 
 #ifdef CONFIG_8139TOO_8129
 	{0x10ec, 0x8129, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RTL8129 },
