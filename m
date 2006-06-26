Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWFZMr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWFZMr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWFZMr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:47:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37810 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751202AbWFZMr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:47:58 -0400
Message-Id: <20060626124246.PS11592000000@infradead.org>
Date: Mon, 26 Jun 2006 09:42:46 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/10] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff:

   - Fix an Oops for all fe that have get_frontend_algo == NULL
   - Cx88: cleanups
   - Make VIDEO_CX2341X a selectable build option
   - Make VIDEO_CX88_BLACKBIRD a separate build option
   - Fix a misplaced closing bracket/else, which caused swzigzag not to be called
   - Av7110: analog sound output of DVB-C rev 2.3
   - Add HM12 YUV format define.
   - Always switch tuner mode when calling VIDIOC_S_FREQUENCY.
   - Add V4L2_CID_MPEG_STREAM_VBI_FMT control
   - Update this driver for recent header file movement.

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/Kconfig                             |    3 
 drivers/media/dvb/dvb-core/dvb_frontend.c         |   33 ++++-----
 drivers/media/dvb/ttpci/av7110.c                  |    8 --
 drivers/media/dvb/ttpci/av7110_av.c               |   25 ++++++-
 drivers/media/dvb/ttpci/av7110_v4l.c              |   50 +++++++++++---
 drivers/media/video/Kconfig                       |   12 +++
 drivers/media/video/cx2341x.c                     |   17 ++++
 drivers/media/video/cx88/Kconfig                  |   15 +++-
 drivers/media/video/cx88/Makefile                 |    5 -
 drivers/media/video/cx88/cx88-blackbird.c         |   17 +---
 drivers/media/video/cx88/cx88-cards.c             |    5 -
 drivers/media/video/cx88/cx88-core.c              |    2 
 drivers/media/video/cx88/cx88-i2c.c               |    1 
 drivers/media/video/cx88/cx88-tvaudio.c           |    2 
 drivers/media/video/cx88/cx88.h                   |    7 -
 drivers/media/video/tuner-core.c                  |   10 --
 drivers/media/video/usbvideo/quickcam_messenger.c |    2 
 drivers/media/video/v4l2-common.c                 |   14 +++
 include/linux/videodev2.h                         |    6 +
 include/media/cx2341x.h                           |    6 +
 20 files changed, 161 insertions(+), 79 deletions(-)

