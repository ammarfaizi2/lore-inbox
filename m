Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSGJIoW>; Wed, 10 Jul 2002 04:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317505AbSGJIoV>; Wed, 10 Jul 2002 04:44:21 -0400
Received: from [62.70.58.70] ([62.70.58.70]:9607 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317506AbSGJIoT>;
	Wed, 10 Jul 2002 04:44:19 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc1 does not compile without CONFIG_BLK_DEV_FD=y
Date: Wed, 10 Jul 2002 10:47:12 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_O2Z0WB9WZGG95MPH0HZP"
Message-Id: <200207101047.12241.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_O2Z0WB9WZGG95MPH0HZP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi all

trying to compile 2.4.19-rc1 without floppy support, I get the below link=
=20
error. .config is attached as config.gz

thanks

roy
--
ld -m elf_i386 -T /usr/src/linux-2.4.19-rc1/arch/i386/vmlinux.lds -e stex=
t=20
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o=20
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm=
=2Eo=20
fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o=20
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o=20
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o=20
drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o=20
drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.19-rc1/arch/i386/lib/lib.a=20
/usr/src/linux-2.4.19-rc1/lib/lib.a=20
/usr/src/linux-2.4.19-rc1/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
init/do_mounts.o: In function `rd_load_image':
init/do_mounts.o(.text.init+0x92b): undefined reference to `change_floppy=
'
init/do_mounts.o: In function `rd_load_disk':
init/do_mounts.o(.text.init+0xa64): undefined reference to `change_floppy=
'
make: *** [vmlinux] Error 1

--=20
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_O2Z0WB9WZGG95MPH0HZP
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
SQAA

--------------Boundary-00=_O2Z0WB9WZGG95MPH0HZP--

