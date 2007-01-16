Return-Path: <linux-kernel-owner+w=401wt.eu-S1751602AbXAPQqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbXAPQqu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbXAPQqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:46:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38142 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbXAPQqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:46:17 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       <netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       minyard@acm.org, openipmi-developer@lists.sourceforge.net,
       <tony.luck@intel.com>, linux-mips@linux-mips.org, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com,
       linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
       lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
       <ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
       rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
       andrea@suse.de, tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
       coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
       linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/59] sysctl: Move CTL_SUNRPC to sysctl.h where it belongs
Date: Tue, 16 Jan 2007 09:39:07 -0700
Message-Id: <116896561018-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sunrpc/debug.h |    1 -
 include/linux/sysctl.h       |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index 60fce3c..b7c7307 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -78,7 +78,6 @@ void		rpc_unregister_sysctl(void);
  * module currently registers its sysctl table dynamically, the sysctl path
  * for module FOO is <CTL_SUNRPC, CTL_FOODEBUG>.
  */
-#define CTL_SUNRPC	7249	/* arbitrary and hopefully unused */
 
 enum {
 	CTL_RPCDEBUG = 1,
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 81480e6..54a9cf5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -69,7 +69,8 @@ enum
 	CTL_DEV=7,		/* Devices */
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
-	CTL_CPU=10		/* CPU stuff (speed scaling, etc) */
+	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_SUNRPC=7249,	/* sunrpc debug */
 };
 
 /* CTL_BUS names: */
-- 
1.4.4.1.g278f

