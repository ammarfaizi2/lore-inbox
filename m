Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932868AbVIHBaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932868AbVIHBaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbVIHBaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:30:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932866AbVIHB3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:53 -0400
Message-Id: <20050908012854.721631000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@m1k.net>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 1/9] [PATCH] Kconfig: saa7134-dvb must select tda1004x
Content-Disposition: inline; filename=saa7134-dvb-must-select-tda1004x.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

I wish I had seen this before 2.6.13 was released... I guess this only 
goes to show that there haven't been any testers using saa7134-hybrid 
dvb/v4l boards that depend on the tda1004x module, during the 2.6.13-rc 
series :-(

Please apply this to 2.6.14, and also to 2.6.13.1 -stable.  Without this 
patch, users will have to EXPLICITLY select tda1004x in Kconfig.  This 
SHOULD be done automatically when saa7134-dvb is selected.  This patch 
corrects this problem.

saa7134-dvb must select tda1004x

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/media/video/Kconfig |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13.y/drivers/media/video/Kconfig
===================================================================
--- linux-2.6.13.y.orig/drivers/media/video/Kconfig
+++ linux-2.6.13.y/drivers/media/video/Kconfig
@@ -254,6 +254,7 @@ config VIDEO_SAA7134_DVB
 	select VIDEO_BUF_DVB
 	select DVB_MT352
 	select DVB_CX22702
+	select DVB_TDA1004X
 	---help---
 	  This adds support for DVB cards based on the
 	  Philips saa7134 chip.

--
