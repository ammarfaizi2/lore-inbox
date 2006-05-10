Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWEJCM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWEJCM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWEJCMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:12:32 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9193 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932389AbWEJCMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:12:00 -0400
Date: Tue, 9 May 2006 21:11:57 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 8/9] uts namespaces: remove system_utsname
Message-ID: <20060510021157.GI32523@sergelap.austin.ibm.com>
References: <29vfyljM-7.2006059-s@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system_utsname isn't needed now that kernel/sysctl.c is fixed.
Nuke it.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

5c3996795738abac87041f5c311b9ffeac2c0a50
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index b6b9801..339ad14 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -85,7 +85,5 @@ static inline struct new_utsname *init_u
 	return &init_uts_ns.name;
 }
 
-#define system_utsname init_uts_ns.name
-
 extern struct rw_semaphore uts_sem;
 #endif
-- 
1.3.0

