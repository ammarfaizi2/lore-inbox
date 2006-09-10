Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWIJRJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWIJRJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWIJRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:09:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54246 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932320AbWIJRJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:09:50 -0400
Message-Id: <20060910170419.PS3030230000@infradead.org>
Date: Sun, 10 Sep 2006 14:04:19 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 0/6] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the following stuff fixes:

   - Fix compilation when V4L1 support is not present
   - Restore tuner_ymec_tvf66t5_b_dff_pal_ranges[] to fix UHF switch functionality
   - Fix an error when loading bttv driver on PV M4900.
   - Fixes an issue with V4L1 and make headers-install
   - i2c deps fix on DVB
   - Fix I2C dependencies for saa7146 modules

Basically, we have one trivial fix for tuner, one OOPS fix and several 
fixes at the building system.

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/Kconfig                  |    2 +
 drivers/media/common/saa7146_video.c   |    2 +
 drivers/media/dvb/b2c2/Kconfig         |    1 +
 drivers/media/dvb/bt8xx/Kconfig        |    1 +
 drivers/media/dvb/dvb-usb/Kconfig      |    1 +
 drivers/media/dvb/frontends/Kconfig    |   60 +++++++++++++++++---------------
 drivers/media/dvb/frontends/Makefile   |    2 +
 drivers/media/dvb/pluto2/Kconfig       |    1 +
 drivers/media/dvb/ttpci/Kconfig        |    5 +++
 drivers/media/dvb/ttusb-budget/Kconfig |    3 +-
 drivers/media/video/Kconfig            |    8 ++--
 drivers/media/video/bt8xx/bttv-input.c |    1 +
 drivers/media/video/cx88/Kconfig       |    1 +
 drivers/media/video/saa7134/Kconfig    |    1 +
 drivers/media/video/tuner-types.c      |   10 ++++-
 drivers/media/video/zoran.h            |    2 +
 drivers/media/video/zoran_driver.c     |   22 ++++++------
 include/linux/videodev.h               |    3 +-
 include/linux/videodev2.h              |    2 -
 include/media/v4l2-dev.h               |    7 ++--
 20 files changed, 79 insertions(+), 56 deletions(-)

