Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269650AbUJMHpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbUJMHpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 03:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUJMHpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 03:45:19 -0400
Received: from 221-169-69-23.adsl.static.seed.net.tw ([221.169.69.23]:51929
	"EHLO cola.voip.idv.tw") by vger.kernel.org with ESMTP
	id S269650AbUJMHpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 03:45:13 -0400
Subject: Re: 2.6.9-rc4-mm1
From: Wen-chien Jesse Sung <jesse@opnet.com.tw>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hideo AOKI <aoki@sdl.hitachi.co.jp>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097653366.6209.15.camel@libra>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 15:42:46 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/

Hi Andrew,

kernel/sysctl.c does not compile if CONFIG_SWAP=n.

--- 2.6.9-rc4-mm1/kernel/sysctl.c  (revision 16)
+++ 2.6.9-rc4-mm1/kernel/sysctl.c  (local)
@@ -813,6 +813,7 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_SWAP
 	{
 		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
 		.procname	= "swap_token_timeout",
@@ -822,6 +823,7 @@
 		.proc_handler	= &proc_dointvec_jiffies,
 		.strategy	= &sysctl_jiffies,
 	},
+#endif
 	{ .ctl_name = 0 }
 };
 
 

-- 
Best Regards,
Wen-chien Jesse Sung

