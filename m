Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266542AbUFRTIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266542AbUFRTIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUFRTEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:04:50 -0400
Received: from outmx021.isp.belgacom.be ([195.238.2.202]:20933 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266712AbUFRTBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:01:52 -0400
Subject: [PATCH 2.6.7] syscall standardized
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-vwJBbWrat/2MvVar4W24"
Message-Id: <1087585414.2154.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Jun 2004 21:03:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vwJBbWrat/2MvVar4W24
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a __user fix for quota syscall.

Regards,
FabF

--=-vwJBbWrat/2MvVar4W24
Content-Disposition: attachment; filename=__user1.diff
Content-Type: text/x-patch; name=__user1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/quota.c edited/fs/quota.c
--- orig/fs/quota.c	2004-06-16 07:20:04.000000000 +0200
+++ edited/fs/quota.c	2004-06-18 20:51:39.830233584 +0200
@@ -264,7 +264,7 @@
  * calls. Maybe we need to add the process quotas etc. in the future,
  * but we probably should use rlimits for that.
  */
-asmlinkage long sys_quotactl(unsigned int cmd, const char *special, qid_t id, caddr_t addr)
+asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special, qid_t id, caddr_t addr)
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;

--=-vwJBbWrat/2MvVar4W24--

