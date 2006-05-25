Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWEYEBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWEYEBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWEYEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:01:49 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:9875 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964855AbWEYEBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:01:48 -0400
From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 1/3] proc: sysctl: rename proc_doutsstring to proc_do_uts_string
Date: Thu, 25 May 2006 13:53:33 +1200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060525015333.24381.32975.stgit@localhost.localdomain>
In-Reply-To: <200605241551.k4OFpOB6020988@shell0.pdx.osdl.net>
References: <200605241551.k4OFpOB6020988@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Vilain <sam.vilain@catalyst.net.nz>

'proc_doutsstring' is confusing; delimit the word with more underscores.

Cc: Serge E. Hallyn <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrey Savochkin <saw@sw.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
One Signed-off-by...

 kernel/sysctl.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 708cdcd..618a2f8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -141,7 +141,7 @@ #endif
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
-static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
+static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos);
 
 static ctl_table root_table[];
@@ -244,7 +244,7 @@ static ctl_table kern_table[] = {
 		.data		= init_uts_ns.name.sysname,
 		.maxlen		= sizeof(init_uts_ns.name.sysname),
 		.mode		= 0444,
-		.proc_handler	= &proc_doutsstring,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -253,7 +253,7 @@ static ctl_table kern_table[] = {
 		.data		= init_uts_ns.name.release,
 		.maxlen		= sizeof(init_uts_ns.name.release),
 		.mode		= 0444,
-		.proc_handler	= &proc_doutsstring,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -262,7 +262,7 @@ static ctl_table kern_table[] = {
 		.data		= init_uts_ns.name.version,
 		.maxlen		= sizeof(init_uts_ns.name.version),
 		.mode		= 0444,
-		.proc_handler	= &proc_doutsstring,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -271,7 +271,7 @@ static ctl_table kern_table[] = {
 		.data		= init_uts_ns.name.nodename,
 		.maxlen		= sizeof(init_uts_ns.name.nodename),
 		.mode		= 0644,
-		.proc_handler	= &proc_doutsstring,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -280,7 +280,7 @@ static ctl_table kern_table[] = {
 		.data		= init_uts_ns.name.domainname,
 		.maxlen		= sizeof(init_uts_ns.name.domainname),
 		.mode		= 0644,
-		.proc_handler	= &proc_doutsstring,
+		.proc_handler	= &proc_do_uts_string,
 		.strategy	= &sysctl_string,
 	},
 	{
@@ -1677,7 +1677,7 @@ int proc_dostring(ctl_table *table, int 
  *	to observe. Should this be in kernel/sys.c ????
  */
  
-static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
+static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 		  void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	int r;
@@ -2256,7 +2256,7 @@ int proc_dostring(ctl_table *table, int 
 	return -ENOSYS;
 }
 
-static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
+static int proc_do_uts_string(ctl_table *table, int write, struct file *filp,
 			    void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;

