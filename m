Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWAJVb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWAJVb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWAJVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:31:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:64933 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932360AbWAJVb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:31:56 -0500
Date: Tue, 10 Jan 2006 22:31:53 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove remaining crash_notes variable from arch/powerpc/kernel/machine_kexec.c
Message-ID: <20060110213153.GA22460@suse.de>
References: <200601101728.k0AHS4On018397@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200601101728.k0AHS4On018397@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jan 10, Linux Kernel Mailing List wrote:

> tree e1847f5547a7a426214e9ef0719eab908ee305d7
> parent 82409411571ad89d271dc46f7fa26149fad9efdf
> author Vivek Goyal <vgoyal@in.ibm.com> Tue, 10 Jan 2006 12:51:41 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 11 Jan 2006 00:01:26 -0800
> 
> [PATCH] kdump: dynamic per cpu allocation of memory for saving cpu registers


remove remaining crash_notes definition to fix compile error

/dev/shm/linux-2.6/arch/powerpc/kernel/machine_kexec.c:21: error: conflicting types for `crash_notes'
/dev/shm/linux-2.6/include/linux/kexec.h:129: error: previous declaration of `crash_notes'

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/machine_kexec.c |    6 ------
 1 files changed, 6 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/machine_kexec.c
+++ linux-2.6/arch/powerpc/kernel/machine_kexec.c
@@ -14,12 +14,6 @@
 #include <linux/threads.h>
 #include <asm/machdep.h>
 
-/*
- * Provide a dummy crash_notes definition until crash dump is implemented.
- * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
- */
-note_buf_t crash_notes[NR_CPUS];
-
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	if (ppc_md.machine_crash_shutdown)

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
