Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWCYNF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWCYNF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCYNF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:05:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52624 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750840AbWCYNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:05:25 -0500
Subject: [PATCH 0/4] V4L updates
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 10:05:08 -0300
Message-Id: <1143291908.4961.68.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 

Please pull from v4l-dvb master branch at
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Those patches moves all drivers under drivers/usb/media to
drivers/media/video, and do whitespace cleanups under media subsystem.
Kconfig now is more coherent to the user, since all media capture
devices are shown under the same menu (previously, some usb devices were
under USB; others under multimedia).

The diffstat is impressive, but, in fact, the only real changes are at
Makefile and Kconfig files.

Also there is a small fix for a printk.

Cheers,
Mauro.

git cherry for those newer patches:

+ 9f6933be665ce3b049c274c99810ac754edabf19 V4L/DVB (3599a): Move
drivers/usb/media to drivers/media/video
+ d56410e0a594150c5ca06319da7bc8901c4d455e V4L/DVB (3599b): Whitespace
cleanups under drivers/media
+ 48773e685b118ef56dcf5258ef7388a4bea16137 V4L/DVB (3599c): Whitespace
cleanups under Documentation/video4linux
+ 22fe087f0139e2f5cbe004f24f84cb1c08b4711e V4L/DVB (3604): V4l printk
fix

 Documentation/video4linux/CQcam.txt                |  182
 Documentation/video4linux/README.cpia              |    4
 Documentation/video4linux/Zoran                    |  108
 Documentation/video4linux/bttv/ICs                 |    4
 Documentation/video4linux/bttv/PROBLEMS            |   16
 Documentation/video4linux/bttv/README.quirks       |    4
 Documentation/video4linux/bttv/THANKS              |    4
 Documentation/video4linux/radiotrack.txt           |   16
 Documentation/video4linux/w9966.txt                |    2
 Documentation/video4linux/zr36120.txt              |    4
 drivers/media/Kconfig                              |   14
 drivers/media/video/Kconfig                        |  260
 drivers/media/video/Makefile                       |   19
 drivers/media/video/adv7170.c                      |   10
 drivers/media/video/adv7175.c                      |    6
 drivers/media/video/arv.c                          |   54
 drivers/media/video/bt819.c                        |   10
 drivers/media/video/bt856.c                        |    4
 drivers/media/video/bw-qcam.c                      |  106
 drivers/media/video/c-qcam.c                       |   66
 drivers/media/video/cpia.c                         |  656 +-
 drivers/media/video/cpia.h                         |   52
 drivers/media/video/cpia_pp.c                      |  106
 drivers/media/video/cpia_usb.c                     |   40
 drivers/media/video/cs53l32a.c                     |   15
 drivers/media/video/cs8420.h                       |    2
 drivers/media/video/dabfirmware.h                  | 1408 ++++
 drivers/media/video/dabusb.c                       |  892 +++
 drivers/media/video/dabusb.h                       |   89
 drivers/media/video/dsbr100.c                      |  473 +
 drivers/media/video/et61x251/Makefile              |    4
 drivers/media/video/et61x251/et61x251.h            |  242
 drivers/media/video/et61x251/et61x251_core.c       | 2840 +++++++++
 drivers/media/video/et61x251/et61x251_sensor.h     |  136
 drivers/media/video/et61x251/et61x251_tas5130d1b.c |  151
 drivers/media/video/ov511.c                        | 6024
