Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWAWU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWAWU2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWAWU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40133 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932475AbWAWU2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:28:09 -0500
Message-Id: <20060123202404.PS66974000000@infradead.org>
Date: Mon, 23 Jan 2006 18:24:04 -0200
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/16] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        This patch series is also available under v4l-dvb.git tree at:
                kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

        Linus, please pull these from master branch.

        The biggest change here is a removed module, whose features are now included
at a generic module.

        Also available at -git repository a devel branch with newer pending stuff for
2.6.17.

        This series contains the following stuff:

   - Added credits for em28xx-video.c
   - Add PCI ID for DigitalNow DVB-T Dual, rebranded DViCO FusionHDTV DVB-T Dual.
   - Add probe check for the tda9840.
   - VIDEO_CX88_ALSA must select SND_PCM
   - Fixes tvp5150a/am1 detection.
   - Mark Typhoon cards as Lifeview OEM's
   - Kill nxt2002 in favor of the nxt200x module
   - rename dvb_pll_tbmv30111in to dvb_pll_samsung_tbmv
   - Recognise Hauppauge card #34519
   - make VP-3054 Secondary I2C Bus Support a Kconfig option.
   - Cause tda9887 to use I2C_DRIVERID_TDA9887
   - drivers/media/dvb/ possible cleanups
   - Missing break statement on tuner-core
   - fixed spelling error, exectuted --> executed.
   - Fix printk type warning
   - changed comment in tuner-core.c

Cheers,
Mauro

---

 Documentation/video4linux/CARDLIST.cx88      |    2 
 Documentation/video4linux/CARDLIST.saa7134   |    6 
 drivers/media/dvb/b2c2/Kconfig               |    2 
 drivers/media/dvb/b2c2/flexcop-common.h      |    2 
 drivers/media/dvb/b2c2/flexcop-dma.c         |   35 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c    |   11 
 drivers/media/dvb/b2c2/flexcop-misc.c        |    6 
 drivers/media/dvb/b2c2/flexcop-pci.c         |    6 
 drivers/media/dvb/b2c2/flexcop-reg.h         |    4 
 drivers/media/dvb/dvb-usb/cxusb.c            |    8 
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 
 drivers/media/dvb/dvb-usb/dvb-usb.h          |    1 
 drivers/media/dvb/dvb-usb/vp702x.c           |    6 
 drivers/media/dvb/dvb-usb/vp702x.h           |    2 
 drivers/media/dvb/frontends/Kconfig          |   12 
 drivers/media/dvb/frontends/Makefile         |    1 
 drivers/media/dvb/frontends/dvb-pll.c        |    8 
 drivers/media/dvb/frontends/dvb-pll.h        |    2 
 drivers/media/dvb/frontends/nxt2002.c        |  706 -------------------
 drivers/media/dvb/frontends/nxt2002.h        |   23 
 drivers/media/dvb/frontends/nxt200x.c        |   58 +
 drivers/media/dvb/ttpci/av7110.h             |    2 
 drivers/media/dvb/ttpci/av7110_ir.c          |   26 
 drivers/media/video/cx88/Kconfig             |   12 
 drivers/media/video/cx88/Makefile            |    2 
 drivers/media/video/cx88/cx88-cards.c        |    6 
 drivers/media/video/em28xx/em28xx-core.c     |    2 
 drivers/media/video/em28xx/em28xx-video.c    |    3 
 drivers/media/video/saa7134/saa7134-cards.c  |   47 -
 drivers/media/video/saa7134/saa7134-dvb.c    |    2 
 drivers/media/video/saa7134/saa7134.h        |    2 
 drivers/media/video/tda9887.c                |    2 
 drivers/media/video/tuner-core.c             |    3 
 drivers/media/video/tvaudio.c                |    9 
 drivers/media/video/tvp5150.c                |   21 
 35 files changed, 171 insertions(+), 877 deletions(-)

