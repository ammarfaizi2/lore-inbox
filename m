Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLUScT>; Sat, 21 Dec 2002 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSLUScT>; Sat, 21 Dec 2002 13:32:19 -0500
Received: from dsl-213-023-066-023.arcor-ip.net ([213.23.66.23]:20620 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S262812AbSLUScS>; Sat, 21 Dec 2002 13:32:18 -0500
Date: Sat, 21 Dec 2002 19:39:04 +0100
From: axel@pearbough.net
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: Build error (2.5.52): undefined reference to `agp_generic_agp_3_0_enable'
Message-ID: <20021221183904.GA18166@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compilation of 2.5.52bk6 fails due to the following error :

ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o
arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o: In function `via_kt400_enable':
drivers/built-in.o(.init.text+0x4e4f): undefined reference to
`agp_generic_agp_3_0_enable'

Concerning config options:

CONFIG_AGP=y
# CONFIG_AGP3 is not set
CONFIG_AGP_VIA=y

Best regards,
Axel Siebenwirth
