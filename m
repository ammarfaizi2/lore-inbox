Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965347AbWCTPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965347AbWCTPkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWCTPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:40:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24760 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965294AbWCTPZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:25:06 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Chris Pascoe <c.pascoe@itee.uq.edu.au>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 137/141] V4L/DVB (3410): Move DViCO hybrid initialisation
	data from stack.
Date: Mon, 20 Mar 2006 12:08:59 -0300
Message-id: <20060320150859.PS853336000137@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Date: 1141168991 -0300

The init_data array is never changed and need not be on the stack.
Turn it into a static variable.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index d91e5b3..f655567 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -1435,7 +1435,7 @@ static void dvico_fusionhdtv_hybrid_init
 {
 	struct i2c_msg msg = { .addr = 0x45, .flags = 0 };
 	int i, err;
-	u8 init_bufs[13][5] = {
+	static u8 init_bufs[13][5] = {
 		{ 0x10, 0x00, 0x20, 0x01, 0x03 },
 		{ 0x10, 0x10, 0x01, 0x00, 0x21 },
 		{ 0x10, 0x10, 0x10, 0x00, 0xCA },

