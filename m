Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbREVEhL>; Tue, 22 May 2001 00:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbREVEhB>; Tue, 22 May 2001 00:37:01 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:30596 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S262570AbREVEgs>; Tue, 22 May 2001 00:36:48 -0400
Message-ID: <3B09ECDB.F7FB0467@home.com>
Date: Mon, 21 May 2001 23:36:43 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11-preempt-reiserfs-3.6.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols with i2c and lm-sensors2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I compile support for my hardware sensor using 2.4.4-ac12 and the
latest CVS i2c and lm-sensors2 I get the following errors about
unresolved symbols, is this possibly due to improperly exported symbols?

Jordan

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/parport/driver.o drivers/char/char.o
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o
drivers/media/media.o drivers/char/agp/agp.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o drivers/sensors/sensor.o
drivers/input/inputdrv.o drivers/acpi/acpi.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o: In function `chr_dev_init':
drivers/char/char.o(.text.init+0x54): undefined reference to
`i2c_init_all'
drivers/sensors/sensor.o: In function `via686a_attach_adapter':
drivers/sensors/sensor.o(.text+0x10): undefined reference to
`sensors_detect'
drivers/sensors/sensor.o: In function `via686a_detect':
drivers/sensors/sensor.o(.text+0x27a): undefined reference to
`i2c_attach_client'
drivers/sensors/sensor.o(.text+0x293): undefined reference to
`sensors_register_entry'
drivers/sensors/sensor.o(.text+0x2b2): undefined reference to
`i2c_detach_client'
drivers/sensors/sensor.o: In function `via686a_detach_client':
drivers/sensors/sensor.o(.text+0x2ee): undefined reference to
`sensors_deregister_entry'
drivers/sensors/sensor.o(.text+0x2f4): undefined reference to
`i2c_detach_client'
drivers/sensors/sensor.o: In function `sensors_init_all':
drivers/sensors/sensor.o(.text.init+0x1): undefined reference to
`sensors_init'
drivers/sensors/sensor.o: In function `sensors_via686a_init':
drivers/sensors/sensor.o(.text.init+0x61): undefined reference to
`i2c_add_driver'
drivers/sensors/sensor.o: In function `via686a_cleanup':
drivers/sensors/sensor.o(.text.init+0xa1): undefined reference to
`i2c_del_driver'
drivers/sensors/sensor.o(.data+0x314): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x318): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x340): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x344): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x36c): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x370): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x398): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x39c): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x3c4): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x3c8): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x3f0): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x3f4): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x41c): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x420): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x448): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x44c): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x474): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x478): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x4a0): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x4a4): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x4cc): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x4d0): undefined reference to
`sensors_sysctl_real'
drivers/sensors/sensor.o(.data+0x4f8): undefined reference to
`sensors_proc_real'
drivers/sensors/sensor.o(.data+0x4fc): undefined reference to
`sensors_sysctl_real'
