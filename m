Return-Path: <linux-kernel-owner+w=401wt.eu-S1762263AbWLJRXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762263AbWLJRXn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762273AbWLJRXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:23:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37456 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762263AbWLJRXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:23:41 -0500
Subject: Re: [PATCH 000/116] V4L/DVB updates
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061210112430.PS733549000000@infradead.org>
References: <20061210112430.PS733549000000@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 10 Dec 2006 15:23:25 -0200
Message-Id: <1165771406.5419.61.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-12-10 às 09:24 -0200, Mauro Carvalho Chehab escreveu:
> Linus,
> 
> Please pull 'master' from:
>         git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

I've found a last-time bug at usbvision, resulting on OOPS in power-off
mode. So, I've added it also to my -git tree:

	- Fix container_of pointer retreival

Btw, it seems that my mailbomb script doesn't know basic arithmetics...
it were 131 patches, but it stopped counting at 116... Except for
missing some patches at the end, the rest of the script worked well,
including the diffstat part.

Now, the v4l/dvb series contains 132 patches to be pulled.

This is the diffstat for the hole bunch:

 Documentation/dvb/cards.txt                       |    4
 Documentation/video4linux/CARDLIST.cx88           |    2
 Documentation/video4linux/CARDLIST.saa7134        |    7
 Documentation/video4linux/cafe_ccic               |   54
 Documentation/video4linux/zr36120.txt             |  162 -
 drivers/media/Kconfig                             |    2
 drivers/media/common/ir-keymaps.c                 |   55
 drivers/media/common/saa7146_i2c.c                |   16
 drivers/media/dvb/b2c2/Kconfig                    |    1
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c         |   10
 drivers/media/dvb/bt8xx/Kconfig                   |    2
 drivers/media/dvb/bt8xx/dvb-bt8xx.c               |    9
 drivers/media/dvb/bt8xx/dvb-bt8xx.h               |    2
 drivers/media/dvb/cinergyT2/cinergyT2.c           |   13
 drivers/media/dvb/dvb-usb/Kconfig                 |   14
 drivers/media/dvb/dvb-usb/Makefile                |    3
 drivers/media/dvb/dvb-usb/a800.c                  |   36
 drivers/media/dvb/dvb-usb/cxusb.c                 |  271 +-
 drivers/media/dvb/dvb-usb/dib0700.h               |    5
 drivers/media/dvb/dvb-usb/dib0700_core.c          |   40
 drivers/media/dvb/dvb-usb/dib0700_devices.c       |  200 ++
 drivers/media/dvb/dvb-usb/dibusb-mb.c             |  113 -
 drivers/media/dvb/dvb-usb/dibusb-mc.c             |   26
 drivers/media/dvb/dvb-usb/digitv.c                |   22
 drivers/media/dvb/dvb-usb/dtt200u.c               |   24
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h           |   14
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c        |   37
 drivers/media/dvb/dvb-usb/gp8psk.c                |   22
 drivers/media/dvb/dvb-usb/nova-t-usb2.c           |   34
 drivers/media/dvb/dvb-usb/ttusb2.c                |  270 ++
 drivers/media/dvb/dvb-usb/ttusb2.h                |   70 +
 drivers/media/dvb/dvb-usb/umt-010.c               |   24
 drivers/media/dvb/dvb-usb/vp702x.c                |   20
 drivers/media/dvb/dvb-usb/vp7045.c                |   40
 drivers/media/dvb/frontends/Kconfig               |   24
 drivers/media/dvb/frontends/Makefile              |    3
 drivers/media/dvb/frontends/dib3000mc.c           |    7
 drivers/media/dvb/frontends/dib7000m.c            | 1191 ++++++++++
 drivers/media/dvb/frontends/dib7000m.h            |   51
 drivers/media/dvb/frontends/dib7000p.c            | 1019 ++++++++
 drivers/media/dvb/frontends/dib7000p.h            |   46
 drivers/media/dvb/frontends/dibx000_common.h      |   13
 drivers/media/dvb/frontends/dvb-pll.c             |   67 -
 drivers/media/dvb/frontends/dvb-pll.h             |    7
 drivers/media/dvb/frontends/lg_h06xf.h            |   64 -
 drivers/media/dvb/frontends/lgdt330x.c            |  257 +-
 drivers/media/dvb/frontends/lgdt330x_priv.h       |   15
 drivers/media/dvb/frontends/lgh06xf.c             |  134 +
 drivers/media/dvb/frontends/lgh06xf.h             |   35
 drivers/media/dvb/frontends/or51132.c             |  176 +
 drivers/media/dvb/frontends/or51211.c             |  124 -
 drivers/media/dvb/frontends/tda1004x.c            |   10
 drivers/media/dvb/frontends/tda1004x.h            |    5
 drivers/media/dvb/frontends/tda8083.c             |   30
 drivers/media/dvb/frontends/tda826x.c             |   12
 drivers/media/dvb/frontends/tua6100.c             |    3
 drivers/media/dvb/ttpci/Kconfig                   |    1
 drivers/media/dvb/ttpci/av7110.c                  |    2
 drivers/media/dvb/ttpci/av7110_ir.c               |   25
 drivers/media/dvb/ttpci/budget-av.c               |   26
 drivers/media/dvb/ttpci/budget-ci.c               |  334 ++-
 drivers/media/dvb/ttpci/budget.c                  |    2
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |   11
 drivers/media/video/Kconfig                       |   31
 drivers/media/video/Makefile                      |    6
 drivers/media/video/bt8xx/bttv-driver.c           |    2
 drivers/media/video/bt8xx/bttv-input.c            |  101 -
 drivers/media/video/cafe_ccic-regs.h              |  160 +
 drivers/media/video/cafe_ccic.c                   | 2228 ++++++++++++++++++
 drivers/media/video/cx88/Kconfig                  |    1
 drivers/media/video/cx88/cx88-blackbird.c         |  179 +
 drivers/media/video/cx88/cx88-cards.c             |   86 -
 drivers/media/video/cx88/cx88-dvb.c               |  333 +--
 drivers/media/video/cx88/cx88-input.c             |   77 -
 drivers/media/video/cx88/cx88-mpeg.c              |  348 +++
 drivers/media/video/cx88/cx88-tvaudio.c           |   13
 drivers/media/video/cx88/cx88-video.c             |   32
 drivers/media/video/cx88/cx88.h                   |   47
 drivers/media/video/ir-kbd-i2c.c                  |   46
 drivers/media/video/mxb.c                         |    8
 drivers/media/video/ov7670.c                      | 1333 +++++++++++
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |   16
 drivers/media/video/pvrusb2/pvrusb2-hdw.c         |   26
 drivers/media/video/pvrusb2/pvrusb2-i2c-core.c    |   81 +
 drivers/media/video/saa7115.c                     |   18
 drivers/media/video/saa7134/saa7134-alsa.c        |   63 -
 drivers/media/video/saa7134/saa7134-cards.c       |  222 ++
 drivers/media/video/saa7134/saa7134-core.c        |   11
 drivers/media/video/saa7134/saa7134-dvb.c         |  222 ++
 drivers/media/video/saa7134/saa7134-i2c.c         |    1
 drivers/media/video/saa7134/saa7134-input.c       |   76 +
 drivers/media/video/saa7134/saa7134.h             |    8
 drivers/media/video/stv680.c                      |   21
 drivers/media/video/tda9887.c                     |    6
 drivers/media/video/tuner-core.c                  |    4
 drivers/media/video/tuner-simple.c                |    4
 drivers/media/video/tuner-types.c                 |   15
 drivers/media/video/tveeprom.c                    |    9
 drivers/media/video/usbvideo/quickcam_messenger.c |    9
 drivers/media/video/usbvision/Kconfig             |   12
 drivers/media/video/usbvision/Makefile            |    5
 drivers/media/video/usbvision/usbvision-cards.c   |  157 +
 drivers/media/video/usbvision/usbvision-core.c    | 2554 +++++++++++++++++++++
 drivers/media/video/usbvision/usbvision-i2c.c     |  567 +++++
 drivers/media/video/usbvision/usbvision-video.c   | 2051 +++++++++++++++++
 drivers/media/video/usbvision/usbvision.h         |  558 +++++
 drivers/media/video/v4l1-compat.c                 |   18
 drivers/media/video/v4l2-common.c                 |   85 +
 drivers/media/video/videodev.c                    |  173 +
 drivers/media/video/vivi.c                        |   16
 drivers/media/video/zr36120.c                     | 2079 -----------------
 drivers/media/video/zr36120.h                     |  279 --
 drivers/media/video/zr36120_i2c.c                 |  132 -
 drivers/media/video/zr36120_mem.c                 |   78 -
 drivers/media/video/zr36120_mem.h                 |    3
 include/linux/i2c-id.h                            |    2
 include/linux/videodev2.h                         |    1
 include/media/ir-common.h                         |    1
 include/media/saa7146.h                           |   20
 include/media/tuner-types.h                       |    4
 include/media/tuner.h                             |    1
 include/media/tveeprom.h                          |    2
 include/media/v4l2-common.h                       |    7
 include/media/v4l2-dev.h                          |   14
 124 files changed, 15643 insertions(+), 4337 deletions(-)
 create mode 100644 Documentation/video4linux/cafe_ccic
 delete mode 100644 Documentation/video4linux/zr36120.txt
 create mode 100644 drivers/media/dvb/dvb-usb/ttusb2.c
 create mode 100644 drivers/media/dvb/dvb-usb/ttusb2.h
 create mode 100644 drivers/media/dvb/frontends/dib7000m.c
 create mode 100644 drivers/media/dvb/frontends/dib7000m.h
 create mode 100644 drivers/media/dvb/frontends/dib7000p.c
 create mode 100644 drivers/media/dvb/frontends/dib7000p.h
 delete mode 100644 drivers/media/dvb/frontends/lg_h06xf.h
 create mode 100644 drivers/media/dvb/frontends/lgh06xf.c
 create mode 100644 drivers/media/dvb/frontends/lgh06xf.h
 create mode 100644 drivers/media/video/cafe_ccic-regs.h
 create mode 100644 drivers/media/video/cafe_ccic.c
 create mode 100644 drivers/media/video/ov7670.c
 create mode 100644 drivers/media/video/usbvision/Kconfig
 create mode 100644 drivers/media/video/usbvision/Makefile
 create mode 100644 drivers/media/video/usbvision/usbvision-cards.c
 create mode 100644 drivers/media/video/usbvision/usbvision-core.c
 create mode 100644 drivers/media/video/usbvision/usbvision-i2c.c
 create mode 100644 drivers/media/video/usbvision/usbvision-video.c
 create mode 100644 drivers/media/video/usbvision/usbvision.h
 delete mode 100644 drivers/media/video/zr36120.c
 delete mode 100644 drivers/media/video/zr36120.h
 delete mode 100644 drivers/media/video/zr36120_i2c.c
 delete mode 100644 drivers/media/video/zr36120_mem.c
 delete mode 100644 drivers/media/video/zr36120_mem.h

Cheers, 
Mauro.

