Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUA0Xzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUA0Xzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:55:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:52163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265799AbUA0Xzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:55:47 -0500
Date: Tue, 27 Jan 2004 15:55:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: Tim Hockin <thockin@sun.com>
Cc: torvalds@osdl.org,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040127155544.B11525@osdlab.pdx.osdl.net>
References: <20040127225311.GA9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040127225311.GA9155@sun.com>; from thockin@sun.com on Tue, Jan 27, 2004 at 02:53:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Hockin (thockin@sun.com) wrote:
> This patch changes the security interface for task_setgroups().

Minor fixup would be needed for SELinux.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== security/selinux/hooks.c 1.20 vs edited =====
--- 1.20/security/selinux/hooks.c	Tue Jan 20 17:58:48 2004
+++ edited/security/selinux/hooks.c	Tue Jan 27 15:42:41 2004
@@ -2265,7 +2265,7 @@
 	return task_has_perm(current, p, PROCESS__GETSESSION);
 }
 
-static int selinux_task_setgroups(int gidsetsize, gid_t *grouplist)
+static int selinux_task_setgroups(struct group_info *group_info)
 {
 	/* See the comment for setuid above. */
 	return 0;
