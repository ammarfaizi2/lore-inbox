Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSH1Opi>; Wed, 28 Aug 2002 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSH1Opi>; Wed, 28 Aug 2002 10:45:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48785 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318856AbSH1Oph>; Wed, 28 Aug 2002 10:45:37 -0400
Subject: LTP Nightly BK Test Failure
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, scott.feldman@intel.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 09:40:03 -0500
Message-Id: <1030545604.2601.3.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The nightly bk testing last night found a build error that I don't
believe showed up in the stock 2.5.32.

This bk tree covered up to cset 1.523.1.3 and there were several e100
driver updates immediately following the 2.5.32 tag that are probably
the likely suspects.  Here's the end of the compile log:

  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/
i386/kernel/init_task.o init/init.o --start-group
arch/i386/kernel/kernel.o arch
/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
security/built-in.o /ker
nel/bk/linux-2.5/arch/i386/lib/lib.a lib/lib.a
/kernel/bk/linux-2.5/arch/i386/li
b/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o
net/network.o --end
-group -o vmlinux
drivers/built-in.o: In function `e100_diag_config_loopback':
drivers/built-in.o(.text+0x49393): undefined reference to
`e100_force_speed_dupl
ex'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory `/kernel/bk/linux-2.5'
make: *** [bzImage] Error 2


Thanks,
Paul Larson

