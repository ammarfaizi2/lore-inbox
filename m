Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbWCQU55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbWCQU55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWCQU5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65450 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932768AbWCQU5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:10 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Andreas Oberritter <obi@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 04/21] Fix typo in enum name and use enum in struct
	dmxdev_filter
Date: Fri, 17 Mar 2006 17:54:33 -0300
Message-id: <20060317205433.PS60393300004@infradead.org>
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


From: Andreas Oberritter <obi@linuxtv.org>
Date: 1142014918 \-0300

Rename 'enum dmxdevype' to 'enum dmxdev_type' and use this enum instead
of int for the member 'type' of struct dmxdev_filter.

Signed-off-by: Andreas Oberritter <obi@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-core/dmxdev.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb/dvb-core/dmxdev.h b/drivers/media/dvb/dvb-core/dmxdev.h
index fd72920..6b63577 100644
--- a/drivers/media/dvb/dvb-core/dmxdev.h
+++ b/drivers/media/dvb/dvb-core/dmxdev.h
@@ -37,7 +37,7 @@
 #include "dvbdev.h"
 #include "demux.h"
 
-enum dmxdevype {
+enum dmxdev_type {
 	DMXDEV_TYPE_NONE,
 	DMXDEV_TYPE_SEC,
 	DMXDEV_TYPE_PES,
@@ -78,7 +78,7 @@ struct dmxdev_filter {
 		struct dmx_pes_filter_params pes;
 	} params;
 
-	int type;
+	enum dmxdev_type type;
 	enum dmxdev_state state;
 	struct dmxdev *dev;
 	struct dmxdev_buffer buffer;

