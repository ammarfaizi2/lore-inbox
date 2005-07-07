Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVGGVdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVGGVdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVGGVau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:30:50 -0400
Received: from coderock.org ([193.77.147.115]:14732 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262035AbVGGVaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:21 -0400
Message-Id: <20050707213004.356023000@homer>
Date: Thu, 07 Jul 2005 23:30:04 +0200
From: domen@coderock.org
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, Christophe Lucas <clucas@rotomalug.org>,
       domen@coderock.org
Subject: [patch 1/1] drivers/cdrom/sbpcd.c: replace direct assignment with set_current_state()
Content-Disposition: inline; filename=set_current_state-drivers_cdrom_sbpcd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Lucas <clucas@rotomalug.org>



Use set_current_state() instead of direct assignment of
current->state.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Domen Puncer <domen@coderock.org>


---
 sbpcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/cdrom/sbpcd.c
===================================================================
--- quilt.orig/drivers/cdrom/sbpcd.c
+++ quilt/drivers/cdrom/sbpcd.c
@@ -830,7 +830,7 @@ static void mark_timeout_audio(u_long i)
 static void sbp_sleep(u_int time)
 {
 	sti();
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(time);
 	sti();
 }

--
