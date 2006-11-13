Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754568AbWKMMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbWKMMXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbWKMMXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17105 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754554AbWKMMX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:28 -0500
Message-Id: <20061113121504.PS7687690000@infradead.org>
Date: Mon, 13 Nov 2006 10:15:04 -0200
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] V4L/DVB fixes
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

Building system fix:
   - Fix missing i2c dependency for saa7110

Bad usage of &:
   - Fix uses of "&&" where "&" was intended
   - Flexcop-usb: fix debug printk

Trivial fixes at media drivers:
   - Tda826x: use correct max frequency
   - Change tuner type for Avermedia A16AR

IR trivial fixes:
   - Cx88: fix remote control on WinFast 2000XP Expert
   - Remote support for Avermedia 777
   - Remote support for Avermedia A16AR

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/dvb/b2c2/flexcop-usb.c        |    2 +-
 drivers/media/dvb/frontends/tda826x.c       |    2 +-
 drivers/media/video/Kconfig                 |    2 +-
 drivers/media/video/bt8xx/bttv-cards.c      |    2 +-
 drivers/media/video/cx88/cx88-input.c       |   10 ++++++++--
 drivers/media/video/saa7134/saa7134-cards.c |    5 +++--
 drivers/media/video/saa7134/saa7134-input.c |   10 +++++++++-
 drivers/media/video/tveeprom.c              |    2 +-
 8 files changed, 25 insertions(+), 10 deletions(-)

