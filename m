Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131845AbRCVAPg>; Wed, 21 Mar 2001 19:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131851AbRCVAP0>; Wed, 21 Mar 2001 19:15:26 -0500
Received: from bromo.med.uc.edu ([129.137.201.8]:35588 "EHLO bromo.med.uc.edu")
	by vger.kernel.org with ESMTP id <S131845AbRCVAPL>;
	Wed, 21 Mar 2001 19:15:11 -0500
Date: Wed, 21 Mar 2001 19:14:13 -0500 (EST)
From: Jack Howarth <howarth@bromo.med.uc.edu>
Message-Id: <200103220014.TAA17639@bromo.med.uc.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre6 build problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Is anyone else seeing this build problem on linux
2.4.3-pre6? On linuxppc using out bitkeeper linuxppc_2_4
archive which has been updated to linux 2.4.3-pre6 I see
the following failure...

ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/hea
t/main.o init/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kern
el.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/xmon/x.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o dri
t/net.o drivers/media/media.o  drivers/ide/idedriver.o drivers/scsi/scsid
ivers/scsi/aic7xxx/aic7xxx_drv.o drivers/cdrom/driver.o drivers/pci/drive
vers/macintosh/macintosh.o drivers/video/video.o drivers/input/inputdrv.o
	net/network.o \
	/usr/src/redhat/BUILD/kernel-2.4.3-pre6/linux/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/net/net.o: In function `pcnet32_open':
drivers/net/net.o(.text+0xdbc0): undefined reference to `is_valid_ether_a
drivers/net/net.o(.text+0xdbc0): relocation truncated to fit: R_PPC_REL24
id_ether_addr
drivers/net/net.o: In function `pcnet32_probe1':
drivers/net/net.o(.text.init+0xf2c): undefined reference to `is_valid_eth
'
drivers/net/net.o(.text.init+0xf2c): relocation truncated to fit: R_PPC_R
_valid_ether_addr

Does anyone have a patch for drivers/net/pcnet32.c to fix this?
                              Jack Howarth
