Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291565AbSBUKCI>; Thu, 21 Feb 2002 05:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291449AbSBUJ7f>; Thu, 21 Feb 2002 04:59:35 -0500
Received: from AStrasbourg-201-2-1-226.abo.wanadoo.fr ([193.251.1.226]:52214
	"EHLO glacon.bureau.logidee.com") by vger.kernel.org with ESMTP
	id <S291473AbSBUJ7R>; Thu, 21 Feb 2002 04:59:17 -0500
Date: Thu, 21 Feb 2002 10:59:05 +0100
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] via-rhine for 2.5.5
Message-ID: <20020221095905.GA19625@logidee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
From: Stephane Casset <sept@logidee.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems that the following patch is necessary for via-rhine to compile.

--- drivers/net/via-rhine.c.orig	Thu Feb 21 10:49:54 2002
+++ drivers/net/via-rhine.c	Thu Feb 21 10:55:39 2002
@@ -1754,7 +1754,7 @@
 	name:		"via-rhine",
 	id_table:	via_rhine_pci_tbl,
 	probe:		via_rhine_init_one,
-	remove:		via_rhine_remove_one,
+	remove:		__devexit_p(via_rhine_remove_one),
 };
 
 
@@ -1768,7 +1768,7 @@
 }
 
 
-static void __exit via_rhine_cleanup (void)
+static void __devexit via_rhine_cleanup (void)
 {
 	pci_unregister_driver (&via_rhine_driver);
 }


Regards
-- 
Stéphane Casset           LOGIDÉE sàrl          Se faire plaisir d'apprendre
3, quai Kléber, Tour Sébastopol   Tel : +33 388 23 69 77  casset@logidee.com
F-67080 STRASBOURG Cedex 3        Fax : +33 388 23 70 00  http://logidee.com
