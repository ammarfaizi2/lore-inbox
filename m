Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933531AbWKWKgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933531AbWKWKgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933539AbWKWKgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:36:21 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:64656 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S933531AbWKWKgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:36:21 -0500
Date: Thu, 23 Nov 2006 02:33:06 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: d binderman <dcb314@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sys: remove unused variable
In-Reply-To: <BAY107-F19D1CB64416CC4B0CDB2959CE20@phx.gbl>
Message-ID: <Pine.LNX.4.64N.0611230231560.18515@attu4.cs.washington.edu>
References: <BAY107-F19D1CB64416CC4B0CDB2959CE20@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'new_ruid' variable.

Reported by David Binderman <dcb314@hotmail.com>.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 kernel/sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 98489d8..80f9f20 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1102,14 +1102,14 @@ asmlinkage long sys_setreuid(uid_t ruid,
 asmlinkage long sys_setuid(uid_t uid)
 {
 	int old_euid = current->euid;
-	int old_ruid, old_suid, new_ruid, new_suid;
+	int old_ruid, old_suid, new_suid;
 	int retval;
 
 	retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
 	if (retval)
 		return retval;
 
-	old_ruid = new_ruid = current->uid;
+	old_ruid = current->uid;
 	old_suid = current->suid;
 	new_suid = old_suid;
 	
