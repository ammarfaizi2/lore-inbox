Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTE1HyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTE1HyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:54:01 -0400
Received: from [209.123.232.252] ([209.123.232.252]:10452 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S264463AbTE1Hx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:53:58 -0400
Subject: Re: [PATCH] register_ioctl32_conversion symbol exports fix
From: Andres Salomon <dilinger@voxel.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030528074701.GA17449@fs.tum.de>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com>
	 <bb1i9v$t9b$1@main.gmane.org>  <20030528074701.GA17449@fs.tum.de>
Content-Type: multipart/mixed; boundary="=-xKLjnWYNY3C59rJwzqhd"
Organization: 
Message-Id: <1054109128.598.4.camel@nrop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 04:05:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xKLjnWYNY3C59rJwzqhd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Oops, sorry.  One of these days, I will find an NNTP client that suck..


On Wed, 2003-05-28 at 03:47, Adrian Bunk wrote:
> On Wed, May 28, 2003 at 01:45:33AM -0400, Andres Salomon wrote:
> >...
> > altogether from the arch-specific stuff; so, that's what this patch does
> > (to both {,un}register_ioctl32_conversion).  Please apply (or correct me
> >...
> 
> -ENOPATCH
> 
> cu
> Adrian

--=-xKLjnWYNY3C59rJwzqhd
Content-Disposition: attachment; filename=ioctl32.diff
Content-Type: text/x-patch; name=ioctl32.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -urN a/arch/ppc64/kernel/ppc_ksyms.c b/arch/ppc64/kernel/ppc_ksyms.c
--- a/arch/ppc64/kernel/ppc_ksyms.c	2003-05-26 21:00:25.000000000 -0400
+++ b/arch/ppc64/kernel/ppc_ksyms.c	2003-05-28 01:15:26.000000000 -0400
@@ -49,8 +49,6 @@
 
 extern int sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 extern int do_signal(sigset_t *, struct pt_regs *);
-extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
-extern int unregister_ioctl32_conversion(unsigned int cmd);
 
 int abs(int);
 
@@ -66,9 +64,6 @@
 EXPORT_SYMBOL(synchronize_irq);
 #endif /* CONFIG_SMP */
 
-EXPORT_SYMBOL(register_ioctl32_conversion);
-EXPORT_SYMBOL(unregister_ioctl32_conversion);
-
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(pci_io_base);
 
diff -urN a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
--- a/arch/sparc64/kernel/sparc64_ksyms.c	2003-05-26 21:00:46.000000000 -0400
+++ b/arch/sparc64/kernel/sparc64_ksyms.c	2003-05-28 01:14:54.000000000 -0400
@@ -94,8 +94,6 @@
 extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char * filename, int flags, int mode);
-extern int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *));
-extern int unregister_ioctl32_conversion(unsigned int cmd);
 extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space);
                 
 extern int __ashrdi3(int, int);
@@ -234,10 +232,6 @@
 EXPORT_SYMBOL(pci_dma_supported);
 #endif
 
-/* IOCTL32 emulation hooks. */
-EXPORT_SYMBOL(register_ioctl32_conversion);
-EXPORT_SYMBOL(unregister_ioctl32_conversion);
-
 /* I/O device mmaping on Sparc64. */
 EXPORT_SYMBOL(io_remap_page_range);
 

--=-xKLjnWYNY3C59rJwzqhd--

