Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbSLODcn>; Sat, 14 Dec 2002 22:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSLODcm>; Sat, 14 Dec 2002 22:32:42 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:10512 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266233AbSLODcm>; Sat, 14 Dec 2002 22:32:42 -0500
Date: Sun, 15 Dec 2002 14:39:42 +1100
To: dwmw2@redhat.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sc520cdp depends on mtdconcat
Message-ID: <20021215033942.GA12987@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch makes that dependency explicit.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/mtd/maps/Config.in
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/mtd/maps/Config.in,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 Config.in
--- drivers/mtd/maps/Config.in	28 Nov 2002 23:53:13 -0000	1.1.1.5
+++ drivers/mtd/maps/Config.in	15 Dec 2002 03:37:56 -0000
@@ -19,7 +19,7 @@
 
 if [ "$CONFIG_X86" = "y" ]; then
    dep_tristate '  CFI Flash device mapped on Photron PNC-2000' CONFIG_MTD_PNC2000 $CONFIG_MTD_CFI $CONFIG_MTD_PARTITIONS
-   dep_tristate '  CFI Flash device mapped on AMD SC520 CDP' CONFIG_MTD_SC520CDP $CONFIG_MTD_CFI
+   dep_tristate '  CFI Flash device mapped on AMD SC520 CDP' CONFIG_MTD_SC520CDP $CONFIG_MTD_CFI $CONFIG_MTD_CONCAT
    dep_tristate '  CFI Flash device mapped on AMD NetSc520'  CONFIG_MTD_NETSC520 $CONFIG_MTD_CFI $CONFIG_MTD_PARTITIONS
    dep_tristate '  CFI Flash device mapped on Arcom SBC-GXx boards' CONFIG_MTD_SBC_GXX $CONFIG_MTD_CFI_INTELEXT $CONFIG_MTD_PARTITIONS
    dep_tristate '  CFI Flash device mapped on Arcom ELAN-104NC' CONFIG_MTD_ELAN_104NC $CONFIG_MTD_CFI_INTELEXT $CONFIG_MTD_PARTITIONS

--VbJkn9YxBvnuCH5J--
