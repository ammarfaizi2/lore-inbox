Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267462AbSKQFRh>; Sun, 17 Nov 2002 00:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbSKQFRh>; Sun, 17 Nov 2002 00:17:37 -0500
Received: from calc.cheney.cx ([207.70.165.48]:61630 "EHLO calc.cheney.cx")
	by vger.kernel.org with ESMTP id <S267462AbSKQFRg>;
	Sun, 17 Nov 2002 00:17:36 -0500
Date: Sat, 16 Nov 2002 23:24:34 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47+ input as module broken
Message-ID: <20021117052434.GF26199@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INPUT=m is set the following occurs:

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x39b43): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x39b5c): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x39c07): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x3a8a2): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x3a8b0): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x3a8c1): more undefined references to `input_event' follow
drivers/built-in.o(.text+0x3ad73): In function `kbd_connect':
: undefined reference to `input_open_device'
drivers/built-in.o(.text+0x3ad97): In function `kbd_disconnect':
: undefined reference to `input_close_device'
drivers/built-in.o(.init.text+0x2391): In function `kbd_init':
: undefined reference to `input_register_handler'

Chris Cheney

cc: any replies
