Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJZNAq>; Sat, 26 Oct 2002 09:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261372AbSJZNAq>; Sat, 26 Oct 2002 09:00:46 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:34222 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261356AbSJZNAp>;
	Sat, 26 Oct 2002 09:00:45 -0400
Date: Sat, 26 Oct 2002 15:07:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] de-cryptify ide-disk host protected area output
Message-ID: <20021026130701.GA29860@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Useless number '1' being printed leading to operator confusion.

--- linux-2.5.44/drivers/ide/ide-disk.c~orig	Sat Oct 26 14:59:35 2002
+++ linux-2.5.44/drivers/ide/ide-disk.c	Sat Oct 26 15:00:40 2002
@@ -1128,7 +1128,7 @@
 {
 	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
 	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
+		printk("%s: supports host protected area", drive->name);
 	return flag;
 }
 


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
