Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753061AbWKCEEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbWKCEEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbWKCEEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:04:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45259 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753061AbWKCEEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:04:23 -0500
Message-Id: <20061103035925.PS9047100000@infradead.org>
Date: Fri, 03 Nov 2006 00:59:25 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] V4L/DVB fixes
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It contains the following:

   - Fix DBV_FE_CUSTOMISE for card drivers compiled into kernel
   - DVB: Add DVB_FE_CUSTOMISE support for MT2060
	Those two patches fixes the known regression at dvb, related
	to breakage of building system, on some unusual config selections.

   - Pvrusb2: use NULL instead of 0
	This fixes compilation warnings

   - Budget-ci: Change DEBIADDR_IR to a safer default
   - Budget-ci: Inversion setting fixed for Technotrend 1500 T
   - Fix mode switch of Compro Videomate T300
   - [saa7146_i2c] short_delay mode fixed for fast machines
	Those fixes some troubles for some specific boards.

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/common/saa7146_i2c.c                |   10 ++++------
 drivers/media/dvb/dvb-usb/Kconfig                 |   12 ++++++------
 drivers/media/dvb/frontends/Kconfig               |    2 ++
 drivers/media/dvb/frontends/bcm3510.h             |    2 +-
 drivers/media/dvb/frontends/cx22700.h             |    2 +-
 drivers/media/dvb/frontends/cx22702.h             |    2 +-
 drivers/media/dvb/frontends/cx24110.h             |    2 +-
 drivers/media/dvb/frontends/cx24123.h             |    2 +-
 drivers/media/dvb/frontends/dib3000.h             |    2 +-
 drivers/media/dvb/frontends/dib3000mc.h           |    2 +-
 drivers/media/dvb/frontends/isl6421.h             |    2 +-
 drivers/media/dvb/frontends/l64781.h              |    2 +-
 drivers/media/dvb/frontends/lgdt330x.h            |    2 +-
 drivers/media/dvb/frontends/lnbp21.h              |    2 +-
 drivers/media/dvb/frontends/mt2060.h              |    8 ++++++++
 drivers/media/dvb/frontends/mt312.h               |    2 +-
 drivers/media/dvb/frontends/mt352.h               |    2 +-
 drivers/media/dvb/frontends/nxt200x.h             |    2 +-
 drivers/media/dvb/frontends/nxt6000.h             |    2 +-
 drivers/media/dvb/frontends/or51132.h             |    2 +-
 drivers/media/dvb/frontends/or51211.h             |    2 +-
 drivers/media/dvb/frontends/s5h1420.h             |    2 +-
 drivers/media/dvb/frontends/sp8870.h              |    2 +-
 drivers/media/dvb/frontends/sp887x.h              |    2 +-
 drivers/media/dvb/frontends/stv0297.h             |    2 +-
 drivers/media/dvb/frontends/stv0299.h             |    2 +-
 drivers/media/dvb/frontends/tda10021.h            |    2 +-
 drivers/media/dvb/frontends/tda1004x.h            |    2 +-
 drivers/media/dvb/frontends/tda10086.h            |    2 +-
 drivers/media/dvb/frontends/tda8083.h             |    2 +-
 drivers/media/dvb/frontends/tda826x.h             |    2 +-
 drivers/media/dvb/frontends/tua6100.h             |    2 +-
 drivers/media/dvb/frontends/ves1820.h             |    2 +-
 drivers/media/dvb/frontends/ves1x93.h             |    2 +-
 drivers/media/dvb/frontends/zl10353.h             |    2 +-
 drivers/media/dvb/ttpci/budget-ci.c               |   10 +++++++++-
 drivers/media/video/pvrusb2/pvrusb2-cx2584x-v4l.c |    2 +-
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c        |    6 +++---
 drivers/media/video/saa7134/saa7134-dvb.c         |    2 ++
 39 files changed, 66 insertions(+), 48 deletions(-)

