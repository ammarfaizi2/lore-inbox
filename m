Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263183AbSJGUos>; Mon, 7 Oct 2002 16:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbSJGUos>; Mon, 7 Oct 2002 16:44:48 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:17822 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S263183AbSJGUoq>; Mon, 7 Oct 2002 16:44:46 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Build failure, 2.5.40-ac6
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 07 Oct 2002 16:50:25 -0400
Message-ID: <9cfit0edlda.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I decided over the weekend to give 2.5.40 a spin... if Alan's making
-ac patches, it must be at least stable enough for one of his
boxen... ;-)

I can't get it to actually compile.  Attached is my .config... the
machine is a Fujitsu Transmeta-based laptop, so it's pretty minimal
with the exception of a bunch of filesystems thrown in for fun.

The compile dies here:

make[1]: Leaving directory `/usr/src/linux-2.5.40-ac6/init'
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux
fs/built-in.o: In function `pagebuf_queue_task':
fs/built-in.o(.text+0xbfb23): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone':
fs/built-in.o(.text+0xbfbc1): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone_daemon':
fs/built-in.o(.text+0xc0620): undefined reference to `TQ_ACTIVE'
fs/built-in.o(.text+0xc0645): undefined reference to `run_task_queue'
make: *** [.tmp_vmlinux] Error 1

Clues?
TIA,
ian