++++++++++++++++++++-
 drivers/media/video/ov511.h                        |  576 +-
 drivers/media/video/ovcamchip/Makefile             |    2
 drivers/media/video/ovcamchip/ovcamchip_core.c     |    6
 drivers/media/video/ovcamchip/ovcamchip_priv.h     |    2
 drivers/media/video/planb.c                        |  128
 drivers/media/video/planb.h                        |    6
 drivers/media/video/pms.c                          |  136
 drivers/media/video/pwc/Makefile                   |   22
 drivers/media/video/pwc/philips.txt                |  304 -
 drivers/media/video/pwc/pwc-ctrl.c                 | 1915 ++++++
 drivers/media/video/pwc/pwc-if.c                   | 2507 ++++++++
 drivers/media/video/pwc/pwc-ioctl.h                |  332 +
 drivers/media/video/pwc/pwc-kiara.c                |  606 +-
 drivers/media/video/pwc/pwc-kiara.h                |   45
 drivers/media/video/pwc/pwc-misc.c                 |  166
 drivers/media/video/pwc/pwc-nala.h                 |   68
 drivers/media/video/pwc/pwc-timon.c                |  604 +-
 drivers/media/video/pwc/pwc-timon.h                |   61
 drivers/media/video/pwc/pwc-uncompress.c           |  152
 drivers/media/video/pwc/pwc-uncompress.h           |   43
 drivers/media/video/pwc/pwc.h                      |  276
 drivers/media/video/saa5249.c                      |  112
 drivers/media/video/saa7110.c                      |    4
 drivers/media/video/saa7111.c                      |    4
 drivers/media/video/saa7114.c                      |   12
 drivers/media/video/saa7121.h                      |    6
 drivers/media/video/saa7146.h                      |   10
 drivers/media/video/saa7146reg.h                   |    4
 drivers/media/video/saa7185.c                      |    4
 drivers/media/video/saa7196.h                      |    4
 drivers/media/video/se401.c                        | 1655 +++++
 drivers/media/video/se401.h                        |  240
 drivers/media/video/sn9c102/Makefile               |   13
 drivers/media/video/sn9c102/sn9c102.h              |  226
 drivers/media/video/sn9c102/sn9c102_core.c         | 3181 ++++++++++-
 drivers/media/video/sn9c102/sn9c102_hv7131d.c      |  287 -
 drivers/media/video/sn9c102/sn9c102_mi0343.c       |  469 +
 drivers/media/video/sn9c102/sn9c102_ov7630.c       |  415 +
 drivers/media/video/sn9c102/sn9c102_pas106b.c      |  323 +
 drivers/media/video/sn9c102/sn9c102_pas202bca.c    |  244
 drivers/media/video/sn9c102/sn9c102_pas202bcb.c    |  311 +
 drivers/media/video/sn9c102/sn9c102_sensor.h       |  459 +
 drivers/media/video/sn9c102/sn9c102_tas5110c1b.c   |  171
 drivers/media/video/sn9c102/sn9c102_tas5130d1b.c   |  181
 drivers/media/video/stradis.c                      |   10
 drivers/media/video/stv680.c                       | 1556 +++++
 drivers/media/video/stv680.h                       |  369 +
 drivers/media/video/tda9840.c                      |    2
 drivers/media/video/tea6415c.c                     |    2
 drivers/media/video/tea6420.c                      |    2
 drivers/media/video/tuner-3036.c                   |   50
 drivers/media/video/usbvideo/Makefile              |    4
 drivers/media/video/usbvideo/ibmcam.c              | 3942 +++++++++++++
 drivers/media/video/usbvideo/konicawc.c            | 1026 +++
 drivers/media/video/usbvideo/ultracam.c            |  681 ++
 drivers/media/video/usbvideo/usbvideo.c            | 2232 +++++++
 drivers/media/video/usbvideo/usbvideo.h            |  404 +
 drivers/media/video/usbvideo/vicam.c               | 1439 ++++-
 drivers/media/video/v4l2-common.c                  |    2
 drivers/media/video/videocodec.h                   |   54
 drivers/media/video/vino.c                         |    4
 drivers/media/video/vpx3220.c                      |   20
 drivers/media/video/w9966.c                        |  102
 drivers/media/video/w9968cf.c                      | 4625
