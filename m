Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSJYQFA>; Fri, 25 Oct 2002 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSJYQFA>; Fri, 25 Oct 2002 12:05:00 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:15766 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261461AbSJYQE7>;
	Fri, 25 Oct 2002 12:04:59 -0400
Date: Fri, 25 Oct 2002 17:13:03 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: odd NFS problem with 2.5.44
Message-ID: <20021025161303.GA5802@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colour me puzzled..
make -f lib/zlib_inflate/Makefile 
make -f arch/i386/lib/Makefile 
  /sbin/kallsyms .tmp_vmlinux2 > .tmp_kallsyms2.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o --end-group .tmp_kallsyms2.o -o vmlinux
ld: final link failed: No space left on device
make: *** [vmlinux] Error 1

(davej@tetrachloride:linux-2.5)$ df
Filesystem             Size   Used  Avail Use% Mounted on
/dev/hda5              43GB  1.2GB   39GB   3% /
/dev/hda1              24MB  5.5MB   18MB  25% /boot
equinox.internal:/mnt/data
                      122GB   13GB  103GB  12% /mnt/equinox

(Source directory is on /mnt/equinox)

This is building under a 2.5.44 kernel. Trying it under a 2.4.19 works.
Wierder still, cut-n-pasting the ld line that fails makes it succeed
the next time around.

Weird NFS breakage ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
