Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274495AbRJAClT>; Sun, 30 Sep 2001 22:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274496AbRJAClK>; Sun, 30 Sep 2001 22:41:10 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:24069 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S274495AbRJAClD>; Sun, 30 Sep 2001 22:41:03 -0400
Date: Mon, 1 Oct 2001 12:40:59 +1000
To: jgarzik@mandrakesoft.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Merging error in eeprom.c
Message-ID: <20011001124059.A21644@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes an error made presumably while merging from Donald Becker's
driver.
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/net/tulip/eeprom.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/tulip/eeprom.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 eeprom.c
--- drivers/net/tulip/eeprom.c	16 May 2001 17:25:39 -0000	1.1.1.6
+++ drivers/net/tulip/eeprom.c	1 Oct 2001 01:29:02 -0000
@@ -148,10 +148,10 @@
 		for (i = 0; i < count; i++) {
 			unsigned char media_block = *p++;
 			int media_code = media_block & MEDIA_MASK;
-			if (media_code & 0x40)
+			if (media_block & 0x40)
 				p += 6;
 			printk(KERN_INFO "%s:  21041 media #%d, %s.\n",
-				   dev->name, media_code & 15, medianame[media_code & 15]);
+				   dev->name, media_code, medianame[media_code]);
 		}
 	} else {
 		unsigned char *p = (void *)ee_data + ee_data[27];

--3MwIy2ne0vdjdPXF--