++++++++++++++--
 drivers/media/video/w9968cf.h                      |  342 +
 drivers/media/video/w9968cf_decoder.h              |   94
 drivers/media/video/w9968cf_vpp.h                  |   42
 drivers/media/video/wm8775.c                       |   15
 drivers/media/video/zc0301/Makefile                |    3
 drivers/media/video/zc0301/zc0301.h                |  198
 drivers/media/video/zc0301/zc0301_core.c           | 2203 +++++++
 drivers/media/video/zc0301/zc0301_pas202bcb.c      |  373 +
 drivers/media/video/zc0301/zc0301_sensor.h         |  107
 drivers/media/video/zoran.h                        |    2
 drivers/media/video/zoran_card.c                   |    2
 drivers/media/video/zoran_card.h                   |    2
 drivers/media/video/zoran_device.c                 |   16
 drivers/media/video/zoran_device.h                 |    2
 drivers/media/video/zoran_driver.c                 |   16
 drivers/media/video/zoran_procfs.c                 |    2
 drivers/media/video/zoran_procfs.h                 |    2
 drivers/media/video/zr36016.c                      |   22
 drivers/media/video/zr36050.c                      |   16
 drivers/media/video/zr36057.h                      |   10
 drivers/media/video/zr36060.c                      |   20
 drivers/media/video/zr36120.c                      |   46
 drivers/media/video/zr36120.h                      |    6
 drivers/usb/Kconfig                                |    2
 drivers/usb/Makefile                               |   14
 drivers/usb/media/Kconfig                          |  241
 drivers/usb/media/Makefile                         |   24
 drivers/usb/media/dabfirmware.h                    | 1408 ----
 drivers/usb/media/dabusb.c                         |  874 ---
 drivers/usb/media/dabusb.h                         |   85
 drivers/usb/media/dsbr100.c                        |  429 -
 drivers/usb/media/et61x251.h                       |  234
 drivers/usb/media/et61x251_core.c                  | 2630 ---------
 drivers/usb/media/et61x251_sensor.h                |  116
 drivers/usb/media/et61x251_tas5130d1b.c            |  141
 drivers/usb/media/ibmcam.c                         | 3932 -------------
 drivers/usb/media/konicawc.c                       |  978 ---
 drivers/usb/media/ov511.c                          | 5932
--------------------
 drivers/usb/media/ov511.h                          |  568 -
 drivers/usb/media/pwc/Makefile                     |   20
 drivers/usb/media/pwc/philips.txt                  |  236
 drivers/usb/media/pwc/pwc-ctrl.c                   | 1541 -----
 drivers/usb/media/pwc/pwc-if.c                     | 2205 -------
 drivers/usb/media/pwc/pwc-ioctl.h                  |  292 -
 drivers/usb/media/pwc/pwc-kiara.c                  |  318 -
 drivers/usb/media/pwc/pwc-kiara.h                  |   45
 drivers/usb/media/pwc/pwc-misc.c                   |  140
 drivers/usb/media/pwc/pwc-nala.h                   |   66
 drivers/usb/media/pwc/pwc-timon.c                  |  316 -
 drivers/usb/media/pwc/pwc-timon.h                  |   61
 drivers/usb/media/pwc/pwc-uncompress.c             |  146
 drivers/usb/media/pwc/pwc-uncompress.h             |   41
 drivers/usb/media/pwc/pwc.h                        |  272
 drivers/usb/media/se401.c                          | 1435 -----
 drivers/usb/media/se401.h                          |  234
 drivers/usb/media/sn9c102.h                        |  218
 drivers/usb/media/sn9c102_core.c                   | 2919 ----------
 drivers/usb/media/sn9c102_hv7131d.c                |  271
 drivers/usb/media/sn9c102_mi0343.c                 |  363 -
 drivers/usb/media/sn9c102_ov7630.c                 |  401 -
 drivers/usb/media/sn9c102_pas106b.c                |  307 -
 drivers/usb/media/sn9c102_pas202bca.c              |  238
 drivers/usb/media/sn9c102_pas202bcb.c              |  293 -
 drivers/usb/media/sn9c102_sensor.h                 |  389 -
 drivers/usb/media/sn9c102_tas5110c1b.c             |  159
 drivers/usb/media/sn9c102_tas5130d1b.c             |  169
 drivers/usb/media/stv680.c                         | 1508 -----
 drivers/usb/media/stv680.h                         |  227
 drivers/usb/media/ultracam.c                       |  679 --
 drivers/usb/media/usbvideo.c                       | 2190 -------
 drivers/usb/media/usbvideo.h                       |  394 -
 drivers/usb/media/vicam.c                          | 1411 ----
 drivers/usb/media/w9968cf.c                        | 3691 ------------
 drivers/usb/media/w9968cf.h                        |  330 -
 drivers/usb/media/w9968cf_decoder.h                |   86
 drivers/usb/media/w9968cf_vpp.h                    |   40
 drivers/usb/media/zc0301.h                         |  192
 drivers/usb/media/zc0301_core.c                    | 2055 -------
 drivers/usb/media/zc0301_pas202bcb.c               |  361 -
 drivers/usb/media/zc0301_sensor.h                  |  103
 include/media/cs53l32a.h                           |   34
 include/media/wm8775.h                             |   35
 182 files changed, 47249 insertions(+), 47172 deletions(-)


