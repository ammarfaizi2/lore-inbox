Return-Path: <linux-kernel-owner+w=401wt.eu-S1751871AbXAPREE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXAPREE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbXAPRDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:03:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37831 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXAPQoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:15 -0500
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
Subject: [PATCH 8/59] sysctl: ipx remove unnecessary insert_at_head flag
Date: Tue, 16 Jan 2007 09:39:13 -0700
Message-Id: <11689656232449-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

The sysctl numbers used are unique so setting the insert_at_head
flag servers no semantic purpose and is just confusing.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/ipx/sysctl_net_ipx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ipx/sysctl_net_ipx.c b/net/ipx/sysctl_net_ipx.c
index fa57473..0442f44 100644
--- a/net/ipx/sysctl_net_ipx.c
+++ b/net/ipx/sysctl_net_ipx.c
@@ -52,7 +52,7 @@ static struct ctl_table_header *ipx_table_header;
 
 void ipx_register_sysctl(void)
 {
-	ipx_table_header = register_sysctl_table(ipx_root_table, 1);
+	ipx_table_header = register_sysctl_table(ipx_root_table, 0);
 }
 
 void ipx_unregister_sysctl(void)
-- 
1.4.4.1.g278f

