Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422947AbWHZAgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422947AbWHZAgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422950AbWHZAgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:36:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62737 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422947AbWHZAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:36:40 -0400
Date: Sat, 26 Aug 2006 02:36:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.28
Message-ID: <20060826003639.GA4765@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.27:
- CVE-2006-2935: cdrom: fix bad cgc.buflen assignment
- CVE-2006-3745: Fix sctp privilege elevation
- CVE-2006-4093: powerpc: Clear HID0 attention enable on PPC970 at boot time
- CVE-2006-4145: Fix possible UDF deadlock and memory corruption


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

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
      Linux 2.6.16.28-rc3
      Linux 2.6.16.28

Al Boldi:
      ide-io: increase timeout value to allow for slave wakeup

Andi Kleen:
      BLOCK: Fix bounce limit address check

Bob Breuer:
      SPARC32: Fix iommu_flush_iotlb end address

Chuck Ebbert:
      ieee80211: TKIP requires CRC32

Danny Tholen:
      1394: fix for recently added firewire patch that breaks things on ppc

Dave Jones:
      [AGPGART] Fix Nforce3 suspend on amd64.

David S. Miller:
      SPARC64: Fix quad-float multiply emulation.

Jan Kara:
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

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

Sridhar Samudrala:
      Fix sctp privilege elevation (CVE-2006-3745)

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
 fs/udf/super.c                            |    2 
 fs/udf/truncate.c                         |   64 -
 include/asm-sparc64/sfp-machine.h         |    2 
 include/net/sctp/sctp.h                   |   13 
 include/net/sctp/sm.h                     |    3 
 kernel/power/Kconfig                      |   12 
 mm/Kconfig                                |    2 
 mm/pdflush.c                              |   15 
 net/ieee80211/Kconfig                     |    1 
 net/sctp/sm_make_chunk.c                  |   30 
 net/sctp/sm_statefuns.c                   |   20 
 net/sctp/socket.c                         |   10 
 sound/oss/Kconfig                         |    2 
 sound/pci/Kconfig                         |   14 
 sound/pci/fm801.c                         |    2 
 32 files changed, 1010 insertions(+), 545 deletions(-)

