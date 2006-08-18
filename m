Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWHRVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWHRVCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWHRVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:02:15 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:15123 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S964927AbWHRVCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:02:15 -0400
Date: Fri, 18 Aug 2006 17:02:12 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kill extraneous printk in kernel_restart()
Message-ID: <Pine.LNX.4.64.0608181650001.30597@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a reason for printing a single dot and newline in 
kernel_restart()? If not, below is a one-liner to kill it.

thanks,
  - C.

-- 

Get rid of an extraneous printk in kernel_restart().

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.6.18-rc4/kernel/sys.c~orig	2006-08-07 22:00:27.000000000 -0400
+++ linux-2.6.18-rc4/kernel/sys.c	2006-08-18 16:52:52.000000000 -0400
@@ -611,7 +611,6 @@ void kernel_restart(char *cmd)
 	} else {
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", cmd);
 	}
-	printk(".\n");
 	machine_restart(cmd);
 }
 EXPORT_SYMBOL_GPL(kernel_restart);
