Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWCUWTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWCUWTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWCUWTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:19:54 -0500
Received: from havoc.gtf.org ([69.61.125.42]:22238 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965134AbWCUWTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:19:54 -0500
Date: Tue, 21 Mar 2006 17:19:49 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mchehab@infradead.org, abraham.manu@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix dvb build
Message-ID: <20060321221949.GA24322@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes 'allmodconfig' build in current git
(ec1248e70edc5cf7b485efcc7b41e44e10f422e5).

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/media/dvb/bt8xx/Makefile b/drivers/media/dvb/bt8xx/Makefile
index 9d197ef..d188e4c 100644
--- a/drivers/media/dvb/bt8xx/Makefile
+++ b/drivers/media/dvb/bt8xx/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o dst_ca.o
 
-EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video/bt8xx -Idrivers/media/dvb/frontends
+EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video -Idrivers/media/dvb/frontends
