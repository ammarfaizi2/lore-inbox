Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTFZPZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFZPZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:25:22 -0400
Received: from smtp3.dti.ne.jp ([202.216.228.38]:45239 "EHLO smtp3.dti.ne.jp")
	by vger.kernel.org with ESMTP id S261919AbTFZPZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:25:21 -0400
Date: Fri, 27 Jun 2003 00:36:35 +0900 (JST)
Message-Id: <20030627.003635.74756433.co2b@ceres.dti.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.73 can't mount DVD-RAM via ide-scsi
From: Kouichi ONO <co2b@ceres.dti.ne.jp>
X-Mailer: Mew version 3.1.53 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in 2.5.73, I can't read/write mount DVD-RAM via ide-scsi (only r/o mount). 
Without ide-scsi, I can mount DVD-RAM read/write mode and works fine. 

Here's a patch to fix this.

--- linux-2.5.73-org/drivers/scsi/sr.c	2003-06-25 20:39:59.000000000 +0900
+++ linux-2.5.73/drivers/scsi/sr.c	2003-06-26 23:45:33.000000000 +0900
@@ -65,7 +65,7 @@
 	(CDC_CLOSE_TRAY|CDC_OPEN_TRAY|CDC_LOCK|CDC_SELECT_SPEED| \
 	 CDC_SELECT_DISC|CDC_MULTI_SESSION|CDC_MCN|CDC_MEDIA_CHANGED| \
 	 CDC_PLAY_AUDIO|CDC_RESET|CDC_IOCTLS|CDC_DRIVE_STATUS| \
-	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_GENERIC_PACKET)
+	 CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_DVD_RAM|CDC_GENERIC_PACKET)
 
 static int sr_probe(struct device *);
 static int sr_remove(struct device *);


Regards,

-- 
  Ono Kouichi (co2b@ceres.dti.ne.jp)
