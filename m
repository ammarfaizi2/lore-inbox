Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbWCQU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWCQU6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWCQU50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:57:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2475 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932769AbWCQU5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:21 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 03/21] Correct gpio values for Aver 303 Studio in v4l-dvb
	tree
Date: Fri, 17 Mar 2006 17:54:33 -0300
Message-id: <20060317205433.PS23211600003@infradead.org>
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


From: Marcin Rudowski <mar_rud@poczta.onet.pl>
Date: 1141931391 \-0300

Old values generally works in A2 mono, but new ones allows:
- detect and use Nicam stereo
- mute in tv
- use radio FM

Signed-off-by: Marcin Rudowski <mar_rud@poczta.onet.pl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-cards.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 1bc9992..9e29df3 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -184,17 +184,18 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			.gpio1  = 0x309f,
+			.gpio1  = 0xe09f,
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
-			.gpio1  = 0x305f,
+			.gpio1  = 0xe05f,
 		},{
 			.type   = CX88_VMUX_SVIDEO,
 			.vmux   = 2,
-			.gpio1  = 0x305f,
+			.gpio1  = 0xe05f,
 		}},
 		.radio = {
+			.gpio1  = 0xe0df,
 			.type   = CX88_RADIO,
 		},
 	},

