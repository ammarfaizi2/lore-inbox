Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJDIuE>; Fri, 4 Oct 2002 04:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJDIuE>; Fri, 4 Oct 2002 04:50:04 -0400
Received: from mail.spylog.com ([194.67.35.220]:39874 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S261549AbSJDIuD>;
	Fri, 4 Oct 2002 04:50:03 -0400
Date: Fri, 4 Oct 2002 12:55:30 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: bugreport: 2.4.20pre9 + i2c-2.6.5 + lm_sensors-2.6.5
Message-ID: <20021004085530.GA32299@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am try compile kernel 2.4.20pre9 + i2c-2.6.5 + lm_sensors-2.6.5.

# gcc --version
2.95.3
# ld --version
GNU ld 2.10.91

Result:

...
make[1]: Leaving directory `/usr/src/linux-2.4.20pre9h/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.20pre9h/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o
init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/pci/driver.o drivers/video/video.o
drivers/i2c/i2c.o drivers/md/mddev.o drivers/sensors/sensor.o \
        net/network.o \
        /usr/src/linux-2.4.20pre9h/arch/i386/lib/lib.a
/usr/src/linux-2.4.20pre9h/lib/lib.a
/usr/src/linux-2.4.20pre9h/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/i2c/i2c.o: In function `dmi_scan_machine':
drivers/i2c/i2c.o(.text.init+0x848): multiple definition of `dmi_scan_machine'
arch/i386/kernel/kernel.o(.text.init+0x3908): first defined here
ld: Warning: size of symbol `dmi_scan_machine' changed from 29 to 70 in
drivers/i2c/i2c.o
make: *** [vmlinux] Error 1


-- 
bye.
Andrey Nekrasov, SpyLOG.
