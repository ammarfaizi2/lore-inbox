Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936470AbWLALhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936470AbWLALhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936471AbWLALhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:37:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S936470AbWLALhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:37:36 -0500
Date: Fri, 1 Dec 2006 12:37:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20061201113740.GP11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:

Alexey Dobriyan (1):
      mqueue.h: don't include linux/types.h

Chase Venters (1):
      Fix jiffies.h comment

Eric Sesterhenn (3):
      BUG_ON conversion for drivers/media/video/pwc/pwc-if.c
      BUG_ON conversion for drivers/mmc/omap.c
      BUG_ON conversion for fs/aio.c

Jan Engelhardt (2):
      Fix typos in doc and comments
      Fix typos in drivers/isdn/hisax/isdnl2.c

Jim Cromie (2):
      fix spelling error in include/linux/kernel.h
      tabify MAINTAINERS

Matt LaPlante (5):
      Fix typos in /Documentation : 'T''
      Fix typos in /Documentation : 'U-Z'
      Fix typos in /Documentation : Misc
      Fix misc Kconfig typos
      Fix misc .c/.h comment typos


 Documentation/Changes                           |    2 
 Documentation/DMA-API.txt                       |    2 
 Documentation/DMA-ISA-LPC.txt                   |    2 
 Documentation/MSI-HOWTO.txt                     |    2 
 Documentation/accounting/taskstats.txt          |   10 -
 Documentation/block/biodoc.txt                  |   10 -
 Documentation/cpu-freq/cpufreq-nforce2.txt      |    4 
 Documentation/cpu-hotplug.txt                   |    4 
 Documentation/devices.txt                       |    8 
 Documentation/driver-model/porting.txt          |    2 
 Documentation/dvb/ci.txt                        |    4 
 Documentation/eisa.txt                          |    2 
 Documentation/filesystems/adfs.txt              |    2 
 Documentation/filesystems/configfs/configfs.txt |    4 
 Documentation/filesystems/fuse.txt              |    4 
 Documentation/filesystems/hpfs.txt              |    2 
 Documentation/filesystems/ntfs.txt              |    4 
 Documentation/filesystems/ocfs2.txt             |    2 
 Documentation/filesystems/proc.txt              |   10 -
 Documentation/filesystems/spufs.txt             |    2 
 Documentation/fujitsu/frv/gdbstub.txt           |    2 
 Documentation/fujitsu/frv/kernel-ABI.txt        |    2 
 Documentation/ide.txt                           |    2 
 Documentation/input/amijoy.txt                  |    4 
 Documentation/input/atarikbd.txt                |   12 -
 Documentation/input/yealink.txt                 |    2 
 Documentation/ioctl/cdrom.txt                   |    2 
 Documentation/kbuild/makefiles.txt              |   10 -
 Documentation/keys.txt                          |    2 
 Documentation/laptop-mode.txt                   |    8 
 Documentation/memory-barriers.txt               |    2 
 Documentation/networking/NAPI_HOWTO.txt         |   26 +-
 Documentation/networking/cs89x0.txt             |    6 
 Documentation/networking/iphase.txt             |    2 
 Documentation/networking/packet_mmap.txt        |    2 
 Documentation/networking/pktgen.txt             |    6 
 Documentation/networking/proc_net_tcp.txt       |    2 
 Documentation/networking/sk98lin.txt            |    2 
 Documentation/networking/slicecom.txt           |    2 
 Documentation/networking/wan-router.txt         |    8 
 Documentation/pnp.txt                           |    2 
 Documentation/power/pci.txt                     |    4 
 Documentation/power/states.txt                  |    2 
 Documentation/power/swsusp.txt                  |    2 
 Documentation/powerpc/booting-without-of.txt    |    8 
 Documentation/robust-futex-ABI.txt              |    2 
 Documentation/robust-futexes.txt                |    2 
 Documentation/s390/crypto/crypto-API.txt        |    4 
 Documentation/scsi/aic79xx.txt                  |    4 
 Documentation/scsi/aic7xxx_old.txt              |    4 
 Documentation/scsi/ibmmca.txt                   |   14 -
 Documentation/scsi/in2000.txt                   |    2 
 Documentation/scsi/libsas.txt                   |    2 
 Documentation/scsi/ncr53c8xx.txt                |    2 
 Documentation/scsi/scsi-changer.txt             |    4 
 Documentation/scsi/scsi_eh.txt                  |    2 
 Documentation/scsi/st.txt                       |    2 
 Documentation/scsi/sym53c8xx_2.txt              |    2 
 Documentation/sharedsubtree.txt                 |    4 
 Documentation/sound/alsa/ALSA-Configuration.txt |    2 
 Documentation/sound/alsa/Audigy-mixer.txt       |    2 
 Documentation/sound/alsa/SB-Live-mixer.txt      |    2 
 Documentation/stable_kernel_rules.txt           |    2 
 Documentation/sysctl/fs.txt                     |    2 
 Documentation/sysctl/vm.txt                     |    2 
 Documentation/uml/UserModeLinux-HOWTO.txt       |    2 
 Documentation/usb/hiddev.txt                    |    2 
 Documentation/usb/rio.txt                       |    4 
 Documentation/usb/usb-serial.txt                |    8 
 Documentation/watchdog/watchdog-api.txt         |    2 
 MAINTAINERS                                     |  144 ++++++++--------
 arch/arm/mach-ixp4xx/Kconfig                    |    2 
 arch/arm/mach-lh7a40x/Kconfig                   |    2 
 arch/arm/mach-s3c2410/Kconfig                   |    2 
 arch/arm/mm/Kconfig                             |    2 
 arch/cris/arch-v10/Kconfig                      |    2 
 arch/cris/arch-v10/drivers/Kconfig              |    2 
 arch/cris/arch-v10/drivers/eeprom.c             |    6 
 arch/cris/arch-v10/drivers/i2c.c                |    2 
 arch/cris/arch-v10/kernel/kgdb.c                |    2 
 arch/cris/arch-v32/drivers/Kconfig              |    8 
 arch/ia64/hp/common/sba_iommu.c                 |    8 
 arch/m68knommu/Kconfig                          |    4 
 arch/mips/Kconfig                               |    4 
 arch/powerpc/Kconfig                            |    2 
 arch/powerpc/platforms/83xx/Kconfig             |    4 
 arch/ppc/Kconfig                                |    2 
 arch/sh/Kconfig                                 |    2 
 arch/sh64/lib/dbg.c                             |    2 
 arch/sparc/Kconfig                              |    4 
 arch/um/drivers/chan_user.c                     |    2 
 drivers/atm/iphase.c                            |    2 
 drivers/char/Kconfig                            |    2 
 drivers/char/rio/riocmd.c                       |    2 
 drivers/char/rio/rioinit.c                      |    2 
 drivers/char/rio/rioparam.c                     |    6 
 drivers/ide/ide-floppy.c                        |    2 
 drivers/isdn/hardware/eicon/os_4bri.c           |    2 
 drivers/isdn/hisax/hfc4s8s_l1.h                 |    2 
 drivers/isdn/hisax/isdnl2.c                     |   20 +-
 drivers/media/dvb/ttpci/budget-patch.c          |    8 
 drivers/media/video/Kconfig                     |    2 
 drivers/media/video/pwc/pwc-if.c                |    3 
 drivers/message/fusion/mptbase.c                |    2 
 drivers/mmc/omap.c                              |    3 
 drivers/mtd/maps/Kconfig                        |    2 
 drivers/mtd/maps/cfi_flagadm.c                  |    2 
 drivers/net/Kconfig                             |    4 
 drivers/net/e100.c                              |    2 
 drivers/net/e1000/e1000_hw.c                    |    2 
 drivers/net/phy/Kconfig                         |    4 
 drivers/net/sk98lin/h/skdrv2nd.h                |    2 
 drivers/net/sk98lin/skdim.c                     |    4 
 drivers/net/wireless/ipw2200.c                  |    4 
 drivers/parisc/ccio-dma.c                       |    2 
 drivers/parisc/iosapic.c                        |    6 
 drivers/pci/Kconfig                             |    4 
 drivers/pci/hotplug/ibmphp_hpc.c                |    2 
 drivers/s390/net/claw.h                         |    2 
 drivers/scsi/aic94xx/aic94xx_reg_def.h          |    2 
 drivers/scsi/aic94xx/aic94xx_sds.c              |    4 
 drivers/scsi/ncr53c8xx.c                        |   14 -
 drivers/scsi/ncr53c8xx.h                        |    6 
 drivers/spi/Kconfig                             |    2 
 drivers/usb/host/Kconfig                        |    2 
 drivers/usb/host/u132-hcd.c                     |    6 
 drivers/usb/misc/usb_u132.h                     |    2 
 drivers/usb/serial/digi_acceleport.c            |    2 
 fs/Kconfig                                      |    4 
 fs/aio.c                                        |    6 
 fs/jfs/jfs_filsys.h                             |    2 
 fs/reiserfs/journal.c                           |    6 
 include/asm-m68knommu/mcfmbus.h                 |    2 
 include/asm-parisc/dma.h                        |    6 
 include/asm-parisc/pci.h                        |    2 
 include/asm-parisc/ropes.h                      |    2 
 include/linux/ixjuser.h                         |    2 
 include/linux/jiffies.h                         |    2 
 include/linux/kernel.h                          |    2 
 include/linux/mqueue.h                          |    2 
 include/linux/reiserfs_fs_sb.h                  |    2 
 include/linux/textsearch.h                      |    4 
 lib/textsearch.c                                |    2 
 net/wanrouter/af_wanpipe.c                      |    4 
 net/wanrouter/wanmain.c                         |    2 
 sound/Kconfig                                   |    4 
 sound/oss/cs46xx.c                              |    6 
 147 files changed, 344 insertions(+), 350 deletions(-)

