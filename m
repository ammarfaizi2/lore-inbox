Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSF3O3G>; Sun, 30 Jun 2002 10:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSF3O3G>; Sun, 30 Jun 2002 10:29:06 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:13487 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S315198AbSF3O3F>;
	Sun, 30 Jun 2002 10:29:05 -0400
Date: Sat, 29 Jun 2002 16:06:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arnaud Launay <asl@launay.org>, kernel list <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: eepro100 warning fix
Message-ID: <20020629140646.GA368@elf.ucw.cz>
References: <20020603074242.GA9494@launay.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020603074242.GA9494@launay.org>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I killed #ifdef, and introduced warning. This fixes it. Please apply,
									Pavel


> In 2.5.20, one could read:
> <pavel@ucw.cz>
>         eepro100 net driver trivial cleanup:
>         Extra prototype does not hurt; ifdefs do.
...
> eepro100.c:527: warning: `eepro100_suspend' declared `static' but never defined
> eepro100.c:528: warning: `eepro100_resume' declared `static' but never defined

--- linux-swsusp.test/drivers/net/eepro100.c	Mon Jun  3 11:43:33 2002
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
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
