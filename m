Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWFYTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFYTEo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWFYTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:04:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9161 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932148AbWFYTEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:04:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sSoHSrKwOgO5BRCBjHlTgTTuh2zZFRwRiocF7xqhUUbgnBOAHfs3ZLTNZvpB9AVoWWybBO81a6dw12TbhyZWKFM3IxymWAbKGl96qWbAOKZaDjQiPEo3cZIMwrOLTBoQEHDr6UoeApor720tgLk7N7cg560UFZ18g9m3TPTbnzM=
Date: Sun, 25 Jun 2006 23:05:15 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] kzalloc/kcalloc conversion
Message-ID: <20060625190515.GB7555@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janitors continue kzalloc conversion and the following was sent to
Andrew off-list. You can grab it from
http://coderock.org/kj/kzalloc/kzalloc.patch
-----------------------------------------------------------------
[PATCH] kzalloc/kcalloc conversion

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/alpha/kernel/module.c              |    3 +--
 arch/i386/kernel/cpu/intel_cacheinfo.c  |   15 +++++----------
 arch/i386/kernel/cpu/mtrr/if.c          |    3 +--
 arch/i386/kernel/cpu/mtrr/main.c        |    6 ++----
 arch/i386/kernel/io_apic.c              |    6 ++----
 arch/i386/kernel/mca.c                  |   12 ++++--------
 arch/i386/kernel/pci-dma.c              |    6 ++----
 arch/i386/mach-voyager/voyager_cat.c    |   12 ++++--------
 arch/m68k/amiga/chipram.c               |    3 +--
 arch/m68k/atari/hades-pci.c             |    3 +--
 arch/x86_64/kernel/io_apic.c            |    3 +--
 arch/x86_64/kernel/mce_amd.c            |    3 +--
 drivers/mca/mca-bus.c                   |    3 +--
 drivers/md/dm-emc.c                     |    6 ++----
 drivers/md/dm-hw-handler.c              |    6 ++----
 drivers/md/dm-mpath.c                   |   12 ++++--------
 drivers/md/dm-path-selector.c           |    6 ++----
 drivers/md/dm-table.c                   |    3 +--
 drivers/md/dm-target.c                  |    6 ++----
 drivers/media/dvb/cinergyT2/cinergyT2.c |    3 +--
 drivers/media/video/cx88/cx88-alsa.c    |    4 +---
 drivers/media/video/msp3400-driver.c    |    6 ++----
 drivers/media/video/planb.c             |    3 +--
 drivers/message/fusion/mptctl.c         |   12 ++++--------
 drivers/misc/ibmasm/command.c           |    7 ++-----
 drivers/misc/ibmasm/ibmasmfs.c          |    4 +---
 drivers/misc/ibmasm/module.c            |    3 +--
 drivers/mtd/afs.c                       |    3 +--
 drivers/mtd/chips/amd_flash.c           |    3 +--
 drivers/mtd/chips/cfi_cmdset_0001.c     |    3 +--
 drivers/mtd/chips/cfi_cmdset_0002.c     |    3 +--
 drivers/mtd/chips/gen_probe.c           |    5 ++---
 drivers/mtd/chips/jedec.c               |    3 +--
 drivers/mtd/chips/map_ram.c             |    4 +---
 drivers/mtd/chips/map_rom.c             |    4 +---
 drivers/mtd/devices/block2mtd.c         |    3 +--
 drivers/mtd/devices/ms02-nv.c           |   18 ++++++------------
 drivers/mtd/devices/phram.c             |    4 +---
 drivers/mtd/devices/pmc551.c            |    7 ++-----
 drivers/mtd/devices/slram.c             |    7 ++-----
 drivers/mtd/maps/ceiva.c                |    3 +--
 drivers/mtd/maps/omap_nor.c             |    4 +---
 drivers/mtd/maps/tqm834x.c              |    6 ++----
 drivers/mtd/maps/tqm8xxl.c              |    3 +--
 drivers/mtd/mtd_blkdevs.c               |    4 +---
 drivers/mtd/mtdblock.c                  |    7 ++-----
 drivers/mtd/mtdblock_ro.c               |    4 +---
 drivers/mtd/nand/diskonchip.c           |    5 ++---
 drivers/mtd/onenand/generic.c           |    4 +---
 drivers/net/bonding/bond_main.c         |    4 +---
 drivers/net/chelsio/mv88x201x.c         |    3 +--
 drivers/net/chelsio/sge.c               |   11 +++--------
 drivers/net/e100.c                      |    3 +--
 drivers/net/e1000/e1000_ethtool.c       |   16 +++++-----------
 drivers/net/e1000/e1000_main.c          |   22 +++++-----------------
 drivers/net/fs_enet/fs_enet-mii.c       |    3 +--
 drivers/net/irda/irda-usb.c             |    7 ++-----
 drivers/net/irda/irtty-sir.c            |    3 +--
 drivers/net/irda/vlsi_ir.c              |    4 +---
 drivers/net/iseries_veth.c              |    6 ++----
 drivers/net/lance.c                     |    3 +--
 drivers/net/loopback.c                  |    3 +--
 drivers/net/mipsnet.c                   |    3 +--
 drivers/net/pcmcia/ibmtr_cs.c           |    3 +--
 drivers/net/ppp_async.c                 |    3 +--
 drivers/net/ppp_deflate.c               |    6 ++----
 drivers/net/ppp_generic.c               |   12 ++++--------
 drivers/net/ppp_mppe.c                  |    4 +---
 drivers/net/ppp_synctty.c               |    3 +--
 drivers/net/s2io.c                      |   10 +++-------
 drivers/net/sb1250-mac.c                |    4 +---
 drivers/net/shaper.c                    |    5 +----
 drivers/net/slhc.c                      |   11 +++--------
 drivers/net/via-velocity.c              |   10 ++--------
 drivers/net/wan/c101.c                  |    3 +--
 drivers/net/wan/cosa.c                  |    3 +--
 drivers/net/wan/cycx_main.c             |    4 +---
 drivers/net/wan/cycx_x25.c              |    3 +--
 drivers/net/wan/dscc4.c                 |    6 ++----
 drivers/net/wan/farsync.c               |    3 +--
 drivers/net/wan/hdlc_fr.c               |    3 +--
 drivers/net/wan/hostess_sv11.c          |    3 +--
 drivers/net/wan/n2.c                    |    3 +--
 drivers/net/wan/sdla.c                  |    3 +--
 drivers/net/wan/sealevel.c              |    3 +--
 drivers/parport/parport_cs.c            |    3 +--
 drivers/parport/parport_serial.c        |    3 +--
 drivers/rapidio/rio-scan.c              |    6 ++----
 drivers/serial/8250_acorn.c             |    3 +--
 drivers/serial/ioc4_serial.c            |    6 ++----
 drivers/serial/ip22zilog.c              |   19 ++++---------------
 drivers/serial/jsm/jsm_tty.c            |   12 ++++--------
 drivers/serial/serial_core.c            |    7 ++-----
 drivers/serial/serial_cs.c              |    3 +--
 drivers/serial/sunsu.c                  |    4 +---
 drivers/serial/sunzilog.c               |   19 +++----------------
 drivers/telephony/ixj_pcmcia.c          |    3 +--
 fs/affs/bitmap.c                        |    6 ++----
 fs/affs/super.c                         |    3 +--
 fs/afs/vlocation.c                      |    3 +--
 fs/afs/volume.c                         |    3 +--
 fs/ext2/super.c                         |    3 +--
 fs/ext2/xattr.c                         |    3 +--
 fs/ext3/dir.c                           |    3 +--
 fs/ext3/super.c                         |    3 +--
 fs/ext3/xattr.c                         |    3 +--
 fs/hfs/bnode.c                          |    3 +--
 fs/hfs/btree.c                          |    3 +--
 fs/hfs/super.c                          |    3 +--
 fs/hfsplus/bnode.c                      |    3 +--
 fs/hfsplus/btree.c                      |    3 +--
 fs/lockd/host.c                         |    3 +--
 fs/lockd/svcsubs.c                      |    3 +--
 fs/partitions/check.c                   |    3 +--
 fs/partitions/efi.c                     |    9 +++------
 fs/proc/kcore.c                         |    6 ++----
 fs/proc/vmcore.c                        |    7 +------
 fs/udf/ialloc.c                         |    6 ++----
 fs/udf/super.c                          |    3 +--
 ipc/sem.c                               |    3 +--
 sound/core/seq/seq_device.c             |    3 +--
 sound/core/sgbuf.c                      |    9 +++------
 sound/ppc/awacs.c                       |    3 +--
 sound/ppc/daca.c                        |    3 +--
 sound/ppc/keywest.c                     |    3 +--
 sound/ppc/tumbler.c                     |    3 +--
 sound/usb/usbaudio.c                    |    3 +--
 127 files changed, 203 insertions(+), 465 deletions(-)

