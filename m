Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264636AbTDZJR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 05:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbTDZJR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 05:17:27 -0400
Received: from dsl-213-023-064-149.arcor-ip.net ([213.23.64.149]:52612 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP id S264636AbTDZJR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 05:17:27 -0400
Date: Sat, 26 Apr 2003 11:29:38 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-rc1-ac2] undefined reference to `sync_dquots_dev'
Message-ID: <20030426092938.GA19569@neon.pearbough.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as with pre7-ac1/2 and rc1-ac1 I get this build error:

ld -m elf_i386 -T /usr/src/linux-2.4.20/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/char/agp/agp.o
drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o
drivers/pci/driver.o drivers/video/video.o drivers/media/media.o
drivers/isdn/vmlinux-obj.o \
        net/network.o \
        /usr/src/linux-2.4.20/arch/i386/lib/lib.a
/usr/src/linux-2.4.20/lib/lib.a /usr/src/linux-2.4.20/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o(.text+0x1baf9): In function `do_quotactl':
: undefined reference to `sync_dquots_dev'

Setting CONFIG_QUOTA helps out, but I don't want no quota support ;)

Regards,
Axel Siebenwirth
