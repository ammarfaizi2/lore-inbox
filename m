Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWBTL1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWBTL1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWBTL1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:27:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65236 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932606AbWBTL1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:27:54 -0500
Date: Mon, 20 Feb 2006 12:27:53 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Small cleanup in quota.h
Message-ID: <20060220112752.GD23302@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch just removes unused quota flag (it has been
there for quite some time - I just discovered it when I was fixing
the problem with invalidate_dquots() :)). Patch is against
2.6.16-rc4. Please apply.

							Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.16-rc4-2-dq_flags_cleanup.diff"

Remove unused quota flag.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.16-rc4-1-invalidate_dquots/include/linux/quota.h linux-2.6.16-rc4-2-dq_flags_cleanup/include/linux/quota.h
--- linux-2.6.16-rc4-1-invalidate_dquots/include/linux/quota.h	2006-01-28 09:00:17.000000000 +0100
+++ linux-2.6.16-rc4-2-dq_flags_cleanup/include/linux/quota.h	2006-02-23 18:01:10.000000000 +0100
@@ -208,7 +208,6 @@ extern struct dqstats dqstats;
 #define DQ_FAKE_B	3	/* no limits only usage */
 #define DQ_READ_B	4	/* dquot was read into memory */
 #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
-#define DQ_WAITFREE_B	6	/* dquot being waited (by invalidate_dquots) */
 
 struct dquot {
 	struct hlist_node dq_hash;	/* Hash list in memory */

--OwLcNYc0lM97+oe1--
