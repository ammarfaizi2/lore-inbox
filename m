Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbRGKJ5b>; Wed, 11 Jul 2001 05:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbRGKJ5V>; Wed, 11 Jul 2001 05:57:21 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:31498 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S267268AbRGKJ5D>;
	Wed, 11 Jul 2001 05:57:03 -0400
Date: Wed, 11 Jul 2001 11:56:41 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH 2.4.6-any] ISDN TurboPam driver fix.
Message-ID: <20010711115641.E31044@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small attached patch fixes a showstopper bug in the TurboPam
ISDN driver. The patch applies to 2.4.7-pre kernels as well as
-ac kernels.

Linus, Alan, please apply.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.6-ac2.orig/drivers/isdn/tpam/tpam_main.c linux-2.4.6-ac2/drivers/isdn/tpam/tpam_main.c
--- linux-2.4.6-ac2.orig/drivers/isdn/tpam/tpam_main.c	Mon Jul  2 23:07:55 2001
+++ linux-2.4.6-ac2/drivers/isdn/tpam/tpam_main.c	Mon Jul  9 12:42:46 2001
@@ -148,7 +148,8 @@
 	card->interface.features = 
 		ISDN_FEATURE_P_EURO |
 		ISDN_FEATURE_L2_HDLC |
-		ISDN_FEATURE_L2_MODEM;
+		ISDN_FEATURE_L2_MODEM |
+		ISDN_FEATURE_L3_TRANS;
 	card->interface.hl_hdrlen = 0;
 	card->interface.command = tpam_command;
 	card->interface.writebuf_skb = tpam_writebuf_skb;
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
