Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbSJFGTx>; Sun, 6 Oct 2002 02:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSJFGTx>; Sun, 6 Oct 2002 02:19:53 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:33030 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S263341AbSJFGTw>; Sun, 6 Oct 2002 02:19:52 -0400
Date: Sun, 6 Oct 2002 16:25:07 +1000
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] AIC7XXX 6.2.8 oops in aha2840_load_seeprom
Message-ID: <20021006062507.GA19826@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This buglet crept in around AIC7XXX 6.2.8 which is included in Linux 2.4.19.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: aic7770.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/scsi/aic7xxx/aic7770.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 aic7770.c
--- aic7770.c	3 Aug 2002 00:39:44 -0000	1.1.1.5
+++ aic7770.c	6 Oct 2002 06:14:17 -0000
@@ -273,8 +273,8 @@
 
 	if (bootverbose)
 		printf("%s: Reading SEEPROM...", ahc_name(ahc));
-	have_seeprom = ahc_read_seeprom(&sd, (uint16_t *)&sc,
-					/*start_addr*/0, sizeof(sc)/2);
+	have_seeprom = ahc_read_seeprom(&sd, (uint16_t *)sc,
+					/*start_addr*/0, sizeof(*sc)/2);
 
 	if (have_seeprom) {
 

--17pEHd4RhPHOinZp--
