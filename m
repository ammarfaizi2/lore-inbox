Return-Path: <linux-kernel-owner+w=401wt.eu-S932174AbXAIQD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbXAIQD6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbXAIQD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:03:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2043 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932174AbXAIQD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:03:57 -0500
Date: Tue, 9 Jan 2007 17:04:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.38-rc1
Message-ID: <20070109160401.GL25007@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.37:
- CVE-2006-4814: Fix incorrect user space access locking in mincore()
- CVE-2006-5173: i386: save/restore eflags in context switch
- CVE-2006-5749: Call init_timer() for ISDN PPP CCP reset state timer
- CVE-2006-5755: x86_64: Don't leak NT bit into next task
- CVE-2006-5757/CVE-2006-6060: grow_buffers() infinite loop fix
- CVE-2006-5823: corrupted cramfs filesystems cause kernel oops
- CVE-2006-6053: handle ext3 directory corruption better
- CVE-2006-6054: ext2: skip pages past number of blocks in ext2_find_entry
- CVE-2006-6056: hfs_fill_super returns success even if no root inode
- CVE-2006-6106: Bluetooth: Add packet size checks for CAPI messages


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git


Changes since 2.6.16.37:

Adrian Bunk (4):
      fix the UML compilation
      USB_RTL8150 must select MII to avoid link errors.
      x86_64: re-add a newline to RESTORE_CONTEXT
      Linux 2.6.16.38-rc1

Andi Kleen (1):
      x86_64: Don't leak NT bit into next task (CVE-2006-5755)

Andrew Morton (2):
      grow_buffers() infinite loop fix (CVE-2006-5757/CVE-2006-6060)
      ibmtr section fixes

Andrey Mirkin (1):
      skip data conversion in compat_sys_mount when data_page is NULL

Arnaud Patard (1):
      ALSA: emu10k1: Fix outl() in snd_emu10k1_resume_regs()

Badari Pulavarty (1):
      Fix for shmem_truncate_range() BUG_ON()

Chuck Ebbert (2):
      x86_64: fix ia32 syscall count
      ebtables: check struct type before computing gap

Chuck Short (1):
      drm: allow detection of new VIA chipsets

Clemens Ladisch (1):
      ALSA: snd_rtctimer: handle RTC interrupts with a tasklet

Dave Airlie (1):
      drm: Add the P4VM800PRO PCI ID.

David Brownell (1):
      SPI/MTD: mtd_dataflash oops prevention

David L Stevens (1):
      [IPV4/IPV6]: Fix inet{,6} device initialization order.

David S. Miller (1):
      [SOUND] Sparc CS4231: Use 64 for period_bytes_min

Dirk Eibach (1):
      i2c: fix broken ds1337 initialization

Eric Sandeen (3):
      hfs_fill_super returns success even if no root inode (CVE-2006-6056)
      ext2: skip pages past number of blocks in ext2_find_entry (CVE-2006-6054)
      handle ext3 directory corruption better (CVE-2006-6053)

Fabrice Knevez (1):
      [SUNKBD]: Fix sunkbd_enable(sunkbd, 0); obvious.

Georg Chini (1):
      [SOUND] Sparc CS4231: Fix IRQ return value and initialization.

Jason Gaston (2):
      PCI: irq: irq and pci_ids patch for Intel ICH9
      i2c-i801: SMBus patch for Intel ICH9

Jean Delvare (1):
      V4L: cx88: Fix leadtek_eeprom tagging

John Heffner (1):
      TCP: Fix and simplify microsecond rtt sampling

Linus Torvalds (2):
      Fix incorrect user space access locking in mincore() (CVE-2006-4814)
      i386: save/restore eflags in context switch (CVE-2006-5173)

Marcel Holtmann (2):
      Call init_timer() for ISDN PPP CCP reset state timer (CVE-2006-5749)
      Bluetooth: Add packet size checks for CAPI messages (CVE-2006-6106)

Maxime Bizon (1):
      i2c-mv64xxx: Fix random oops at boot

