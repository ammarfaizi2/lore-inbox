Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWE3LEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWE3LEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWE3LB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:01:58 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:55954 "EHLO
	pne-smtpout4-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932253AbWE3LBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:01:54 -0400
Message-Id: <20060530110136.162947000@gmail.com>
References: <20060530105705.157014000@gmail.com>
User-Agent: quilt/0.44-1
Date: Tue, 30 May 2006 13:57:15 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch 10/12] input: drop the remains of the old ff interface
Content-Disposition: inline; filename=ff-refactoring-drop-old-interface.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the now unused handlers and input_report_ff().

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---
 include/linux/input.h |    7 -------
 1 files changed, 7 deletions(-)

Index: linux-2.6.16-git20/include/linux/input.h
===================================================================
--- linux-2.6.16-git20.orig/include/linux/input.h	2006-04-15 00:05:00.000000000 +0300
+++ linux-2.6.16-git20/include/linux/input.h	2006-04-15 00:05:41.000000000 +0300
@@ -938,8 +938,6 @@ struct input_dev {
 	int (*accept)(struct input_dev *dev, struct file *file);
 	int (*flush)(struct input_dev *dev, struct file *file);
 	int (*event)(struct input_dev *dev, unsigned int type, unsigned int code, int value);
-	int (*upload_effect)(struct input_dev *dev, struct ff_effect *effect);
-	int (*erase_effect)(struct input_dev *dev, int effect_id);
 
 	struct input_handle *grab;
 
@@ -1118,11 +1116,6 @@ static inline void input_report_abs(stru
 	input_event(dev, EV_ABS, code, value);
 }
 
-static inline void input_report_ff(struct input_dev *dev, unsigned int code, int value)
-{
-	input_event(dev, EV_FF, code, value);
-}
-
 static inline void input_report_ff_status(struct input_dev *dev, unsigned int code, int value)
 {
 	input_event(dev, EV_FF_STATUS, code, value);

--
Anssi Hannula
