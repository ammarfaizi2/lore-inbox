Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbSI0RLl>; Fri, 27 Sep 2002 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbSI0RLl>; Fri, 27 Sep 2002 13:11:41 -0400
Received: from [216.40.201.6] ([216.40.201.6]:38161 "EHLO
	www.businesssite.com.br") by vger.kernel.org with ESMTP
	id <S262264AbSI0RLk>; Fri, 27 Sep 2002 13:11:40 -0400
Date: Fri, 27 Sep 2002 14:13:22 -0300
To: tshimizu@ga2.so-net.ne.jp
Cc: linux-kernel@vger.kernel.org
Subject: [patch][2.5.38] __FUNCTION__ issue (act200l)
Message-ID: <20020927171322.GN20649@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,
	this and next patches are to replace
		printk("blah" __FUNCTION__ "blah");
	by
		printk("blah" "%s" "blah", __FUNCTION__);

	that is needed to compile 2.5.38

-- 
aris

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="act200l.patch"

--- linux-2.5.38-vanilla/drivers/net/irda/act200l.c	2002-09-22 01:25:10.000000000 -0300
+++ linux-2.5.38/drivers/net/irda/act200l.c	2002-09-27 11:22:36.000000000 -0300
@@ -106,7 +106,7 @@
 
 static void act200l_open(dongle_t *self, struct qos_info *qos)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power on the dongle */
 	self->set_dtr_rts(self->dev, TRUE, TRUE);
@@ -120,7 +120,7 @@
 
 static void act200l_close(dongle_t *self)
 {
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power off the dongle */
 	self->set_dtr_rts(self->dev, FALSE, FALSE);
@@ -141,7 +141,7 @@
 	__u8 control[3];
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self->speed_task = task;
 
@@ -233,7 +233,7 @@
 	};
 	int ret = 0;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self->reset_task = task;
 

--u5E4XgoOPWr4PD9E--
