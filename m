Return-Path: <linux-kernel-owner+w=401wt.eu-S1751584AbXAPQ7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbXAPQ7M (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXAPQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:59:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37950 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbXAPQok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:40 -0500
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
Subject: [PATCH 1/59] sysctl x25: Remove unnecessary insert_at_head from register_sysctl_table.
Date: Tue, 16 Jan 2007 09:39:06 -0700
Message-Id: <11689656044103-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since x25 uses unique binary numbers inserting yourself at the
head of the search list for sysctls so you can override already
registered sysctls is pointless.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/x25/sysctl_net_x25.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index aabda59..94aff67 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -98,7 +98,7 @@ static struct ctl_table x25_root_table[] = {
 
 void __init x25_register_sysctl(void)
 {
-	x25_table_header = register_sysctl_table(x25_root_table, 1);
+	x25_table_header = register_sysctl_table(x25_root_table, 0);
 }
 
 void x25_unregister_sysctl(void)
-- 
1.4.4.1.g278f

