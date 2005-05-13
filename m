Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVEMWkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVEMWkw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVEMWjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:39:32 -0400
Received: from coderock.org ([193.77.147.115]:31125 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262586AbVEMWXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:23:18 -0400
Message-Id: <20050513222312.458729000@nd47.coderock.org>
Date: Sat, 14 May 2005 00:23:13 +0200
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
