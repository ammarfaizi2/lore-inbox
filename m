Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWACLbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWACLbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWACLbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:31:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:14026 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751376AbWACLbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:31:05 -0500
Date: Tue, 3 Jan 2006 12:31:00 +0100
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org, dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Remove unnecessary __attribute__ ((packed))
Message-ID: <20060103113059.GC24131@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove the unnecessary __attribute__ ((packed)) since the enum itself is
packed and not the location of it in the structure.

Signed-off-by: Jan Blunck <jblunck@suse.de>

--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="afs-eliminate-packed-warnings.diff"

 fs/afs/volume.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6/fs/afs/volume.h
===================================================================
--- linux-2.6.orig/fs/afs/volume.h
+++ linux-2.6/fs/afs/volume.h
@@ -18,8 +18,6 @@
 #include "kafsasyncd.h"
 #include "cache.h"
 
-#define __packed __attribute__((packed))
-
 typedef enum {
 	AFS_VLUPD_SLEEP,		/* sleeping waiting for update timer to fire */
 	AFS_VLUPD_PENDING,		/* on pending queue */
@@ -115,7 +113,7 @@ struct afs_volume
 	struct cachefs_cookie	*cache;		/* caching cookie */
 #endif
 	afs_volid_t		vid;		/* volume ID */
-	afs_voltype_t __packed	type;		/* type of volume */
+	afs_voltype_t		type;		/* type of volume */
 	char			type_force;	/* force volume type (suppress R/O -> R/W) */
 	unsigned short		nservers;	/* number of server slots filled */
 	unsigned short		rjservers;	/* number of servers discarded due to -ENOMEDIUM */

--8S1fMsFYqgBC+BN/--
