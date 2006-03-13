Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWCMUJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWCMUJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964769AbWCMUJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:09:34 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:19216 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964772AbWCMUJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:09:33 -0500
Date: Mon, 13 Mar 2006 21:09:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: [PATCH 0/8] Zoran drivers updates
Message-Id: <20060313210933.88a42375.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here comes an 8-piece patch set for the zoran drivers. The first 7 of
these were already posted to the mjpeg-users and video4linux lists two
months ago [1], the last one is new. There are both fixes and cleanups.

Andrew, Ronald says he is too busy these days to deal with my patches,
but otherwise he was OK with them. Could you please take them in -mm so
that they get wider testing? Then we'd be able to merge them.

[1] http://www.mail-archive.com/mjpeg-users@lists.sourceforge.net/msg06451.html

Summary:

Jean Delvare:
 o saa7110: Fix array overrun
 o saa7111: Prevent array overrun
 o saa7114: Fix i2c block write
 o adv7175: Drop unused encoder dump command
 o adv7175: Drop unused register cache
 o zoran: Use i2c_master_send when possible
 o bt856: Spare memory
 o zoran: Init cleanups

Statistics:

 drivers/media/video/adv7170.c    |   17 +++++--------
 drivers/media/video/adv7175.c    |   51 ++++++--------------------------------
 drivers/media/video/bt819.c      |   17 +++++--------
 drivers/media/video/bt856.c      |   13 ++++------
 drivers/media/video/saa7110.c    |   19 ++++----------
 drivers/media/video/saa7111.c    |   25 +++++++++----------
 drivers/media/video/saa7114.c    |   23 ++++++-----------
 drivers/media/video/saa7185.c    |   17 +++++--------
 drivers/media/video/zoran_card.c |   38 +++++++++++++---------------
 9 files changed, 77 insertions(+), 143 deletions(-)

The patches are also available from there until they get merged:
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-saa7110-fix-array-overrun.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-saa7111-prevent-array-overrun.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-saa7114-fix-i2c-block-write.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-adv7175-drop-encoder-dump.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-adv7175-drop-unused-register-cache.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-zoran-use-i2c-master-send.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-bt856-spare-memory.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/media-video-zoran-init-cleanup.patch

Thanks,
-- 
Jean Delvare
