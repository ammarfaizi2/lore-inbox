Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTBGP4V>; Fri, 7 Feb 2003 10:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbTBGP4V>; Fri, 7 Feb 2003 10:56:21 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:48524 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S265894AbTBGP4S>; Fri, 7 Feb 2003 10:56:18 -0500
Subject: Spelling fixes for consistent, dependent, persistent in 2.5.59-bk2.
From: Steven Cole <elenstev@mesatop.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 07 Feb 2003 09:03:09 -0700
Message-Id: <1044633789.14564.402.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I'm sending Linus a patch against 2.5.59-bk2 to fix the spelling of the
following three words and their variants.  Only these particular
misspellings are fixed; more imaginative permutations are missed.

consistant -> consistent
dependant  -> dependent
persistant -> persistent

I edited the tree with the following script, which (BIG FAT WARNING) can
cause some unwanted side effects in a tree with source control (e.g.
BK). At least that is what Linus reported with a previous but similar
script. My starting -bk2 tree already had corrections for 'definite' and
'separate' fixed by that first script.

#!/bin/sh
find . -name "*" | xargs grep -l consistan | awk '{print "ex - ",$1," -c \"%s/consistan/consisten/g|x\""}' | sh
find . -name "*" | xargs grep -l dependan | awk '{print "ex - ",$1," -c \"%s/dependan/dependen/g|x\""}' | sh
find . -name "*" | xargs grep -l persistan | awk '{print "ex - ",$1," -c \"%s/persistan/persisten/g|x\""}' | sh

Since the diff is 1676 lines and 76KB, I'll conserve bandwidth and won't
post it here.  Here is the diffstat so people can see which files are
changed.

