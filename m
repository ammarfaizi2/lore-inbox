Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUDPWWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbUDPWTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:19:48 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:16905 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263920AbUDPWRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:17:03 -0400
Date: Sat, 17 Apr 2004 08:16:34 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CPQPHP] Fix build without hotplug
Message-ID: <20040416221634.GA15721@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch makes cpqphp build without procfs.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/hotplug/Makefile
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/hotplug/Makefile,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 Makefile
--- a/drivers/hotplug/Makefile	30 Aug 2003 06:01:37 -0000	1.1.1.5
+++ b/drivers/hotplug/Makefile	16 Apr 2004 22:16:13 -0000
@@ -18,7 +18,6 @@
 
 cpqphp-objs		:=	cpqphp_core.o	\
 				cpqphp_ctrl.o	\
-				cpqphp_proc.o	\
 				cpqphp_pci.o
 
 ibmphp-objs		:=	ibmphp_core.o	\
@@ -36,6 +35,10 @@
 	cpqphp-objs += cpqphp_nvram.o
 endif
 
+ifeq ($(CONFIG_PROC_FS),y)
+	cpqphp-objs += cpqphp_proc.o
+endif
+
 
 include $(TOPDIR)/Rules.make
 

--qDbXVdCdHGoSgWSk--
