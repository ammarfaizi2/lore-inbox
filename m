Return-Path: <linux-kernel-owner+w=401wt.eu-S964837AbXABMa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbXABMa6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbXABMa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:30:58 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3030 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964839AbXABMa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:30:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: video4linux-list@redhat.com
Subject: [PATCH] video: tvmixer module_put cleanup
Date: Tue, 2 Jan 2007 13:32:19 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021332.19993.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes redundant argument check for module_put().
	
Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/media/video/tvmixer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/drivers/media/video/tvmixer.c linux-2.6.20-rc2-mm1-b/drivers/media/video/tvmixer.c
--- linux-2.6.20-rc2-mm1-a/drivers/media/video/tvmixer.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/drivers/media/video/tvmixer.c	2007-01-02 02:27:41.000000000 +0100
@@ -213,8 +213,7 @@ static int tvmixer_release(struct inode 
 		return -ENODEV;
 	}
 
-	if (client->adapter->owner)
-		module_put(client->adapter->owner);
+	module_put(client->adapter->owner);
 	return 0;
 }
 


-- 
Regards,

	Mariusz Kozlowski
