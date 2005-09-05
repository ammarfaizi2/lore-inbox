Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVIEVa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVIEVa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVIEVa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:30:27 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:10675 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932600AbVIEVaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:30:06 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 24/24] V4L: Removed kernel version dependency from
 tea575x-tuner.h 
Message-ID: <431cb7f8.sAV5UC39+DM/6AmM%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.DoPbCFE9kj0SxY286igR7d0gwRSql6I85DnwPmsnNtXW+4jh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.DoPbCFE9kj0SxY286igR7d0gwRSql6I85DnwPmsnNtXW+4jh
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.DoPbCFE9kj0SxY286igR7d0gwRSql6I85DnwPmsnNtXW+4jh
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-24-patch.diff"

- Removed kernel version dependency from tea575x-tuner.h 

 linux-v4l/include/sound/tea575x-tuner.h |    2 --
 1 files changed, 2 deletions(-)

--- linux-2.6.13/include/sound/tea575x-tuner.h	2005-08-28 20:41:01.000000000 -0300
+++ linux/include/sound/tea575x-tuner.h	2005-09-05 15:44:56.000000000 -0300
@@ -34,9 +34,7 @@ struct snd_tea575x_ops {
 struct snd_tea575x {
 	snd_card_t *card;
 	struct video_device vd;		/* video device */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
 	struct file_operations fops;
-#endif
 	int dev_nr;			/* requested device number + 1 */
 	int vd_registered;		/* video device is registered */
 	int tea5759;			/* 5759 chip is present */

--=_431cb7f8.DoPbCFE9kj0SxY286igR7d0gwRSql6I85DnwPmsnNtXW+4jh--
