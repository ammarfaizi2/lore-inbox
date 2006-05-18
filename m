Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWERPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWERPvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWERPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:51:05 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53949 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932087AbWERPvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:51:03 -0400
Date: Thu, 18 May 2006 10:50:54 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: [PATCH 8/9] namespaces: utsname: remove system_utsname
Message-ID: <20060518155054.GI28344@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518154700.GA28344@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system_utsname isn't needed now that kernel/sysctl.c is fixed.
Nuke it.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 include/linux/utsname.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

8b2614c2cad35f261afe2fde3fec8a393126e095
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index e6120e7..15dafa9 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -86,7 +86,5 @@ static inline struct new_utsname *init_u
 	return &init_uts_ns.name;
 }
 
-#define system_utsname init_uts_ns.name
-
 extern struct rw_semaphore uts_sem;
 #endif
-- 
1.1.6
