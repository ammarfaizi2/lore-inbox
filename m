Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271692AbTHHQbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTHHQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:31:24 -0400
Received: from front3.chartermi.net ([24.213.60.109]:63997 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id S271692AbTHHQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:30:52 -0400
Message-ID: <3F33D03A.7010705@quark.didntduck.org>
Date: Fri, 08 Aug 2003 12:30:50 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, kai.germaschewski@unh.edu
Subject: [PATCH] Delete initramfs_data.S.tmp
Content-Type: multipart/mixed;
 boundary="------------020302070306040405040400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302070306040405040400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This file was added to BK recently but as far as I can tell isn't needed.

--
				Brian Gerst

--------------020302070306040405040400
Content-Type: text/plain;
 name="initramfstmp-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initramfstmp-1"

diff -urN linux-2.6.0-test2-bk/initramfs_data.S.tmp linux/initramfs_data.S.tmp
--- linux-2.6.0-test2-bk/initramfs_data.S.tmp	2003-08-08 08:02:50.714038376 -0400
+++ linux/initramfs_data.S.tmp	1969-12-31 19:00:00.000000000 -0500
@@ -1,30 +0,0 @@
-/*
-  initramfs_data includes the compressed binary that is the
-  filesystem used for early user space.
-  Note: Older versions of "as" (prior to binutils 2.11.90.0.23
-  released on 2001-07-14) dit not support .incbin.
-  If you are forced to use older binutils than that then the
-  following trick can be applied to create the resulting binary:
-
-
-  ld -m elf_i386  --format binary --oformat elf32-i386 -r \
-  -T initramfs_data.scr initramfs_data.cpio.gz -o initramfs_data.o
-   ld -m elf_i386  -r -o built-in.o initramfs_data.o
-
-  initramfs_data.scr looks like this:
-SECTIONS
-{
-       .init.ramfs : { *(.data) }
-}
-
-  The above example is for i386 - the parameters vary from architectures.
-  Eventually look up LDFLAGS_BLOB in an older version of the
-  arch/$(ARCH)/Makefile to see the flags used before .incbin was introduced.
-
-  Using .incbin has the advantage over ld that the correct flags are set
-  in the ELF header, as required by certain architectures.
-*/
-
-.section .init.ramfs,"a"
-.incbin "usr/initramfs_data.cpio.gz"
-

--------------020302070306040405040400--

