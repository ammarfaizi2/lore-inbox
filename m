Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJCXXm>; Thu, 3 Oct 2002 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJCXXm>; Thu, 3 Oct 2002 19:23:42 -0400
Received: from imail.ricis.com ([64.244.234.16]:2820 "EHLO imail.ricis.com")
	by vger.kernel.org with ESMTP id <S261411AbSJCXXm>;
	Thu, 3 Oct 2002 19:23:42 -0400
Date: Thu, 3 Oct 2002 13:29:24 -0500
From: Lee Leahu <lee@ricis.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.40 and QUEUE_TASK compile errors
Message-Id: <20021003132924.4a067a5a.lee@ricis.com>
Organization: RICIS, Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Note: Send abuse reports to abuse@[(Private IP)].
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rasmus had posted a patch on linux.kernel newsgroup i found on gropus.google.com.  Unfortunately,  the patch doesn't work on my code.

im using the 2.5.40 kernel.  Please advise.


This command:


ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o  --end-group  -o .tmp_vmlinux


Produces these errors:

fs/built-in.o: In function `pagebuf_queue_task':
fs/built-in.o(.text+0xa96df): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone':
fs/built-in.o(.text+0xa9781): undefined reference to `queue_task'
fs/built-in.o: In function `pagebuf_iodone_daemon':
fs/built-in.o(.text+0xaa0ba): undefined reference to `TQ_ACTIVE'
fs/built-in.o(.text+0xaa0e8): undefined reference to `run_task_queue'
