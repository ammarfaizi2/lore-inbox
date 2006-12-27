Return-Path: <linux-kernel-owner+w=401wt.eu-S933019AbWL0ROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbWL0ROp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbWL0ROT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:14:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41557 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996AbWL0ROI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:14:08 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 26/28] V4L/DVB (5001): Add two required headers on kernel
	2.6.20-rc1
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165732.PS59864000026@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

include/media/ir-common.h:78: error: field 'work' has incomplete type
drivers/media/common/ir-functions.c: In function 'ir_rc5_timer_end':
drivers/media/common/ir-functions.c:301: error: 'jiffies' undeclared (first use in this function)
drivers/media/common/ir-functions.c:301: error: (Each undeclared identifier is reported only once)
drivers/media/common/ir-functions.c:301: error: for each function it appears in.)
drivers/media/common/ir-functions.c:347: error: 'HZ' undeclared (first use in this function)

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/common/ir-functions.c |    1 +
 include/media/ir-common.h           |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/common/ir-functions.c b/drivers/media/common/ir-functions.c
index 8eaa88f..9a8dd87 100644
--- a/drivers/media/common/ir-functions.c
+++ b/drivers/media/common/ir-functions.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 #include <media/ir-common.h>
 
 /* -------------------------------------------------------------------------- */
diff --git a/include/media/ir-common.h b/include/media/ir-common.h
index 2b25f5c..4bb0ad8 100644
--- a/include/media/ir-common.h
+++ b/include/media/ir-common.h
@@ -24,6 +24,7 @@ #ifndef _IR_COMMON
 #define _IR_COMMON
 
 #include <linux/input.h>
+#include <linux/workqueue.h>
 
 #define IR_TYPE_RC5     1
 #define IR_TYPE_PD      2 /* Pulse distance encoded IR */

