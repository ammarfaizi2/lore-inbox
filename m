Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWHVXBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWHVXBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHVXBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:01:05 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63246 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751336AbWHVXBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:01:04 -0400
Date: Wed, 23 Aug 2006 01:01:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.28-rc2
Message-ID: <20060822230102.GC19896@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still several patches pending - they will go into 2.6.16.29.

2.6.16.28-rc1 was not announced.

Security fixes since 2.6.16.27:
- CVE-2006-4093: powerpc: Clear HID0 attention enable on PPC970 at boot time
- CVE-2006-2935: cdrom: fix bad cgc.buflen assignment


Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.27:

Adrian Bunk:
      fix the SND_FM801_TEA575X dependencies
      SOUND_SSCAPE shouldn't depend on OBSOLETE_OSS_DRIVER
      update the i386 defconfig
      Linux 2.6.16.28-rc1
      Linux 2.6.16.28-rc2

Al Boldi:
      ide-io: increase timeout value to allow for slave wakeup

Andi Kleen:
      BLOCK: Fix bounce limit address check

Bob Breuer:
      SPARC32: Fix iommu_flush_iotlb end address

Chuck Ebbert:
      ieee80211: TKIP requires CRC32

Dave Jones:
      [AGPGART] Fix Nforce3 suspend on amd64.

David S. Miller:
      SPARC64: Fix quad-float multiply emulation.

Jens Axboe:
      Fix missing ret assignment in __bio_map_user() error path
      fix debugfs inode leak
      cdrom: fix bad cgc.buflen assignment (CVE-2006-2935)

Michael S. Tsirkin:
      IB/mthca: restore missing PCI registers after reset

Olof Johansson:
      powerpc: Clear HID0 attention enable on PPC970 at boot time (CVE-2006-4093)

Pavel Machek:
      remove obsolete swsusp_encrypt
      pdflush: handle resume wakeups

Robert Hancock:
      Fix broken suspend/resume in ohci1394

Stefan Richter:
      ieee1394: sbp2: enable auto spin-up for Maxtor disks

Yasunori Goto:
      memory hotplug: solve config broken: undefined reference to `online_page'


 Makefile                                  |    4
 arch/i386/Kconfig                         |    3
 arch/i386/defconfig                       | 1261 ++++++++++++++--------
 arch/ia64/Kconfig                         |    3
 arch/powerpc/Kconfig                      |    3
 arch/powerpc/kernel/cpu_setup_power4.S    |    2
 arch/sparc/mm/iommu.c                     |    3
 arch/x86_64/Kconfig                       |    2
 block/ll_rw_blk.c                         |    2
 drivers/cdrom/cdrom.c                     |    2
 drivers/char/agp/amd64-agp.c              |    3
 drivers/ide/ide-io.c                      |    2
 drivers/ieee1394/ohci1394.c               |    3
 drivers/ieee1394/sbp2.c                   |    3
 drivers/infiniband/hw/mthca/mthca_reset.c |   59 +
 fs/bio.c                                  |    5
 fs/debugfs/inode.c                        |    3
 include/asm-sparc64/sfp-machine.h         |    2
 kernel/power/Kconfig                      |   12
 mm/Kconfig                                |    2
 mm/pdflush.c                              |   15
 net/ieee80211/Kconfig                     |    1
 sound/oss/Kconfig                         |    2
 sound/pci/Kconfig                         |   14
 sound/pci/fm801.c                         |    2
 25 files changed, 947 insertions(+), 466 deletions(-)

