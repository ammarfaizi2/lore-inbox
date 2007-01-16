Return-Path: <linux-kernel-owner+w=401wt.eu-S1751730AbXAPQvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXAPQvT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXAPQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:51:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46047 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbXAPQu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:50:56 -0500
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
Subject: [PATCH 44/59] sysctl: Register the sysctl number used by the arlan driver.
Date: Tue, 16 Jan 2007 09:39:49 -0700
Message-Id: <1168965670476-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/net/wireless/arlan-proc.c |    2 +-
 include/linux/sysctl.h            |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wireless/arlan-proc.c b/drivers/net/wireless/arlan-proc.c
index 5fa9854..20499a6 100644
--- a/drivers/net/wireless/arlan-proc.c
+++ b/drivers/net/wireless/arlan-proc.c
@@ -1216,7 +1216,7 @@ static ctl_table arlan_table[MAX_ARLANS + 1] =
 static ctl_table arlan_root_table[] =
 {
 	{
-		.ctl_name	= 254,
+		.ctl_name	= CTL_ARLAN,
 		.procname	= "arlan",
 		.maxlen		= 0,
 		.mode		= 0555,
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 56d0161..f4ba72e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -70,6 +70,7 @@ enum
 	CTL_BUS=8,		/* Busses */
 	CTL_ABI=9,		/* Binary emulation */
 	CTL_CPU=10,		/* CPU stuff (speed scaling, etc) */
+	CTL_ARLAN=254,		/* arlan wireless driver */
 	CTL_SUNRPC=7249,	/* sunrpc debug */
 	CTL_PM=9899,		/* frv power management */
 	CTL_FRV=9898,		/* frv specific sysctls */
-- 
1.4.4.1.g278f

