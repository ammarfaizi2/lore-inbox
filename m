Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCEWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCEWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVCEWsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:48:18 -0500
Received: from coderock.org ([193.77.147.115]:47781 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261309AbVCEWnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:07 -0500
Subject: [patch 04/15] block/swim_iop: replace direct assignment with set_current_state()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:52 +0100
Message-Id: <20050305224252.DBEE71F205@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

set_current_state() is used instead of direct assignment of
current->state.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/swim_iop.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/block/swim_iop.c~set_current_state-drivers_block_swim_iop drivers/block/swim_iop.c
--- kj/drivers/block/swim_iop.c~set_current_state-drivers_block_swim_iop	2005-03-05 16:09:16.000000000 +0100
+++ kj-domen/drivers/block/swim_iop.c	2005-03-05 16:09:16.000000000 +0100
@@ -338,7 +338,7 @@ static int swimiop_eject(struct floppy_s
 			err = -EINTR;
 			break;
 		}
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 	release_drive(fs);
_
