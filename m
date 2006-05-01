Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWEATyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWEATyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWEATyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:54:01 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38877 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932213AbWEATx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:53:56 -0400
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@us.ibm.com, frankeh@us.ibm.com
Subject: [PATCH 6/7] uts namespaces: remove system_utsname
References: <20060501203905.XF1836@sergelap.austin.ibm.com>
Message-ID: <20060501203906.XF1836@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: ~/Mail/SENT
Date: Mon,  1 May 2006 14:53:52 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system_utsname isn't needed now that kernel/sysctl.c is fixed.
Nuke it.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

a3dec7d619ca222d5260022c1f1f72fb61d26efc
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index a28e956..d58a406 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -81,7 +81,5 @@ static inline struct new_utsname *init_u
 	return &init_uts_ns.name;
 }
 
-#define system_utsname init_uts_ns.name
-
 extern struct rw_semaphore uts_sem;
 #endif
-- 
1.3.0


