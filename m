Return-Path: <linux-kernel-owner+w=401wt.eu-S1751684AbXAPRAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXAPRAJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbXAPQoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:44:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37872 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXAPQoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:44:22 -0500
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
Subject: [PATCH 42/59] sysctl: Remove sys_sysctl support from the hpet timer driver.
Date: Tue, 16 Jan 2007 09:39:47 -0700
Message-Id: <11689656683585-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

In the binary sysctl interface the hpet driver was claiming to
be the cdrom driver.  This is a no-no so remove support for the
binary interface.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/hpet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 20dc3be..81be1db 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -703,7 +703,7 @@ int hpet_control(struct hpet_task *tp, unsigned int cmd, unsigned long arg)
 
 static ctl_table hpet_table[] = {
 	{
-	 .ctl_name = 1,
+	 .ctl_name = CTL_UNNUMBERED,
 	 .procname = "max-user-freq",
 	 .data = &hpet_max_freq,
 	 .maxlen = sizeof(int),
@@ -715,7 +715,7 @@ static ctl_table hpet_table[] = {
 
 static ctl_table hpet_root[] = {
 	{
-	 .ctl_name = 1,
+	 .ctl_name = CTL_UNNUMBERED,
 	 .procname = "hpet",
 	 .maxlen = 0,
 	 .mode = 0555,
-- 
1.4.4.1.g278f

