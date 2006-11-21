Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030932AbWKUM7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030932AbWKUM7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030930AbWKUM7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:59:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030927AbWKUM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:59:17 -0500
Message-Id: <20061121123202.PS8610150000@infradead.org>
Date: Tue, 21 Nov 2006 10:32:02 -0200
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] V4L/DVB bug fixes
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

We've solved a few bugs at some drivers.

Please pull 'master' from:
        git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master

It contains the following:

Some DVBS boards are miss-identified. Those two patches fixes it:
   - Fix tuning on older budget DVBS cards.
   - Budget: diseqc_method module parameter for cards with subsystem-id 13c2:1003

A var is not initialized at DVB core frontend zigzag:
   - Fix uninitialised variable in dvb_frontend_swzigzag

Spin unlock missing:
   - Add missing spin_unlock to saa6588 decoder driver

Lack of proper releasing the module:
   - Fix: Slot 0 not NULL on disconnecting SN9C10x PC Camera

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

 drivers/media/dvb/dvb-core/dvb_frontend.c    |    2 +-
 drivers/media/dvb/ttpci/budget.c             |    9 +++++++++
 drivers/media/video/et61x251/et61x251_core.c |    3 +--
 drivers/media/video/saa6588.c                |    4 +++-
 drivers/media/video/sn9c102/sn9c102_core.c   |    3 +--
 5 files changed, 15 insertions(+), 6 deletions(-)

