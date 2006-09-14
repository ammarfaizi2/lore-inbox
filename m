Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWINVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWINVqF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWINVqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:46:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47574 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751187AbWINVqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:46:03 -0400
Date: Thu, 14 Sep 2006 22:45:59 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Brassow <jbrassow@redhat.com>
Subject: [PATCH 12/25] dm mirror: remove trailing space from table
Message-ID: <20060914214559.GT3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jonathan Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Brassow <jbrassow@redhat.com>

Remove trailing space from 'dmsetup table' output.

Signed-off-by: Jonathan Brassow <jbrassow@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-raid1.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-raid1.c	2006-09-14 20:50:09.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-raid1.c	2006-09-14 20:52:23.000000000 +0100
@@ -1213,9 +1213,9 @@ static int mirror_status(struct dm_targe
 		break;
 
 	case STATUSTYPE_TABLE:
-		DMEMIT("%d ", ms->nr_mirrors);
+		DMEMIT("%d", ms->nr_mirrors);
 		for (m = 0; m < ms->nr_mirrors; m++)
-			DMEMIT("%s %llu ", ms->mirror[m].dev->name,
+			DMEMIT(" %s %llu", ms->mirror[m].dev->name,
 				(unsigned long long)ms->mirror[m].offset);
 	}
 
