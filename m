Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVAMPJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVAMPJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVAMPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:09:35 -0500
Received: from aun.it.uu.se ([130.238.12.36]:14726 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261643AbVAMPJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:09:34 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16870.36645.790526.305715@alkaid.it.uu.se>
Date: Thu, 13 Jan 2005 16:09:25 +0100
To: benh@kernel.crashing.org, paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1 linkage error on ppc32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everything goes well until the end, when the linker complains:

  ld -m elf32ppc  -Ttext 0xc0000000 -Bstatic -o .tmp_vmlinux1 -T arch/ppc/kernel/vmlinux.lds arch/ppc/kernel/head.o arch/ppc/kernel/idle_6xx.o  init/built-in.o --start-group  usr/built-in.o  arch/ppc/kernel/built-in.o  arch/ppc/platforms/built-in.o  arch/ppc/mm/built-in.o  arch/ppc/lib/built-in.o  arch/ppc/syslib/built-in.o  arch/ppc/xmon/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group 
mm/built-in.o(.rodata.cst4+0x4): relocation truncated to fit: R_PPC_ADDR32 empty_zero_page+40000000
make: *** [.tmp_vmlinux1] Error 1

gcc-3.4.3, binutils-2.15.90.0.0-0.ydl.2 (YDL4.0 user-space).

/Mikael
