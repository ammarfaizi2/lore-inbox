Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWF3MQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWF3MQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWF3MQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:16:53 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:8074 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932214AbWF3MQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:16:52 -0400
Date: Fri, 30 Jun 2006 14:16:51 +0200
From: Ingo van Lil <inguin@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/block/nbd.c compile fix
Message-ID: <20060630121651.GA12530@csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.2 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: f63ec78c36006dbd9f08cecca336b949
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

the Network Block Device driver doesn't compile if NDEBUG is defined.

Cheers,
Ingo

Signed-off-by: Ingo van Lil <inguin@gmx.de>
---

--- linux-2.6.16/drivers/block/nbd.c.orig	2006-06-30 12:34:13.000000000 +0200
+++ linux-2.6.16/drivers/block/nbd.c	2006-06-30 12:34:28.000000000 +0200
@@ -82,9 +82,9 @@
 #define DBG_RX          0x0200
 #define DBG_TX          0x0400
 static unsigned int debugflags;
-static unsigned int nbds_max = 16;
 #endif /* NDEBUG */
 
+static unsigned int nbds_max = 16;
 static struct nbd_device nbd_dev[MAX_NBD];
 
 /*

