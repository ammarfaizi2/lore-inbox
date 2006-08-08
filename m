Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWHHCsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWHHCsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWHHCsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:48:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62088 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751214AbWHHCsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:48:03 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: 2.6.18-rc4 warning on arch/x86_64/boot/compressed/head.o
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Aug 2006 12:47:48 +1000
Message-ID: <7161.1155005268@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.18-rc4 on x86_64 gets this warning.

  gcc -Wp,-MD,arch/x86_64/boot/compressed/.head.o.d  -nostdinc -isystem /usr/lib64/gcc/x86_64-suse-linux/4.1.0/include -D__KERNEL__ -Iinclude -Iinclude2 -I$KBUILD_OUTPUT/linux/include -include include/linux/autoconf.h -D__ASSEMBLY__ -m64 -traditional -m32  -c -o arch/x86_64/boot/compressed/head.o $KBUILD_OUTPUT/linux/arch/x86_64/boot/compressed/head.S
  ld -m elf_i386  -Ttext 0x100000 -e startup_32 -m elf_i386 arch/x86_64/boot/compressed/head.o arch/x86_64/boot/compressed/misc.o arch/x86_64/boot/compressed/piggy.o -o arch/x86_64/boot/compressed/vmlinux 
ld: warning: i386:x86-64 architecture of input file `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output