Steven

 Documentation/filesystems/ext3.txt               |    2 +-
 Documentation/isdn/HiSax.cert                    |    2 +-
 Documentation/md.txt                             |    4 ++--
 Documentation/scsi/ChangeLog.sym53c8xx           |    2 +-
 Documentation/scsi/ibmmca.txt                    |    4 ++--
 Documentation/sparc/sbus_drivers.txt             |    4 ++--
 Documentation/tipar.txt                          |    4 ++--
 Documentation/usb/silverlink.txt                 |    2 +-
 arch/arm/mach-integrator/pci_v3.c                |    2 +-
 arch/arm/mach-sa1100/stork.c                     |    2 +-
 arch/arm/mm/proc-arm920.S                        |    2 +-
 arch/arm/mm/proc-arm922.S                        |    2 +-
 arch/arm/mm/proc-arm926.S                        |    2 +-
 arch/cris/drivers/serial.c                       |    2 +-
 arch/cris/kernel/ptrace.c                        |    2 +-
 arch/ia64/kernel/smpboot.c                       |    2 +-
 arch/ia64/sn/io/sn1/pcibr.c                      |    4 ++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c            |    4 ++--
 arch/m68k/mac/macints.c                          |    2 +-
 arch/m68k/mac/via.c                              |    2 +-
 arch/m68knommu/platform/68360/uCquicc/crt0_ram.S |    2 +-
 arch/m68knommu/platform/68360/uCquicc/crt0_rom.S |    2 +-
 arch/parisc/kernel/entry.S                       |    2 +-
 arch/ppc/boot/simple/Makefile                    |    2 +-
 arch/ppc/boot/simple/misc.c                      |    2 +-
 arch/ppc/kernel/pci.c                            |    2 +-
 arch/ppc64/kernel/pci.c                          |    2 +-
 arch/sh/kernel/io.c                              |    2 +-
 arch/sparc/kernel/entry.S                        |    2 +-
 arch/sparc/kernel/sys_sparc.c                    |    2 +-
 arch/sparc/kernel/sys_sunos.c                    |    2 +-
 arch/sparc/math-emu/math.c                       |    2 +-
 arch/sparc/mm/sun4c.c                            |    2 +-
 arch/sparc64/kernel/sbus.c                       |    2 +-
 arch/sparc64/kernel/winfixup.S                   |    6 +++---
 arch/sparc64/math-emu/math.c                     |    2 +-
 arch/v850/kernel/rte_mb_a_pci.c                  |    4 ++--
 drivers/atm/lanai.c                              |    2 +-
 drivers/block/nbd.c                              |    2 +-
 drivers/char/ip2/i2ellis.c                       |    2 +-
 drivers/char/ip2/i2os.h                          |    2 +-
 drivers/char/ip2main.c                           |    2 +-
 drivers/char/nvram.c                             |    2 +-
 drivers/char/rio/riotty.c                        |    4 ++--
 drivers/char/rtc.c                               |    2 +-
 drivers/hotplug/cpci_hotplug_pci.c               |    2 +-
 drivers/hotplug/cpqphp_core.c                    |    2 +-
 drivers/hotplug/cpqphp_pci.c                     |    2 +-
 drivers/ide/pci/sis5513.c                        |    4 ++--
 drivers/isdn/eicon/eicon.h                       |    2 +-
 drivers/isdn/hisax/isdnl2.c                      |   20 ++++++++++----------
 drivers/isdn/hisax/l3dss1.c                      |    2 +-
 drivers/isdn/hisax/l3ni1.c                       |    2 +-
 drivers/isdn/hysdn/hysdn_boot.c                  |    2 +-
 drivers/media/radio/radio-zoltrix.c              |    2 +-
 drivers/mtd/chips/jedec.c                        |    2 +-
 drivers/net/acenic.c                             |    2 +-
 drivers/net/declance.c                           |    2 +-
 drivers/net/e1000/e1000_osdep.h                  |    2 +-
 drivers/net/hamradio/6pack.c                     |    8 ++++----
 drivers/net/hamradio/scc.c                       |    2 +-
 drivers/net/hamradio/yam.c                       |    2 +-
 drivers/net/rrunner.c                            |    2 +-
 drivers/net/sgiseeq.c                            |    2 +-
 drivers/net/sk98lin/skvpd.c                      |    2 +-
 drivers/net/sk98lin/skxmac2.c                    |    4 ++--
 drivers/net/skfp/cfm.c                           |    6 +++---
 drivers/net/skfp/ecm.c                           |    8 ++++----
 drivers/net/skfp/h/osdef1st.h                    |    2 +-
 drivers/net/skfp/pcmplc.c                        |    8 ++++----
 drivers/net/skfp/rmt.c                           |    6 +++---
 drivers/net/skfp/skfddi.c                        |    4 ++--
 drivers/net/wan/lmc/lmc_main.c                   |    2 +-
 drivers/net/wan/lmc/lmc_ver.h                    |    2 +-
 drivers/net/wireless/airo.c                      |    2 +-
 drivers/net/wireless/orinoco.h                   |    2 +-
 drivers/sbus/char/aurora.c                       |    2 +-
 drivers/sbus/char/bbc_envctrl.c                  |    2 +-
 drivers/scsi/aacraid/aachba.c                    |    4 ++--
 drivers/scsi/aic7xxx/aic79xx_inline.h            |    2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.h               |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_inline.h            |    2 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.h               |    2 +-
 drivers/scsi/megaraid.c                          |    2 +-
 drivers/scsi/qla1280.c                           |    2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c              |    4 ++--
 drivers/scsi/sym53c8xx_2/sym_glue.h              |    2 +-
 drivers/usb/misc/atmsar.c                        |    2 +-
 drivers/usb/serial/safe_serial.c                 |    2 +-
 drivers/usb/storage/usb.c                        |    2 +-
 drivers/video/skeletonfb.c                       |    2 +-
 fs/befs/ChangeLog                                |    2 +-
 fs/partitions/ldm.c                              |    2 +-
 include/asm-alpha/pci.h                          |   12 ++++++------
 include/asm-cris/io.h                            |    2 +-
 include/asm-generic/rmap.h                       |    2 +-
 include/asm-generic/rtc.h                        |    2 +-
 include/asm-mips/isadep.h                        |    2 +-
 include/asm-mips64/r10kcache.h                   |    2 +-
 include/asm-ppc/io.h                             |    2 +-
 include/asm-ppc/system.h                         |    2 +-
 include/asm-ppc64/system.h                       |    2 +-
 include/asm-v850/pci.h                           |    2 +-
 include/linux/agp_backend.h                      |    2 +-
 include/linux/apm_bios.h                         |    2 +-
 include/linux/isdnif.h                           |    2 +-
 include/linux/sdla_x25.h                         |    2 +-
 net/irda/iriap.c                                 |    2 +-
 net/irda/irlmp.c                                 |    4 ++--
 net/irda/irnet/irnet.h                           |    2 +-
 sound/core/hwdep.c                               |    2 +-
 sound/core/seq/seq_midi_emul.c                   |    4 ++--
 sound/oss/ac97_codec.c                           |    2 +-
 sound/oss/maestro.c                              |    2 +-
 114 files changed, 158 insertions(+), 158 deletions(-)

