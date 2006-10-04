Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbWJDLxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWJDLxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWJDLxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:53:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030523AbWJDLxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:53:46 -0400
Message-Id: <20061004114817.PS52864700000@infradead.org>
Date: Wed, 04 Oct 2006 08:48:17 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] V4L/DVB fixes and trivial patches to 2.6.19
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these from master branch at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

It contains the Kconfig fix and several small patches, mostly fixes:

   - Remove Kconfig item for DiB7000M support
   - Saa713x audio fixes
   - Fix: set antenna input for DVB-T for Asus P7131 Dual hybrid
   - Add support for the ASUS EUROPA2 OEM board
   - SAA713x: fixed compile warning in SECAM fixup
   - Do not enable VIDEO_V4L2 unconditionally
   - 4linux: complete conversion to hotplug safe PCI API
   - Add tveeprom support for Philips FM1236/FM1216ME MK5
   - Radio: No need to return void
   - Fix warning when compiling on x86_i64

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 Documentation/video4linux/CARDLIST.saa7134    |    1 
 drivers/media/Kconfig                         |    1 
 drivers/media/dvb/dvb-usb/Kconfig             |    1 
 drivers/media/dvb/dvb-usb/usb-urb.c           |    5 +
 drivers/media/radio/radio-gemtek-pci.c        |    2 -
 drivers/media/video/saa7134/saa7134-cards.c   |   35 +++++++++
 drivers/media/video/saa7134/saa7134-dvb.c     |   44 +++++++++++-
 drivers/media/video/saa7134/saa7134-tvaudio.c |   93 +++++++++++--------------
 drivers/media/video/saa7134/saa7134-video.c   |   60 ++++++++++++++++
 drivers/media/video/saa7134/saa7134.h         |    2 -
 drivers/media/video/tveeprom.c                |    4 +
 drivers/media/video/zoran_card.c              |   10 ++-
 drivers/media/video/zr36120.c                 |   21 +++---
 13 files changed, 202 insertions(+), 77 deletions(-)

