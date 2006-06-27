Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933331AbWF0DaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331AbWF0DaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 23:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933343AbWF0DaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 23:30:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31878 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933331AbWF0DaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 23:30:07 -0400
Message-Id: <20060627015758.PS35239600000@infradead.org>
Date: Mon, 27 Jun 2006 00:26:20 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/26] V4L/DVB updates - UPDATED
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

After sending you the previous request, I've added those two stuff:
   - Included required header for in-kernel compilation
   - Fix warning when compiling on 64 bit machines

This stuff complement the other 24 patches I've already asked you to pull:

   - pvrusb2 to kernel 2.6.18 (this is a big patch due to a newer driver)
   - Cx88-blackbird: implement VIDIOC_LOG_STATUS
   - Include some extra headers that we need.
   - Rearrange things in pvrusb2-encoder in preparation for use of cx2341x module
   - Don't print empty enum values in pvrusb2-sysfs.c
   - Clean up long-standing video format handling mess in pvrusb2-v4l2.c
   - Increase the maximum number of controls that pvrusb2-sysfs.c can handle.
   - Rearrange things in pvrusb2 driver in preparation for using cx2341x module
   - Move LOG_STATUS bracketing to a different part of the pvrusb2 driver
   - Make sure flags field is initialized when quering a control in pvrusb2
   - Handle boolean controls in pvrusb2
   - Various V4L control enhancements in pvrusb2
   - Fix faulty encoder error recovery in pvrusb2
   - Don't suspend encoder when changing its attributes (in pvrusb2)
   - Exploit new V4L control features in pvrusb2
   - Implement use of cx2341x module in pvrusb2 driver
   - Reduce the amount of pvrusb2-sourced noise going into the system log
   - Remove duplicate 'tda9887' in info messages.
   - IVTV VBI format description too long.
   - Remove obsoleted tuner_debug option.
   - Tda9887 default TOP value is 0x10
   - Fix 64-bit compile warnings.
   - Pass an explicit log prefix to cx2341x_log_status
   - Stradis.c: make 2 functions static

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/README.pvrusb2             |  212 +
 drivers/media/video/Kconfig                          |    2
 drivers/media/video/Makefile                         |    1
 drivers/media/video/cx2341x.c                        |   40
 drivers/media/video/cx88/cx88-blackbird.c            |   15
 drivers/media/video/pvrusb2/Kconfig                  |   62
 drivers/media/video/pvrusb2/Makefile                 |   18
 drivers/media/video/pvrusb2/pvrusb2-audio.c          |  204 +
 drivers/media/video/pvrusb2/pvrusb2-audio.h          |   40
 drivers/media/video/pvrusb2/pvrusb2-context.c        |  230 +
 drivers/media/video/pvrusb2/pvrusb2-context.h        |   92
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c           |  603 +++
 drivers/media/video/pvrusb2/pvrusb2-ctrl.h           |  123
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c    |  283 +
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.h    |   53
 drivers/media/video/pvrusb2/pvrusb2-debug.h          |   67
 drivers/media/video/pvrusb2/pvrusb2-debugifc.c       |  478 ++
 drivers/media/video/pvrusb2/pvrusb2-debugifc.h       |   53
 drivers/media/video/pvrusb2/pvrusb2-demod.c          |  126
 drivers/media/video/pvrusb2/pvrusb2-demod.h          |   38
 drivers/media/video/pvrusb2/pvrusb2-eeprom.c         |  164
 drivers/media/video/pvrusb2/pvrusb2-eeprom.h         |   40
 drivers/media/video/pvrusb2/pvrusb2-encoder.c        |  962 +++--
 drivers/media/video/pvrusb2/pvrusb2-encoder.h        |   42
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h   |  408 ++
 drivers/media/video/pvrusb2/pvrusb2-hdw.c            | 3478 ++++++++++++++++++-
 drivers/media/video/pvrusb2/pvrusb2-hdw.h            |  357 +
 drivers/media/video/pvrusb2/pvrusb2-i2c-chips-v4l2.c |  115
 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.c   |  232 +
 drivers/media/video/pvrusb2/pvrusb2-i2c-cmd-v4l2.h   |   47
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c       |  937 +++++
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.h       |   96
 drivers/media/video/pvrusb2/pvrusb2-io.c             |  695 +++
 drivers/media/video/pvrusb2/pvrusb2-io.h             |  102
 drivers/media/video/pvrusb2/pvrusb2-ioread.c         |  513 ++
 drivers/media/video/pvrusb2/pvrusb2-ioread.h         |   50
 drivers/media/video/pvrusb2/pvrusb2-main.c           |  188 -
 drivers/media/video/pvrusb2/pvrusb2-std.c            |  408 ++
 drivers/media/video/pvrusb2/pvrusb2-std.h            |   60
 drivers/media/video/pvrusb2/pvrusb2-sysfs.c          |  867 ++++
 drivers/media/video/pvrusb2/pvrusb2-sysfs.h          |   47
 drivers/media/video/pvrusb2/pvrusb2-tuner.c          |  122
 drivers/media/video/pvrusb2/pvrusb2-tuner.h          |   38
 drivers/media/video/pvrusb2/pvrusb2-util.h           |   63
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c           | 1200 ++++++
 drivers/media/video/pvrusb2/pvrusb2-v4l2.h           |   40
 drivers/media/video/pvrusb2/pvrusb2-video-v4l.c      |  257 +
 drivers/media/video/pvrusb2/pvrusb2-video-v4l.h      |   52
 drivers/media/video/pvrusb2/pvrusb2-wm8775.c         |  170
 drivers/media/video/pvrusb2/pvrusb2-wm8775.h         |   53
 drivers/media/video/pvrusb2/pvrusb2.h                |   43
 drivers/media/video/saa7134/saa6752hs.c              |    4
 drivers/media/video/stradis.c                        |    4
 drivers/media/video/tda9887.c                        |   31
 drivers/media/video/tuner-core.c                     |    8
 drivers/media/video/v4l2-common.c                    |    2
 include/media/cx2341x.h                              |    4
 57 files changed, 14058 insertions(+), 581 deletions(-)
