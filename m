Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275523AbTHSGiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275520AbTHSGid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:38:33 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:1152 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S272221AbTHSGfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:35:45 -0400
Date: Tue, 19 Aug 2003 16:36:57 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819063657.GK643@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux/arch/ patch (excluding ia64, mips and sh which were sent in
seperate emails)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo

--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-t3.c99.arch.patch"

diff -aur linux.backup/arch/alpha/kernel/core_titan.c linux/arch/alpha/kernel/core_titan.c
--- linux.backup/arch/alpha/kernel/core_titan.c	Sat Aug 16 15:02:35 2003
+++ linux/arch/alpha/kernel/core_titan.c	Sun Aug 17 00:34:00 2003
@@ -718,12 +718,12 @@
 
 struct alpha_agp_ops titan_agp_ops =
 {
-	setup:		titan_agp_setup,
-	cleanup:	titan_agp_cleanup,
-	configure:	titan_agp_configure,
-	bind:		titan_agp_bind_memory,
-	unbind:		titan_agp_unbind_memory,
-	translate:	titan_agp_translate
+	.setup		= titan_agp_setup,
+	.cleanup	= titan_agp_cleanup,
+	.configure	= titan_agp_configure,
+	.bind		= titan_agp_bind_memory,
+	.unbind		= titan_agp_unbind_memory,
+	.translate	= titan_agp_translate
 };
 
 alpha_agp_info *
diff -aur linux.backup/arch/arm/kernel/apm.c linux/arch/arm/kernel/apm.c
--- linux.backup/arch/arm/kernel/apm.c	Thu Jun 26 23:44:05 2003
+++ linux/arch/arm/kernel/apm.c	Sat Aug 16 17:54:50 2003
@@ -388,18 +388,18 @@
 }
 
 static struct file_operations apm_bios_fops = {
-	owner:		THIS_MODULE,
-	read:		apm_read,
-	poll:		apm_poll,
-	ioctl:		apm_ioctl,
-	open:		apm_open,
-	release:	apm_release,
+	.owner		= THIS_MODULE,
+	.read		= apm_read,
+	.poll		= apm_poll,
+	.ioctl		= apm_ioctl,
+	.open		= apm_open,
+	.release	= apm_release,
 };
 
 static struct miscdevice apm_device = {
-	minor:		APM_MINOR_DEV,
-	name:		"apm_bios",
-	fops:		&apm_bios_fops
+	.minor		= APM_MINOR_DEV,
+	.name		= "apm_bios",
+	.fops		= &apm_bios_fops
 };
 
 
diff -aur linux.backup/arch/arm26/kernel/setup.c linux/arch/arm26/kernel/setup.c
--- linux.backup/arch/arm26/kernel/setup.c	Sat Aug 16 15:02:16 2003
+++ linux/arch/arm26/kernel/setup.c	Sat Aug 16 17:55:12 2003
@@ -304,12 +304,12 @@
 
 #if defined(CONFIG_DUMMY_CONSOLE)
 struct screen_info screen_info = {
- orig_video_lines:	30,
- orig_video_cols:	80,
- orig_video_mode:	0,
- orig_video_ega_bx:	0,
- orig_video_isVGA:	1,
- orig_video_points:	8
+ .orig_video_lines	= 30,
+ .orig_video_cols	= 80,
+ .orig_video_mode	= 0,
+ .orig_video_ega_bx	= 0,
+ .orig_video_isVGA	= 1,
+ .orig_video_points	= 8
 };
 
 static int __init parse_tag_videotext(const struct tag *tag)
diff -aur linux.backup/arch/cris/arch-v10/drivers/pcf8563.c linux/arch/cris/arch-v10/drivers/pcf8563.c
--- linux.backup/arch/cris/arch-v10/drivers/pcf8563.c	Sat Aug 16 15:02:35 2003
+++ linux/arch/cris/arch-v10/drivers/pcf8563.c	Sat Aug 16 15:44:59 2003
@@ -57,10 +57,10 @@
 int pcf8563_release(struct inode *, struct file *);
 
 static struct file_operations pcf8563_fops = {
-	owner: THIS_MODULE,
-	ioctl: pcf8563_ioctl,
-	open: pcf8563_open,
-	release: pcf8563_release,
+	.owner = THIS_MODULE,
+	.ioctl = pcf8563_ioctl,
+	.open = pcf8563_open,
+	.release = pcf8563_release,
 };
 
 unsigned char
diff -aur linux.backup/arch/h8300/kernel/setup.c linux/arch/h8300/kernel/setup.c
--- linux.backup/arch/h8300/kernel/setup.c	Sat Aug 16 15:02:35 2003
+++ linux/arch/h8300/kernel/setup.c	Sat Aug 16 15:45:00 2003
@@ -91,12 +91,12 @@
 }
 
 static const struct console gdb_console = {
-	name:		"gdb_con",
-	write:		gdb_console_output,
-	device:		NULL,
-	setup:		gdb_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "gdb_con",
+	.write		= gdb_console_output,
+	.device		= NULL,
+	.setup		= gdb_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 #endif
 
@@ -260,8 +260,8 @@
 }
 
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
 };
diff -aur linux.backup/arch/ppc64/kernel/proc_ppc64.c linux/arch/ppc64/kernel/proc_ppc64.c
--- linux.backup/arch/ppc64/kernel/proc_ppc64.c	Thu Jun 26 23:46:16 2003
+++ linux/arch/ppc64/kernel/proc_ppc64.c	Sat Aug 16 18:09:20 2003
@@ -47,9 +47,9 @@
 static int     page_map_mmap( struct file *file, struct vm_area_struct *vma );
 
 static struct file_operations page_map_fops = {
-	llseek:	page_map_seek,
-	read:	page_map_read,
-	mmap:	page_map_mmap
+	.llseek	= page_map_seek,
+	.read	= page_map_read,
+	.mmap	= page_map_mmap
 };
 
 
diff -aur linux.backup/arch/ppc64/kernel/scanlog.c linux/arch/ppc64/kernel/scanlog.c
--- linux.backup/arch/ppc64/kernel/scanlog.c	Tue Mar 25 10:52:19 2003
+++ linux/arch/ppc64/kernel/scanlog.c	Sat Aug 16 15:44:59 2003
@@ -190,11 +190,11 @@
 }
 
 struct file_operations scanlog_fops = {
-	owner:		THIS_MODULE,
-	read:		scanlog_read,
-	write:		scanlog_write,
-	open:		scanlog_open,
-	release:	scanlog_release,
+	.owner		= THIS_MODULE,
+	.read		= scanlog_read,
+	.write		= scanlog_write,
+	.open		= scanlog_open,
+	.release	= scanlog_release,
 };
 
 int __init scanlog_init(void)

--1Y7d0dPL928TPQbc--
