Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUIGQqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUIGQqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUIGQp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:45:56 -0400
Received: from jade.spiritone.com ([216.99.193.136]:36072 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268172AbUIGQpN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:45:13 -0400
Date: Tue, 07 Sep 2004 09:45:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <544180000.1094575502@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the good news is that it compiles now, and without forcing ACPI on.
Yay!

On the downside, it seems to have a new error:

make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.

which appears partway through make install, but only if you do "make -j32",
not make -j.

  CC      fs/reiser4/plugin/file/pseudo.o
  CC      fs/reiser4/plugin/file/file.o
  CC      fs/reiser4/plugin/file/tail_conversion.o
  CC      fs/reiser4/sys_reiser4.o
  LD      fs/reiser4/reiser4.o
  LD      fs/reiser4/built-in.o
  LD      fs/built-in.o
  GEN     .version
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule
.
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  AS      arch/i386/boot/bootsect.o
  AS      arch/i386/boot/setup.o
  HOSTCC  arch/i386/boot/tools/build
  AS      arch/i386/boot/compressed/head.o
  CC      arch/i386/boot/compressed/misc.o
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  LD      arch/i386/boot/bootsect
  LD      arch/i386/boot/setup
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage

