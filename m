Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316252AbSEZSe0>; Sun, 26 May 2002 14:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSEZSeY>; Sun, 26 May 2002 14:34:24 -0400
Received: from [195.39.17.254] ([195.39.17.254]:63387 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316252AbSEZSdd>;
	Sun, 26 May 2002 14:33:33 -0400
Date: Sun, 26 May 2002 20:30:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: trivial: eepro100 Extra prototype does not hurt; ifdefs do.
Message-ID: <20020526183019.GA9720@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Extra prototype does not hurt; ifdefs do. 

									Pavel

--- clean/drivers/net/eepro100.c	Wed Apr 24 23:06:40 2002
+++ linux-swsusp/drivers/net/eepro100.c	Fri May  3 00:08:35 2002
@@ -524,10 +524,8 @@
 static int eepro100_init_one(struct pci_dev *pdev,
 		const struct pci_device_id *ent);
 static void eepro100_remove_one (struct pci_dev *pdev);
-#ifdef CONFIG_PM
 static int eepro100_suspend (struct pci_dev *pdev, u32 state);
 static int eepro100_resume (struct pci_dev *pdev);
-#endif
 
 static int do_eeprom_cmd(long ioaddr, int cmd, int cmd_len);
 static int mdio_read(long ioaddr, int phy_id, int location);


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
