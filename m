Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVLNDRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVLNDRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLNDQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:38 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:28565 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030361AbVLNDQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:10 -0500
Message-Id: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:44 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org
Subject: [patch-mm 0/6] V4L/DVB fixes and small improvements
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 patch series for -mm is also available at:
                http://linuxtv.org/downloads/quilt.

        It contains the following stuff:

   - USB hot unplug Oops fix.
   - TTUSB DEC driver patch roundup
   - Replaces MAX()/MIN() by kernel.h max()/min() macros
   - Updates to the tveeprom eeprom checking
   - ir-kbd-gpio is now part of bttv
   - "Philips 1236D ATSC/NTSC dual in" - fix typo.


---------

 Documentation/video4linux/CARDLIST.tuner |    2
 drivers/media/dvb/cinergyT2/cinergyT2.c  |   71 +-
 drivers/media/dvb/ttusb-dec/ttusb_dec.c  |   15
 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |   53 +
 drivers/media/video/Makefile             |    5
 drivers/media/video/bttv-cards.c         |    3
 drivers/media/video/bttv-driver.c        |   13
 drivers/media/video/bttv-gpio.c          |   18
 drivers/media/video/bttv-input.c         |  688 ++++++++++++++++++++
 drivers/media/video/bttv.h               |   36 +
 drivers/media/video/bttvp.h              |    6
 drivers/media/video/ir-kbd-gpio.c        |  766 -----------------------
 drivers/media/video/msp3400.c            |   26
 drivers/media/video/tuner-simple.c       |    2
 drivers/media/video/tveeprom.c           |    2
 15 files changed, 854 insertions(+), 852 deletions(-)


