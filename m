Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWCWSJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWCWSJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWCWSJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:09:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13243 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751398AbWCWSJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:09:14 -0500
Message-Id: <20060323150607.PS67776100000@infradead.org>
Date: Thu, 23 Mar 2006 12:06:07 -0300
From: mchehab@infradead.org
To: torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull these from master branch.

It contains the following stuff:

   - saa7114: Fix i2c block write
   - saa7111: Prevent array overrun
   - zoran: Init cleanups
   - saa7111.c fix
   - bt856: Spare memory
   - saa7110: Fix array overrun
   - sem2mutex: zoran
   - cpia: correct email address
   - adv7175: Drop unused register cache
   - adv7175: Drop unused encoder dump command
   - zoran: Use i2c_master_send when possible

This time, I've updated my procedure in a way that it won't generate other bad 
patches like it was sent before.

$git cherry origin

+ 6254312352dfd1c996245cb3bc74be901dc165cc V4L/DVB (3568a): saa7114: Fix i2c block write
+ 6eb5d9ca9f1496108cb86f2d9bfc2db5d9c796fe V4L/DVB (3568b): saa7111: Prevent array overrun
+ daf72f408c66aee4ac939f614293a78841aa7717 V4L/DVB (3568c): zoran: Init cleanups
+ 58a0b84c92e62c2cc42036259a4b51e0bcaf8fa5 V4L/DVB (3568d): saa7111.c fix
+ f49a5eaea6d7b3ed3d01ca9388eac9e7e5bf6025 V4L/DVB (3568e): bt856: Spare memory
+ 6201573cc9bfe1e0bdec229bed8e95b0dc88a587 V4L/DVB (3568f): saa7110: Fix array overrun
+ 384c36893f94e0e2145832cf2f20684ae372aee5 V4L/DVB (3568g): sem2mutex: zoran
+ 2f8de1a10697efe7bee08e51b587208706b44e97 V4L/DVB (3568h): cpia: correct email address
+ 2467a670ee24631b05e91971286730e71f6a6af0 V4L/DVB (3568i): adv7175: Drop unused register cache
+ 5a313c59bcc5062fc56088d5ff9289828c4b6626 V4L/DVB (3568j): adv7175: Drop unused encoder dump command
+ 9aa45e34d2948f360f8c0e63d10f49015ca51edd V4L/DVB (3568k): zoran: Use i2c_master_send when possible


Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 drivers/media/video/adv7170.c      |   17 --
 drivers/media/video/adv7175.c      |   53 +-----
 drivers/media/video/bt819.c        |   17 --
 drivers/media/video/bt856.c        |   13 -
 drivers/media/video/cpia.c         |    2 
 drivers/media/video/saa7110.c      |   19 --
 drivers/media/video/saa7111.c      |   26 +--
 drivers/media/video/saa7114.c      |   25 +--
 drivers/media/video/saa7185.c      |   17 --
 drivers/media/video/zoran.h        |    2 
 drivers/media/video/zoran_card.c   |   49 ++----
 drivers/media/video/zoran_driver.c |  227 ++++++++++++++---------------
 12 files changed, 202 insertions(+), 265 deletions(-)
