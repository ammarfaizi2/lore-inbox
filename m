Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbUB0NS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUB0NS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:18:57 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:24004 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262856AbUB0NSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:18:31 -0500
Date: Fri, 27 Feb 2004 08:18:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] linux/README update
Message-ID: <Pine.LNX.4.58.0402270815350.17504@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to resolve http://bugzilla.kernel.org/show_bug.cgi?id=1644

The bug reporter pointed out a bit of outdated information in the README
file.

Test booted on a 32x NUMAQ with 10,000 disks

Ta
	Zwane

Index: linux-2.6.3-mm3/README
===================================================================
RCS file: /home/cvsroot/linux-2.6.3-mm3/README,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 README
--- linux-2.6.3-mm3/README	23 Feb 2004 02:02:05 -0000	1.1.1.1
+++ linux-2.6.3-mm3/README	25 Feb 2004 22:34:34 -0000
@@ -172,24 +172,15 @@ COMPILING the kernel:

    Please note that you can still run a.out user programs with this kernel.

- - Do a "make bzImage" to create a compressed kernel image.  If you want
-   to make a boot disk (without root filesystem or LILO), insert a floppy
-   in your A: drive, and do a "make bzdisk".  It is also possible to do
-   "make install" if you have lilo installed to suit the kernel makefiles,
-   but you may want to check your particular lilo setup first.
+ - Do a "make" to create a compressed kernel image. It is also
+   possible to do "make install" if you have lilo installed to suit the
+   kernel makefiles, but you may want to check your particular lilo setup first.

    To do the actual install you have to be root, but none of the normal
    build should require that. Don't take the name of root in vain.

- - In the unlikely event that your system cannot boot bzImage kernels you
-   can still compile your kernel as zImage. However, since zImage support
-   will be removed at some point in the future in favor of bzImage we
-   encourage people having problems with booting bzImage kernels to report
-   these, with detailed hardware configuration information, to the
-   linux-kernel mailing list and to H. Peter Anvin <hpa+linux@zytor.com>.
-
  - If you configured any of the parts of the kernel as `modules', you
-   will have to do "make modules" followed by "make modules_install".
+   will also have to do "make modules_install".

  - Keep a backup kernel handy in case something goes wrong.  This is
    especially true for the development releases, since each new release
@@ -200,11 +191,11 @@ COMPILING the kernel:
    do a "make modules_install".

  - In order to boot your new kernel, you'll need to copy the kernel
-   image (found in .../linux/arch/i386/boot/bzImage after compilation)
+   image (e.g. .../linux/arch/i386/boot/bzImage after compilation)
    to the place where your regular bootable kernel is found.

-   For some, this is on a floppy disk, in which case you can copy the
-   kernel bzImage file to /dev/fd0 to make a bootable floppy.
+ - Booting a kernel directly from a floppy without the assistance of a
+   bootloader such as LILO, is no longer supported.

    If you boot Linux from the hard drive, chances are you use LILO which
    uses the kernel image as specified in the file /etc/lilo.conf.  The
@@ -262,8 +253,9 @@ IF SOMETHING GOES WRONG:
    the above example it's due to a bad kernel pointer). More information
    on making sense of the dump is in Documentation/oops-tracing.txt

- - You can use the "ksymoops" program to make sense of the dump.  This
-   utility can be downloaded from
+ - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
+   as is, otherwise you will have to use the "ksymoops" program to make
+   sense of the dump.  This utility can be downloaded from
    ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops.
    Alternately you can do the dump lookup by hand:

