Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135851AbREFVC3>; Sun, 6 May 2001 17:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135854AbREFVCS>; Sun, 6 May 2001 17:02:18 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:17928 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135851AbREFVCH>; Sun, 6 May 2001 17:02:07 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105062102.XAA24819@green.mif.pg.gda.pl>
Subject: [PATCH] for cp1255
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 6 May 2001 23:02:02 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  The following patch fixes a bug in UTF8->CP1255 translation.


--- linux-2.4.4-ac5/fs/nls/nls_cp1255.c	Sat Apr 28 20:35:03 2001
+++ linux/fs/nls/nls_cp1255.c	Sun May  6 22:33:19 2001
@@ -254,7 +254,7 @@
 };
 
 static unsigned char *page_uni2charset[256] = {
-	page00, NULL,   NULL,   NULL,   NULL,   page05, NULL,   NULL,   
+	page00, page01, page02, NULL,   NULL,   page05, NULL,   NULL,   
 	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
 	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   
 	NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
