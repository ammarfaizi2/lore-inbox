Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVLaQgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLaQgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVLaQgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:36:37 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:20378 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965001AbVLaQgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:36:36 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:36:31 +0100
In-reply-to: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: [PATCH 5/4 :) I forgot] media-radio: Maestro radio delete owner line from video device
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, atlka@pg.gda.pl
Message-Id: <20051231163629.E780422B3B9@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maestro radio delete owner line from video device

fops is used for module handling with ownership.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
 radio-maestro.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c
+++ b/drivers/media/radio/radio-maestro.c
@@ -92,9 +92,7 @@ static struct file_operations maestro_fo
 	.llseek		= no_llseek,
 };
 
-static struct video_device maestro_radio=
-{
-	.owner		= THIS_MODULE,
+static struct video_device maestro_radio = {
 	.name		= "Maestro radio",
 	.type		= VID_TYPE_TUNER,
 	.hardware	= VID_HARDWARE_SF16MI,
