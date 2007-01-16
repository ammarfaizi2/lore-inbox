Return-Path: <linux-kernel-owner+w=401wt.eu-S1751641AbXAPQsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXAPQsn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXAPQsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:48:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38170 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbXAPQqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:46:30 -0500
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
Subject: [PATCH 21/59] sysctl: Move CTL_PM into sysctl.h where it belongs.
Date: Tue, 16 Jan 2007 09:39:26 -0700
Message-Id: <11689656383210-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/frv/kernel/pm.c   |    1 -
 include/linux/sysctl.h |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index ee677ce..6b76466 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -125,7 +125,6 @@ unsigned long sleep_phys_sp(void *sp)
  * Use a temporary sysctl number. Horrid, but will be cleaned up in 2.6
  * when all the PM interfaces exist nicely.
  */
-#define CTL_PM 9899
 #define CTL_PM_SUSPEND 1
 #define CTL_PM_CMODE 2
 #define CTL_PM_P0 4
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 54a9cf5..e7c40b6 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -71,6 +71,7 @@ enum
 	CTL_ABI=9,		/* Binary emulation */
 	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
 	CTL_SUNRPC=7249,	/* sunrpc debug */
+	CTL_PM=9899,		/* frv power management */
 };
 
 /* CTL_BUS names: */
-- 
1.4.4.1.g278f

