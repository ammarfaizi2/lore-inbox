Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932839AbWCQXBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWCQXBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWCQXBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:01:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1698 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932839AbWCQXBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:01:02 -0500
Message-Id: <20060317205359.PS65198900000@infradead.org>
Date: Fri, 17 Mar 2006 17:53:59 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/21] V4L/DVB fixes
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is also available under v4l-dvb.git tree at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Linus, please pull these from master branch.

It contains the following stuff:

   - Nskips maybe used uninitialized in bttv_risc_overlay
   - Fix cx88 error messages on balance change
   - Correct gpio values for Aver 303 Studio in v4l-dvb tree
   - Fix typo in enum name and use enum in struct dmxdev_filter
   - Added no_overlay option and quirks to saa7134
   - Cx88-cards.c: fix values of gpio0 for card CX88_BOARD_PROLINK_PLAYTVPVR
   - Cx88-input.c: add IR remote control support to CX88_BOARD_PROLINK_PLAYTVPVR
   - Cx88 default picture controls values
   - Cleanup mangled whitespace
   - BUG_ON() Conversion in drivers/video/media
   - Snd_cx88_create: don't dereference NULL core
   - Kconfig: select VIDEO_CX25840 to build cx25840 a/v decoder module
   - Whitespace: fix incorrect indentation of curly bracket
   - Cinergy T2 dmx cleanup on disconnect
   - Restore tuning capabilities in v4l2 mxb driver
   - Kconfig: swap VIDEO_CX88_ALSA and VIDEO_CX88_DVB
   - Kconfig: fix ATSC frontend menu item names by manufacturer
   - Fix a bug when more than MAXBOARDS were plugged on em28xx
   - Cpia2: move Kconfig build logic into cpia2/Kconfig
   - VIDEO_CPIA2 must depend on USB
   - Fixed em28xx based system lockup

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 drivers/media/common/saa7146_core.c               |    3 -
 drivers/media/common/saa7146_fops.c               |    6 +--
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    4 ++
 drivers/media/dvb/dvb-core/dmxdev.h               |    4 +-
 drivers/media/dvb/frontends/Kconfig               |    6 +--
 drivers/media/dvb/ttpci/av7110.c                  |    6 +--
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    3 -
 drivers/media/video/Kconfig                       |    5 ++
 drivers/media/video/Makefile                      |    3 +
 drivers/media/video/bttv-cards.c                  |   10 +++--
 drivers/media/video/bttv-risc.c                   |    5 +-
 drivers/media/video/cpia2/Kconfig                 |   11 +++++
 drivers/media/video/cx25840/Kconfig               |    9 ++++
 drivers/media/video/cx25840/Makefile              |    2 -
 drivers/media/video/cx88/Kconfig                  |   28 +++++++-------
 drivers/media/video/cx88/cx88-alsa.c              |   10 ++---
 drivers/media/video/cx88/cx88-cards.c             |   23 ++++++-----
 drivers/media/video/cx88/cx88-core.c              |    3 -
 drivers/media/video/cx88/cx88-input.c             |    1 
 drivers/media/video/cx88/cx88-video.c             |   17 ++++----
 drivers/media/video/cx88/cx88.h                   |    2 -
 drivers/media/video/em28xx/em28xx-video.c         |    5 ++
 drivers/media/video/mxb.c                         |    4 ++
 drivers/media/video/saa7134/saa7134-alsa.c        |    3 -
 drivers/media/video/saa7134/saa7134-cards.c       |    2 -
 drivers/media/video/saa7134/saa7134-core.c        |   24 +++++++++++-
 drivers/media/video/saa7134/saa7134-oss.c         |    6 +--
 drivers/media/video/saa7134/saa7134-video.c       |    3 -
 drivers/media/video/video-buf.c                   |    3 -
 29 files changed, 130 insertions(+), 81 deletions(-)

