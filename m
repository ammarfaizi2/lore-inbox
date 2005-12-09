Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVLISud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVLISud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLISuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:50:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62373 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964873AbVLISuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:50:32 -0500
Subject: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 13:50:08 -0500
Message-Id: <1134154208.14363.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
with:

$ make ARCH=x86_64
  [...]
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  CHK     usr/initramfs_list
  CC      arch/x86_64/kernel/process.o
  CC      arch/x86_64/kernel/signal.o
  AS      arch/x86_64/kernel/entry.o
arch/x86_64/kernel/entry.S: Assembler messages:
arch/x86_64/kernel/entry.S:204: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
arch/x86_64/kernel/entry.S:275: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
arch/x86_64/kernel/entry.S:762: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
arch/x86_64/kernel/entry.S:815: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
arch/x86_64/kernel/entry.S:536: Error: cannot represent relocation type BFD_RELOC_64
arch/x86_64/kernel/entry.S:536: Error: cannot represent relocation type BFD_RELOC_64
arch/x86_64/kernel/entry.S:785: Error: cannot represent relocation type BFD_RELOC_64
arch/x86_64/kernel/entry.S:785: Error: cannot represent relocation type BFD_RELOC_64
make[1]: *** [arch/x86_64/kernel/entry.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

Is this a known toolchain bug?

$ as --version
GNU assembler 2.16.1 Debian GNU/Linux

Lee

