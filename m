Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIFToR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 15:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbTIFToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 15:44:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41721 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261352AbTIFToN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 15:44:13 -0400
Date: Sat, 6 Sep 2003 21:44:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Domen Puncer <domen@coderock.org>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [-mm patch] fix IDE pdc4030.c compile
Message-ID: <20030906194404.GG14436@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init-exit-cleanups.patch in 2.6.0-test4-mm6 made ide_probe_for_pdc4030 
in drivers/ide/legacy/pdc4030.c static although it's referenced from 
drivers/ide/ide.c resulting in a link error.

The following patch fixes it:

--- linux-2.6.0-test4-mm6/drivers/ide/legacy/pdc4030.c.old	2003-09-06 21:28:20.000000000 +0200
+++ linux-2.6.0-test4-mm6/drivers/ide/legacy/pdc4030.c	2003-09-06 21:28:40.000000000 +0200
@@ -297,7 +297,7 @@
 }
 
 
-static int __init ide_probe_for_pdc4030(void)
+int __init ide_probe_for_pdc4030(void)
 {
 	unsigned int	index;
 	ide_hwif_t	*hwif;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

