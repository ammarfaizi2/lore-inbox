Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268356AbRGWVit>; Mon, 23 Jul 2001 17:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbRGWVij>; Mon, 23 Jul 2001 17:38:39 -0400
Received: from iris.ncsl.nist.gov ([129.6.57.209]:4333 "EHLO
	iris.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S268356AbRGWViV>; Mon, 23 Jul 2001 17:38:21 -0400
Date: Mon, 23 Jul 2001 17:38:27 -0400
From: Martial MICHEL <martial@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7 : video4linux driver problem (missing files for "zoran")
Message-ID: <20010723173827.A32322@iris.ncsl.nist.gov>
Reply-To: Martial MICHEL <martial@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	When trying to    compile 2.4.7 kernel including the    "Zoran
ZR36057/36060" entry (into "Multimedia devices->Video For Linux"), the
compilation process complete on an error message :
--------------------
ld -m elf_i386 -T /usr/src/linux-2.4.7/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
        net/network.o \
        /usr/src/linux-2.4.7/arch/i386/lib/lib.a /usr/src/linux-2.4.7/lib/lib.a /usr/src/linux-2.4.7/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/media/media.o(.data+0x14): undefined reference to `init_zoran_cards'
make: *** [vmlinux] Error 1
--------------------
	After performing  a    quick    check,  it   appears      that
"init_zoran_cards" is never fully defined  in the kernel sources, only
referenced :
--------------------
find -name "*.c" | xargs fgrep init_zoran_cards
./drivers/media/video/videodev.c:extern int init_zoran_cards(struct video_init *);
./drivers/media/video/videodev.c:       {"zoran", init_zoran_cards},
--------------------
	Would it  be  possible to get  the  missing files in  order to
compile this driver ?

						Hope that helps,

PS  : Please send me  a copy of  an answer to this e-mail  as I am not
subscribed to this ML

-- 
  Martial MICHEL
E-mail    : martial@users.sourceforge.net
Home page : http://www.loria.fr/~michel/
PBM       : http://pbm.sourceforge.net/
DLC       : http://dlc.sourceforge.net/
