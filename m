Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWIDRFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWIDRFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIDREu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:04:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10509 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964909AbWIDREW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:04:22 -0400
Date: Mon, 4 Sep 2006 19:04:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix kernel_execve() related compile errors
Message-ID: <20060904170419.GU4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901015818.42767813.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:58:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm3:
>...
> +rename-the-provided-execve-functions-to-kernel_execve.patch
>...
>  kernel syscalls cleanup
>...

This patch fixes some typos causing compile errors.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/kernel/sys_arm.c    |    2 +-
 arch/arm26/kernel/sys_arm.c  |    2 +-
 arch/parisc/kernel/process.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc5-mm1/arch/arm/kernel/sys_arm.c.old	2006-09-03 23:32:16.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/arm/kernel/sys_arm.c	2006-09-03 23:32:24.000000000 +0200
@@ -279,7 +279,7 @@
 	return error;
 }
 
-int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	struct pt_regs regs;
 	int ret;
--- linux-2.6.18-rc5-mm1/arch/arm26/kernel/sys_arm.c.old	2006-09-03 23:32:31.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/arm26/kernel/sys_arm.c	2006-09-03 23:32:37.000000000 +0200
@@ -283,7 +283,7 @@
 }
 
 /* FIXME - see if this is correct for arm26 */
-int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	struct pt_regs regs;
         int ret;
--- linux-2.6.18-rc5-mm1/arch/parisc/kernel/process.c.old	2006-09-03 23:32:45.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/parisc/kernel/process.c	2006-09-03 23:32:50.000000000 +0200
@@ -370,7 +370,7 @@
 
 extern int __execve(const char *filename, char *const argv[],
 		char *const envp[], struct task_struct *task);
-int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 {
 	return __execve(filename, argv, envp, current);
 }

