Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWGGL0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGGL0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWGGL0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:26:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20880 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932100AbWGGL0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:26:32 -0400
Date: Fri, 7 Jul 2006 13:26:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Subject: [patch] Small cleanup for locomo.c
Message-ID: <20060707112618.GA3432@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup locomo.c.

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.18-rc1-git

---
commit c0bdfd734b7b44ac557dc3880f4d327fcbbddf21
tree 75b8a00817e7aa774431f14751b288d2767781e7
parent 93c026b9d735d84f5feee174fa770423d47a30cd
author <pavel@amd.ucw.cz> Fri, 07 Jul 2006 13:23:51 +0200
committer <pavel@amd.ucw.cz> Fri, 07 Jul 2006 13:23:51 +0200

 arch/arm/common/locomo.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 6493112..fdafed7 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -506,7 +506,7 @@ locomo_init_one_child(struct locomo *lch
 		goto out;
 	}
 
-	strncpy(dev->dev.bus_id,info->name,sizeof(dev->dev.bus_id));
+	strncpy(dev->dev.bus_id, info->name, sizeof(dev->dev.bus_id));
 	/*
 	 * If the parent device has a DMA mask associated with it,
 	 * propagate it down to the children.
@@ -729,7 +729,6 @@ __locomo_probe(struct device *me, struct
 
 	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
 		locomo_init_one_child(lchip, &locomo_devices[i]);
-
 	return 0;
 
  out:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
