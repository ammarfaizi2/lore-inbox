Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbSJDXXI>; Fri, 4 Oct 2002 19:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262071AbSJDXXH>; Fri, 4 Oct 2002 19:23:07 -0400
Received: from hermes.domdv.de ([193.102.202.1]:54793 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S262070AbSJDXXB>;
	Fri, 4 Oct 2002 19:23:01 -0400
Message-ID: <3D9E241C.5040807@domdv.de>
Date: Sat, 05 Oct 2002 01:28:28 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Nekrasov <andy@spylog.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: bugreport: 2.4.20pre9 + i2c-2.6.5 + lm_sensors-2.6.5
References: <20021004085530.GA32299@an.local>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well known lm_sensors issue - have a look at 
http://www2.lm-sensors.nu/~lm78/

Andrey Nekrasov wrote:
> Hello.
> 
> I am try compile kernel 2.4.20pre9 + i2c-2.6.5 + lm_sensors-2.6.5.
> 
> # gcc --version
> 2.95.3
> # ld --version
> GNU ld 2.10.91
> 
> Result:
> 
> ...
> make[1]: Leaving directory `/usr/src/linux-2.4.20pre9h/arch/i386/lib'
> ld -m elf_i386 -T /usr/src/linux-2.4.20pre9h/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o
> init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
> drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
> drivers/scsi/scsidrv.o drivers/pci/driver.o drivers/video/video.o
> drivers/i2c/i2c.o drivers/md/mddev.o drivers/sensors/sensor.o \
>         net/network.o \
>         /usr/src/linux-2.4.20pre9h/arch/i386/lib/lib.a
> /usr/src/linux-2.4.20pre9h/lib/lib.a
> /usr/src/linux-2.4.20pre9h/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/i2c/i2c.o: In function `dmi_scan_machine':
> drivers/i2c/i2c.o(.text.init+0x848): multiple definition of `dmi_scan_machine'
> arch/i386/kernel/kernel.o(.text.init+0x3908): first defined here
> ld: Warning: size of symbol `dmi_scan_machine' changed from 29 to 70 in
> drivers/i2c/i2c.o
> make: *** [vmlinux] Error 1
> 
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

