Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935408AbWKZOae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935408AbWKZOae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 09:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935411AbWKZOad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 09:30:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S935410AbWKZOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 09:30:33 -0500
Message-Id: <20061126141928.PS6336290000@infradead.org>
Date: Sun, 26 Nov 2006 12:19:28 -0200
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       V4L <video4linux-list@redhat.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] V4L/DVB fixes
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

saa717x chips are wrongly detected as saa711x:
   - Improve saa711x check

Fixes an oops on some special condition:
   - Fix oops on symbol rate==0

There is also a pending request for you, sent on Nov, 21, with 5 patches:
> Linus,
> 
> We've solved a few bugs at some drivers.
> 
> Please pull 'master' from:
>         git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git master
> 
> It contains the following:
> 
> Some DVBS boards are miss-identified. Those two patches fixes it:
>    - Fix tuning on older budget DVBS cards.
>    - Budget: diseqc_method module parameter for cards with subsystem-id 13c2:1003
> 
> A var is not initialized at DVB core frontend zigzag:
>    - Fix uninitialised variable in dvb_frontend_swzigzag
> 
> Spin unlock missing:
>    - Add missing spin_unlock to saa6588 decoder driver
> 
> Lack of proper releasing the module:
>    - Fix: Slot 0 not NULL on disconnecting SN9C10x PC Camera

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
---

The diffstat of the 7 pending patches is:

 drivers/media/dvb/dvb-core/dvb_frontend.c    |    2 +-
 drivers/media/dvb/frontends/tda10086.c       |    4 ++++
 drivers/media/dvb/ttpci/budget.c             |    9 +++++++++
 drivers/media/video/et61x251/et61x251_core.c |    3 +--
 drivers/media/video/saa6588.c                |    4 +++-
 drivers/media/video/saa7115.c                |    9 +++++++--
 drivers/media/video/sn9c102/sn9c102_core.c   |    3 +--
 7 files changed, 26 insertions(+), 8 deletions(-)

