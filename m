Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWEPSTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWEPSTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWEPSTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:19:24 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:2542
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932489AbWEPSTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:19:23 -0400
Subject: [PATCH] remove dead entry in net wan Makefile
From: Paul Fulghum <paulkf@microgate.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <446A0027.208@microgate.com>
References: <1147446494.10079.5.camel@amdx2.microgate.com>
	 <20060516160022.GD5677@stusta.de>  <446A0027.208@microgate.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 13:18:28 -0500
Message-Id: <1147803508.3510.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead entry in net wan Makefile.
Entry is left over from 2.4 when synclink used syncppp.
synclink drivers now use generic HDLC

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16/drivers/net/wan/Makefile	2006-03-19 23:53:29.000000000 -0600
+++ b/drivers/net/wan/Makefile	2006-05-16 13:13:36.000000000 -0500
@@ -36,7 +36,6 @@
 obj-$(CONFIG_FARSYNC)		+=		syncppp.o	farsync.o
 obj-$(CONFIG_DSCC4)             +=				dscc4.o
 obj-$(CONFIG_LANMEDIA)		+=		syncppp.o
-obj-$(CONFIG_SYNCLINK_SYNCPPP)	+=		syncppp.o
 obj-$(CONFIG_X25_ASY)		+= x25_asy.o
 
 obj-$(CONFIG_LANMEDIA)		+= lmc/


