Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSL0WDF>; Fri, 27 Dec 2002 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSL0WDF>; Fri, 27 Dec 2002 17:03:05 -0500
Received: from boden.synopsys.com ([204.176.20.19]:48895 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S264818AbSL0WDE>; Fri, 27 Dec 2002 17:03:04 -0500
Message-ID: <3E0CCFFD.5090007@Synopsys.COM>
Date: Fri, 27 Dec 2002 23:11:09 +0100
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021225
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.53
References: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I haven't seen this mentioned anywhere yet, but make bzImage
returns for me:

         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x14ea3): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x14ebc): In function `kd_nosound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x14f67): In function `kd_mksound':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x15c02): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x15c10): In function `kbd_bh':
: undefined reference to `input_event'
drivers/built-in.o(.text+0x15c21): more undefined references to `input_event' follow
drivers/built-in.o(.text+0x16063): In function `kbd_connect':
: undefined reference to `input_open_device'
drivers/built-in.o(.text+0x16087): In function `kbd_disconnect':
: undefined reference to `input_close_device'
drivers/built-in.o(.init.text+0xe11): In function `kbd_init':
: undefined reference to `input_register_handler'
make: *** [vmlinux] Error 1


Is this a known problem?


Regards

Harri

