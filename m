Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTAGAqB>; Mon, 6 Jan 2003 19:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTAGAqB>; Mon, 6 Jan 2003 19:46:01 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:12482 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267271AbTAGAqA>;
	Mon, 6 Jan 2003 19:46:00 -0500
Subject: [2.5.54 Bug]: in function zaurus_tx_fixup
From: Steven Barnhart <sbarn03@softhome.net>
To: linux-kernel@vger.kernel.org
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 19:54:36 -0500
Message-Id: <1041900881.20314.19.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

For some reason after just pulling from Linus' tree I get the following
errorin built_in.o. I hate these bugs as I have no idea what file its in
so I can't actually hack/botch it :( Anyways here it is:
--snip--
ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
arch/i386/oprofile/built-in.o  net/built-in.o --end-group  -o
.tmp_vmlinux1
drivers/built-in.o: In function `zaurus_tx_fixup':
drivers/built-in.o(.text+0xd0c2d): undefined reference to `crc32_le'
make: *** [.tmp_vmlinux1] Error 1
--end snip--
-- 
Steven
sbarn03@softhome.net
GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 D516 0A94

