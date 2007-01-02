Return-Path: <linux-kernel-owner+w=401wt.eu-S964827AbXABMYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbXABMYI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbXABMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:24:08 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3271 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964827AbXABMYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:24:07 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: mchehab@infradead.org
Subject: [PATCH] video: cpia module_put cleanup
Date: Tue, 2 Jan 2007 13:25:28 +0100
User-Agent: KMail/1.9.5
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021325.29317.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	No need for redundant argument check for module_put().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/media/video/cpia.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/drivers/media/video/cpia.c linux-2.6.20-rc2-mm1-b/drivers/media/video/cpia.c
--- linux-2.6.20-rc2-mm1-a/drivers/media/video/cpia.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/media/video/cpia.c	2007-01-02 02:28:01.000000000 +0100
@@ -3153,8 +3153,7 @@ static int reset_camera(struct cam_data 
 
 static void put_cam(struct cpia_camera_ops* ops)
 {
-	if (ops->owner)
-		module_put(ops->owner);
+	module_put(ops->owner);
 }
 
 /* ------------------------- V4L interface --------------------- */


-- 
Regards,

	Mariusz Kozlowski
