Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbSLSX35>; Thu, 19 Dec 2002 18:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbSLSX35>; Thu, 19 Dec 2002 18:29:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34688 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267424AbSLSX3y>;
	Thu, 19 Dec 2002 18:29:54 -0500
Date: Thu, 19 Dec 2002 15:37:48 -0800
From: Bob Miller <rem@osdl.org>
To: mdew <mdew@orcon.net.nz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug? undefined reference to `input_event'
Message-ID: <20021219233748.GA15419@doc.pdx.osdl.net>
References: <1040336538.7886.8.camel@nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040336538.7886.8.camel@nirvana>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 11:22:09AM +1300, mdew wrote:
> in both the 2.5.52, and bitkeeper trees, i get this error with make
> bzImage.
> 
> 
> Generating include/linux/compile.h (updated)
>   gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=pentium3
> -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=version -DKBUILD_MODNAME=version   -c -o
> init/version.o init/version.c
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> init/do_mounts.o init/initramfs.o
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
> --start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
> arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 

Stuff deleted...

> #
> # Input device support
> #
> CONFIG_INPUT=m
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> # CONFIG_INPUT_TSDEV is not set
> CONFIG_INPUT_EVDEV=m
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=m
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> 

CONFIG_INPUT and friends can NOT be configed as modules.  They must be
built into the kernel.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
