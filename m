Return-Path: <linux-kernel-owner+w=401wt.eu-S1751371AbXAOTNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbXAOTNk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAOTNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:13:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51508 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXAOTNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:13:38 -0500
Message-Id: <20070115183647.PS0588920000@infradead.org>
Date: Mon, 15 Jan 2007 16:36:47 -0200
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/9] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It contains the following:

   - Fix the frame->grabstate update in read() entry point.
   - Fix: disable interrupts while at KM_BOUNCE_READ
   - Cx88xx: Fix lockup on suspend
   - Fix quickcam communicator driver for big endian architectures
   - Ks0127 status flags
   - MSI TV@nywhere Plus fixes
   - Fix bttv and friends on 64bit machines with lots of memory
   - Tveeprom: autodetect LG TAPC G701D as tuner type 37
   - Fix compilation on ppc32 architecture

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/video/cx88/cx88-tvaudio.c           |    2 ++
 drivers/media/video/ks0127.c                      |    8 ++++----
 drivers/media/video/saa7134/saa7134-cards.c       |   14 ++++++++++----
 drivers/media/video/tveeprom.c                    |    2 +-
 drivers/media/video/usbvideo/quickcam_messenger.h |   14 --------------
 drivers/media/video/usbvision/usbvision-video.c   |    3 +--
 drivers/media/video/v4l2-common.c                 |    9 ++++++++-
 drivers/media/video/video-buf.c                   |    2 +-
 drivers/media/video/vivi.c                        |    7 +++++++
 include/linux/videodev2.h                         |    9 +++++++++
 10 files changed, 43 insertions(+), 27 deletions(-)

