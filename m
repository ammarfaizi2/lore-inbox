Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSLJPAG>; Tue, 10 Dec 2002 10:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLJPAG>; Tue, 10 Dec 2002 10:00:06 -0500
Received: from ulima.unil.ch ([130.223.144.143]:49563 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S262215AbSLJPAE>;
	Tue, 10 Dec 2002 10:00:04 -0500
Date: Tue, 10 Dec 2002 16:07:48 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: 2.5.51 don't compil with dvb
Message-ID: <20021210150748.GB20411@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got:

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x38655): In function `try_attach_device':
: undefined reference to `MOD_CAN_QUERY'
make: *** [vmlinux] Error 1

And in the src:

rgrep -r -l try_attach_device * gives:

drivers/media/dvb/built-in.o
drivers/media/dvb/dvb-core/dvb-core.o
drivers/media/dvb/dvb-core/dvb_i2c.c
drivers/media/dvb/dvb-core/dvb_i2c.o
drivers/media/dvb/dvb-core/built-in.o
drivers/media/built-in.o
drivers/built-in.o

That's with the original 2.5.51 and with the CVS from yesterday evening
I got exactly the same...

>From my .config:

CONFIG_DVB=y
CONFIG_DVB_CORE=y
CONFIG_DVB_DEVFS_ONLY=y
CONFIG_DVB_ALPS_BSRV2=m
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