Mikael Pettersson (1):
      USB: Fix alignment of buffer passed down to ->hub_control()

Miklos Szeredi (1):
      fuse: fix hang on SMP

Paolo 'Blaisorblade' Giarrusso (1):
      uml: fix processor selection

Patrick McHardy (1):
      NET_SCHED: Fix fallout from dev->qdisc RCU change

Peter Zijlstra (1):
      rtc: lockdep fix/workaround

Phillip Lougher (1):
      corrupted cramfs filesystems cause kernel oops (CVE-2006-5823)

Robert Olsson (1):
      [PKTGEN]: Fix module load/unload races.

Rudolf Marek (1):
      i2c-viapro: Add support for the VT8237A and VT8251

Takashi Iwai (1):
      ALSA: Fix initiailization of user-space controls

Willy Tarreau (1):
      rio: typo in bitwise AND expression.


 Documentation/i2c/busses/i2c-viapro   |    7 
 Makefile                              |    2 
 arch/i386/Kconfig.cpu                 |    3 
 arch/i386/kernel/entry.S              |    2 
 arch/i386/pci/irq.c                   |    6 
 arch/um/os-Linux/process.c            |    5 
 arch/um/os-Linux/skas/process.c       |    1 
 arch/um/sys-i386/unmap.c              |   11 -
 arch/um/sys-x86_64/unmap.c            |   11 -
 arch/x86_64/kernel/entry.S            |    4 
 arch/x86_64/kernel/setup64.c          |    4 
 drivers/char/drm/drm_pciids.h         |    4 
 drivers/char/rio/rio_linux.c          |    2 
 drivers/char/rtc.c                    |    5 
 drivers/i2c/busses/Kconfig            |   19 +-
 drivers/i2c/busses/i2c-i801.c         |    2 
 drivers/i2c/busses/i2c-mv64xxx.c      |    4 
 drivers/i2c/busses/i2c-viapro.c       |    8 +
 drivers/i2c/chips/ds1337.c            |    8 -
 drivers/input/keyboard/sunkbd.c       |    2 
 drivers/isdn/i4l/isdn_ppp.c           |    1 
 drivers/media/video/cx88/cx88-cards.c |    2 
 drivers/mtd/devices/mtd_dataflash.c   |    2 
 drivers/net/tokenring/ibmtr.c         |    4 
 drivers/usb/core/hcd.c                |    3 
 drivers/usb/net/Kconfig               |    1 
 fs/buffer.c                           |   21 ++
 fs/compat.c                           |    2 
 fs/cramfs/inode.c                     |    2 
 fs/ext2/dir.c                         |    8 +
 fs/ext3/dir.c                         |    3 
 fs/ext3/namei.c                       |    9 +
 fs/fuse/dir.c                         |   29 ++--
 fs/fuse/file.c                        |   12 +
 fs/fuse/inode.c                       |    4 
 fs/hfs/super.c                        |    2 
 include/asm-i386/system.h             |    8 -
 include/asm-x86_64/ia32_unistd.h      |    2 
 include/asm-x86_64/system.h           |   22 ++-
 include/linux/pci_ids.h               |    7 
 mm/mincore.c                          |  183 +++++++++++---------------
 mm/shmem.c                            |    7 
 net/bluetooth/cmtp/capi.c             |   39 ++++-
 net/bridge/netfilter/ebtables.c       |    3 
 net/core/dev.c                        |   14 +
 net/core/pktgen.c                     |   20 ++
 net/ipv4/devinet.c                    |    5 
 net/ipv4/tcp_input.c                  |   16 +-
 net/ipv6/addrconf.c                   |    8 -
 net/sched/cls_api.c                   |    4 
 net/sched/sch_api.c                   |   16 +-
 net/sched/sch_generic.c               |   66 ++-------
 sound/core/control.c                  |    1 
 sound/core/rtctimer.c                 |   17 +-
 sound/pci/emu10k1/emu10k1_main.c      |    4 
 sound/sparc/cs4231.c                  |   26 +--
 56 files changed, 413 insertions(+), 270 deletions(-)

