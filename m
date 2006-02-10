Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWBJK1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWBJK1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWBJK0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:26:46 -0500
Received: from mail22.bluewin.ch ([195.186.19.66]:49386 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1751224AbWBJK0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:26:44 -0500
Cc: Arthur Othieno <apgo@patchbomb.org>, p_gortmaker@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: remove CONFIG_NET_CBUS conditional for NS8390
In-Reply-To: <11395671853420-git-send-email-apgo@patchbomb.org>
X-Mailer: git-send-email
Date: Fri, 10 Feb 2006 05:26:26 -0500
Message-Id: <1139567186923-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: apgo@patchbomb.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bother testing for CONFIG_NET_CBUS ("NEC PC-9800 C-bus cards");
it went out with the rest of PC98 subarch.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 drivers/net/8390.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

6eca48257ddfe560447fda2c0c1961d78b06a047
diff --git a/drivers/net/8390.h b/drivers/net/8390.h
index 599b68d..51e39dc 100644
--- a/drivers/net/8390.h
+++ b/drivers/net/8390.h
@@ -134,7 +134,7 @@ struct ei_device {
 #define inb_p(_p)	inb(_p)
 #define outb_p(_v,_p)	outb(_v,_p)
 
-#elif defined(CONFIG_NET_CBUS) || defined(CONFIG_NE_H8300) || defined(CONFIG_NE_H8300_MODULE)
+#elif defined(CONFIG_NE_H8300) || defined(CONFIG_NE_H8300_MODULE)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #else
 #define EI_SHIFT(x)	(x)
-- 
1.1.5


