Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSGINIk>; Tue, 9 Jul 2002 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGINIj>; Tue, 9 Jul 2002 09:08:39 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:22763 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315213AbSGINIi>; Tue, 9 Jul 2002 09:08:38 -0400
Date: Tue, 9 Jul 2002 05:20:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Kill warning I introduces in eepro100
Message-ID: <20020709032040.GA8081@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I introduced warning about 3 releases ago. This prototypes are
actually unneccessary and killing them makes warning go away. Please
apply,

								Pavel

--- clean/drivers/net/eepro100.c	Mon Jun  3 11:43:33 2002
+++ linux-swsusp/drivers/net/eepro100.c	Sat Jun 29 15:58:45 2002
@@ -524,8 +524,6 @@
 static int eepro100_init_one(struct pci_dev *pdev,
 		const struct pci_device_id *ent);
 static void eepro100_remove_one (struct pci_dev *pdev);
-static int eepro100_suspend (struct pci_dev *pdev, u32 state);
-static int eepro100_resume (struct pci_dev *pdev);
 
 static int do_eeprom_cmd(long ioaddr, int cmd, int cmd_len);
 static int mdio_read(long ioaddr, int phy_id, int location);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
