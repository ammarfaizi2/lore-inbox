Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266720AbUGLFeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUGLFeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUGLFeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:34:18 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:7432 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S266720AbUGLFeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:34:16 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc] `unknown symbol' in drivers/scsi/pcmcia/fdomain_cs.ko
Date: Mon, 12 Jul 2004 07:34:16 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YLi8AzVlj014JaM"
Message-Id: <200407120734.16767.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YLi8AzVlj014JaM
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_memcpy_fromio
drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_readb

iirc the isa bus isn't available on ppc.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_YLi8AzVlj014JaM
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="fdomain_cs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fdomain_cs.patch"

--- linux-2.6.8-rc1/drivers/scsi/pcmcia/Kconfig.orig	2004-07-11 19:34:48.000000000 +0200
+++ linux-2.6.8-rc1/drivers/scsi/pcmcia/Kconfig	2004-07-12 07:29:54.297448056 +0200
@@ -17,7 +17,7 @@
 
 config PCMCIA_FDOMAIN
 	tristate "Future Domain PCMCIA support"
-	depends on m
+	depends on m && ISA
 	help
 	  Say Y here if you intend to attach this type of PCMCIA SCSI host
 	  adapter to your computer.

--Boundary-00=_YLi8AzVlj014JaM--
