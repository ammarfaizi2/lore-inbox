Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVIDX3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVIDX3y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVIDX3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:29:54 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:22401 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932066AbVIDX3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:53 -0400
Message-Id: <20050904232316.988350000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:02 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-no-empty-built-in_o.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 03/54] avoid building empty built-in.o
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't build empty built-in.o when DVB/V4L is not configured.
Thanks to Sam Ravnborg and Keith Owens.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.13-git4.orig/drivers/media/Makefile	2005-09-04 22:24:24.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/Makefile	2005-09-04 22:27:51.000000000 +0200
@@ -2,4 +2,7 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := video/ radio/ dvb/ common/
+obj-y := common/
+obj-$(CONFIG_VIDEO_DEV) += video/
+obj-$(CONFIG_VIDEO_DEV) += radio/
+obj-$(CONFIG_DVB)       += dvb/

--

