Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262552AbSI0R1G>; Fri, 27 Sep 2002 13:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262540AbSI0R1G>; Fri, 27 Sep 2002 13:27:06 -0400
Received: from [216.40.201.6] ([216.40.201.6]:7954 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262552AbSI0R0d>; Fri, 27 Sep 2002 13:26:33 -0400
Date: Fri, 27 Sep 2002 14:28:27 -0300
To: dagb@cs.uit.no
Cc: linux-kernel@vger.kernel.org
Subject: [patch] __FUNCTION__ issue (tekram)
Message-ID: <20020927172827.GT20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-- 
aris

--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tekram.patch"

--- linux-2.5.38-vanilla/drivers/net/irda/tekram.c	2002-09-22 01:25:11.000000000 -0300
+++ linux-2.5.38/drivers/net/irda/tekram.c	2002-09-27 11:21:01.000000000 -0300
@@ -66,7 +66,7 @@
 
 static void tekram_open(dongle_t *self, struct qos_info *qos)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
 	qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */	
@@ -77,7 +77,7 @@
 
 static void tekram_close(dongle_t *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power off dongle */
 	self->set_dtr_rts(self->dev, FALSE, FALSE);
@@ -113,12 +113,12 @@
 	__u8 byte;
 	int ret = 0;
 	
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(task != NULL, return -1;);
 
 	if (self->speed_task && self->speed_task != task) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
 		return MSECS_TO_JIFFIES(10);
 	} else
 		self->speed_task = task;
@@ -214,12 +214,12 @@
 	dongle_t *self = (dongle_t *) task->instance;
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(task != NULL, return -1;);
 
 	if (self->reset_task && self->reset_task != task) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		IRDA_DEBUG(0, "%s(), busy!\n", __FUNCTION__);
 		return MSECS_TO_JIFFIES(10);
 	} else
 		self->reset_task = task;

--ogUXNSQj4OI1q3LQ--
