Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVKGDPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVKGDPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVKGDPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:15:48 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:41910 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932416AbVKGDPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:15:48 -0500
Subject: [PATCH 00/20] V4L patchsets - fixes several things
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Krufky - V4L <mkrufky@m1k.net>,
       Johannes Stezenbach <js@linuxtv.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 01:15:15 -0200
Message-Id: <1131333315.25215.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- This patchset fixes several things on V4L tree. It also includes a
feature removal schedule for V4L1 API.
cx88-dvb needs some patches from DVB stuff to work.

 Documentation/feature-removal-schedule.txt    |   15
 Documentation/video4linux/CARDLIST.saa7134    |    5
 drivers/media/video/Makefile                  |    3
 drivers/media/video/cs53l32a.c                |   10
 drivers/media/video/cx88/cx88-dvb.c           |   10
 drivers/media/video/cx88/cx88-tvaudio.c       |    8
 drivers/media/video/em28xx/em28xx-cards.c     |   15
 drivers/media/video/em28xx/em28xx-core.c      |   26 -
 drivers/media/video/em28xx/em28xx-video.c     |  152 ++++----
 drivers/media/video/em28xx/em28xx.h           |    4
 drivers/media/video/msp3400.c                 |  452
+++++++++++++++---------
 drivers/media/video/saa6588.c                 |    2
 drivers/media/video/saa7134/Makefile          |    3
 drivers/media/video/saa7134/saa7134-alsa.c    |  110 +++++
 drivers/media/video/saa7134/saa7134-cards.c   |   86 +++-
 drivers/media/video/saa7134/saa7134-core.c    |   33 +
 drivers/media/video/saa7134/saa7134-dvb.c     |  208 ++++++++++-
 drivers/media/video/saa7134/saa7134-input.c   |   51 ++
 drivers/media/video/saa7134/saa7134-tvaudio.c |    3
 drivers/media/video/saa7134/saa7134.h         |   17
 drivers/media/video/tda8290.c                 |   21 -
 drivers/media/video/wm8775.c                  |   12
 include/linux/videodev2.h                     |    5
 include/media/tuner.h                         |    2
 24 files changed, 926 insertions(+), 327 deletions(-)


