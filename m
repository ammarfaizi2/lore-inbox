Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUFPCZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUFPCZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUFPCZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:25:02 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:14504 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266072AbUFPCY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:24:59 -0400
Subject: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087352698.8671.23.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 22:24:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the

make: *** [.tmp_vmlinux1] Error 139

problem with kernel 2.6.6.  It works fine on one of my computer, but not
the other.

The full line is

ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
--start-group  usr/built-in.o arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
lib/built-in.o  arch/i386/lib/built-in.o  drivers/built-in.o 
sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/power/built-in.o 
net/built-in.o --end-group  -o .tmp_vmlinux1
make: *** [.tmp_vmlinux1] Error 139

Both are using gcc 2.95.3.  Both are using binutils version
2.14.90.0.8.  Both have the same module-init-tools version.  Etc., etc.,
etc.

The only difference is on the nonworking one, the processor type is
Pentium M instead of Pentium 4, and I'm using different video and
ethernet drivers because the two machines have different video and
ethernet cards :P.  The nonworking one is a laptop, if that makes a
difference.  I've got the enhanced SpeedStep option enabled for it.

I found a lot of stuff on Google about this problem, but a lot of it is
old and/or just tells you to upgrade to a 2.14 of binutils, which I
have.  I get this error if I use gcc3 as well.

			--Geoff Mishkin <gmishkin@bu.edu>

