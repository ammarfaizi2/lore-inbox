Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSAHX1J>; Tue, 8 Jan 2002 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288565AbSAHX1A>; Tue, 8 Jan 2002 18:27:00 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:41993 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S288557AbSAHX0v>; Tue, 8 Jan 2002 18:26:51 -0500
Date: Wed, 9 Jan 2002 00:26:49 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [Patch] My compile fixes for 2.5.2-pre10
Message-ID: <20020108232649.GA9679@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need these two patches for 2.5.2-pre10 to compile.

Please aply,
Patrick

diff -u -r linux-2.5.2-10/drivers/char/serial.c work-2.5.2-10/drivers/char/serial.c
--- linux-2.5.2-10/drivers/char/serial.c	Sat Jan  5 17:25:19 2002
+++ work-2.5.2-10/drivers/char/serial.c	Tue Jan  8 23:59:57 2002
@@ -4481,7 +4481,7 @@
 	return 0;
 }
 
-static void __devexit serial_remove_one(struct pci_dev *dev)
+static void serial_remove_one(struct pci_dev *dev)
 {
 	int	i;
 
diff -u -r linux-2.5.2-10/drivers/net/eepro100.c work-2.5.2-10/drivers/net/eepro100.c
--- linux-2.5.2-10/drivers/net/eepro100.c	Fri Nov 23 21:05:25 2001
+++ work-2.5.2-10/drivers/net/eepro100.c	Tue Jan  8 23:53:38 2002
@@ -2239,7 +2239,7 @@
 }
 #endif /* CONFIG_PM */
 
-static void __devexit eepro100_remove_one (struct pci_dev *pdev)
+static void eepro100_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;

