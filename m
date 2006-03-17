Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWCQU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWCQU6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWCQU6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:58:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932191AbWCQU5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:33 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ian Pickworth <ian@pickworth.me.uk>,
       Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/21] Fix cx88 error messages on balance change
Date: Fri, 17 Mar 2006 17:54:33 -0300
Message-id: <20060317205432.PS92743100002@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ian Pickworth <ian@pickworth.me.uk>
Date: 1141916620 \-0300

There is an error in the cx88 code that causes this message in the syslog when
balance is changed at full volume:
Mar  4 18:35:08 ian2 kernel: cx88[0]: irq pci [0x1] vid*
Mar  4 18:35:39 ian2 last message repeated 348 times
Mar  4 18:36:01 ian2 last message repeated 564 times
... and so on
The attached patch cures this problem.

Signed-off-by: Ian Pickworth <ian@pickworth.me.uk>
Signed-off-by: Marcin Rudowski <mar_rud@poczta.onet.pl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cx88/cx88.h b/drivers/media/video/cx88/cx88.h
index e9fd55b..613d227 100644
--- a/drivers/media/video/cx88/cx88.h
+++ b/drivers/media/video/cx88/cx88.h
@@ -62,7 +62,7 @@
 /* need "shadow" registers for some write-only ones ... */
 #define SHADOW_AUD_VOL_CTL           1
 #define SHADOW_AUD_BAL_CTL           2
-#define SHADOW_MAX                   2
+#define SHADOW_MAX                   3
 
 /* FM Radio deemphasis type */
 enum cx88_deemph_type {

