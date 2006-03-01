Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWCALVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWCALVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWCALVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:21:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54658 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964916AbWCALVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:21:54 -0500
Date: Wed, 1 Mar 2006 12:21:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       seife@suse.de
Subject: [patch, 2.6.16] fix acpi_video_flags on x86-64
Message-ID: <20060301112130.GA1950@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Seyfried <seife@suse.de>

acpi_video_flags variable is unsigned long, so it should be set as
such. This actually matters on x86-64.

Signed-off-by: Stefan Seyfried <seife@suse.de>
Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 3f517362fe48428b9a9cb4e251238c1abd2d61c2
tree aba0516e64c74ffae6e0b7d6c0d8c95e56c15f46
parent 45979cb3442ad3f79556a0f06b0a4b76a9350860
author <pavel@amd.ucw.cz> Wed, 01 Mar 2006 12:20:15 +0100
committer <pavel@amd.ucw.cz> Wed, 01 Mar 2006 12:20:15 +0100

 kernel/sysctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c05a2b7..92ed3a3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -663,7 +663,7 @@ static ctl_table kern_table[] = {
 		.data		= &acpi_video_flags,
 		.maxlen		= sizeof (unsigned long),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_doulongvec_minmax,
 	},
 #endif
 	{ .ctl_name = 0 }

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
