Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWHHVNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWHHVNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWHHVNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:13:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56266 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030273AbWHHVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:13:04 -0400
Message-Id: <20060808210151.PS78629800000@infradead.org>
Date: Tue, 08 Aug 2006 18:01:51 -0300
From: mchehab@infradead.org
To: Greg KH <greg@kroah.com>
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH 00/14] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull these from "master" branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains miscelaneous fixes, mostly related to kernel building and 
compatibility stuff. Also, one radio device were at the wrong place.

   - Videodev.h should be included also when V4L1_COMPAT is selected.
   - Fix V4L1 dependencies on compat_ioctl32
   - Fix V4L1 dependencies at drivers under sound/oss and sound/pci
   - Restore compat_ioctl in pwc driver
   - Fix a typo that caused some compat stuff to not work
   - Driver dsbr100 is a radio device, not a video one!
   - Fix minor errors in build files
   - Cx25840_read4 has wrong endianness.
   - Fix broken msp3400 module option 'standard'
   - Turn on the Low Noise Amplifier of the Samsung tuners.
   - Fix V4L1 Compat for VIDIOCGPICT ioctl
   - Quickcam_messenger compilation fix
   - Add several error checks to dst
   - Fix a warning on PPC64

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/dvb/bt8xx/dst.c                      |   58 -
 drivers/media/dvb/dvb-core/Makefile                |    6 
 drivers/media/radio/Kconfig                        |   12 
 drivers/media/radio/Makefile                       |    1 
 drivers/media/radio/dsbr100.c                      |  430 +++++++++++++
 drivers/media/video/Kconfig                        |   12 
 drivers/media/video/Makefile                       |    2 
 drivers/media/video/compat_ioctl32.c               |   32 
 drivers/media/video/cx25840/cx25840-core.c         |    4 
 drivers/media/video/cx88/cx88-video.c              |    4 
 drivers/media/video/dsbr100.c                      |  430 -------------
 drivers/media/video/msp3400-kthreads.c             |    4 
 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c |    2 
 drivers/media/video/pwc/Kconfig                    |    2 
 drivers/media/video/pwc/pwc-if.c                   |    1 
 drivers/media/video/saa7134/saa7134-video.c        |    2 
 drivers/media/video/tuner-types.c                  |   14 
 drivers/media/video/v4l1-compat.c                  |    4 
 drivers/media/video/v4l2-common.c                  |    6 
 drivers/media/video/videodev.c                     |    2 
 drivers/media/video/vivi.c                         |    4 
 include/media/v4l2-dev.h                           |    2 
 sound/oss/Kconfig                                  |    6 
 sound/pci/Kconfig                                  |   70 +-
 24 files changed, 569 insertions(+), 541 deletions(-)

