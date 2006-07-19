Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWGSBeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWGSBeK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWGSBeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:34:10 -0400
Received: from student.uhasselt.be ([193.190.2.1]:33285 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932453AbWGSBeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:34:09 -0400
Date: Wed, 19 Jul 2006 03:34:07 +0200
To: linux-kernel@vger.kernel.org
Cc: linux-eata@i-connect.net
Subject: [PATCH 2/2] Forgotten memset
Message-ID: <20060719013407.GG30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Was this forgotten and therefore, is it necessary or useful to zero this
out?

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to current GIT or 2.6.18-rc2. Compile-tested with 
make allyesconfig.

 drivers/scsi/ide-scsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 57f460e..ee1662c 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -327,7 +327,7 @@ static int idescsi_check_condition(ide_d
 
 	/* stuff a sense request in front of our current request */
 	pc = kzalloc (sizeof (idescsi_pc_t), GFP_ATOMIC);
-	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
+	rq = kzalloc (sizeof (struct request), GFP_ATOMIC);
 	buf = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
 	if (pc == NULL || rq == NULL || buf == NULL) {
 		kfree(buf);
-- 
1.4.1.gd3ba6

