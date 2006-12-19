Return-Path: <linux-kernel-owner+w=401wt.eu-S932745AbWLSKEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWLSKEI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWLSKEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:04:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1151 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932745AbWLSKEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:04:04 -0500
Date: Tue, 19 Dec 2006 11:04:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.37-rc1
Message-ID: <20061219100405.GG6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch location:
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.36:

Adrian Bunk (4):
      [ALSA] sound/core/: fix 3 off-by-one errors
      [ALSA] fix some memory leaks
      [ALSA] sound/pci/rme9652/hdspm.c: fix off-by-one errors
      Linux 2.6.16.37-rc1

Akinobu Mita (1):
      [WATCHDOG] sc1200wdt.c pnp unregister fix.

Alasdair G Kergon (1):
      dm snapshot: unify chunk_size

Alexey Kuznetsov (1):
      [IPV4]: severe locking bug in fib_semantics.c

Andrew Chew (1):
      sata_nv/amd74xx: Add MCP61 support

Andrew Morton (1):
      hvc_console suspend fix

Arjan van de Ven (1):
      x86-64: Mark rdtsc as sync only for netburst, not for core2

Arnaud Patard (1):
      r8169: fix infinite loop during hotplug

Brian King (1):
      [SCSI] DAC960: PCI id table fixup

Christophe Saout (2):
      Fix SUNRPC wakeup/execute race condition
      dm crypt: Fix data corruption with dm-crypt over RAID5

Daniel Kobras (1):
      dm: Fix deadlock under high i/o load in raid1 setup.

Dave Jones (5):
      [ALSA] ad1848 double free
      [ALSA] Fix use after free in opl3_seq and opl3_oss
      [ALSA] sound/isa/sb/sb_mixer.c double kfree
      [ALSA] fix usbmixer double kfree
      [WATCHDOG] sc1200wdt.c printk fix

David S. Miller (1):
      [IPV4] ip_fragment: Always compute hash with ipfrag_lock held.

Francois Romieu (2):
      r8169: RX fifo overflow recovery
      r8169: tweak the PCI data parity error recovery

Hans Verkuil (1):
      V4L: Fix broken TUNER_LG_NTSC_TAPE radio support

Herbert Xu (1):
      [CRYPTO] sha512: Fix sha384 block size

Jean Delvare (1):
      [SCSI] gdth: Fix && typos

Jeff Garzik (2):
      [libata] sata_nv: add PCI IDs
      ISDN: fix drivers, by handling errors thrown by ->readstat()

Jeff Mahoney (1):
      dm: add module ref counting

Joerg Ahrens (1):
      xirc2ps_cs: Cannot reset card in atomic context

Linus Torvalds (1):
      AGP: Allocate AGP pages with GFP_DMA32 by default

Mark McLoughlin (1):
      dm snapshot: fix metadata writing when suspending

Michael Krufky (1):
      DVB: lgdt330x: fix signal / lock status detection bug

Michal Miroslaw (1):
      dm: BUG/OOPS fix

Neil Brown (2):
      dm: mirror sector offset fix
      md: Fix md grow/size code to correctly find the maximum available space

Peer Chen (2):
      pci_ids.h: Add NVIDIA PCI ID
      IDE: Add the support of nvidia PATA controllers of MCP67 to amd74xx.c

Randy Dunlap (1):
      amd74xx.c: add some NVIDIA chipset IDs

Robin Holt (1):
      IA64: bte_unaligned_copy() transfers one extra cache line.

Stephen Hemminger (1):
      bridge-netfilter: don't overwrite memory outside of skb

Tejun Heo (1):
      scsi: clear garbage after CDBs on SG_IO

Trond Myklebust (1):
      NFS: nfs_lookup - don't hash dentry when optimising away the lookup

Zachary Amsden (1):
      softirq: remove BUG_ONs which can incorrectly trigger


 Makefile                               |    2 
 arch/ia64/sn/kernel/bte.c              |    9 +-
 arch/x86_64/kernel/setup.c             |    5 +
 block/scsi_ioctl.c                     |    3 
 crypto/sha512.c                        |    2 
 drivers/block/DAC960.c                 |    2 
 drivers/char/agp/generic.c             |    2 
 drivers/char/agp/intel-agp.c           |    2 
 drivers/char/hvc_console.c             |    1 
 drivers/char/watchdog/sc1200wdt.c      |   11 ++-
 drivers/ide/pci/amd74xx.c              |   13 +++
 drivers/isdn/i4l/isdn_common.c         |    9 +-
 drivers/md/dm-crypt.c                  |    6 +
 drivers/md/dm-exception-store.c        |   85 +++++++++++++++----------
 drivers/md/dm-mpath.c                  |    3 
 drivers/md/dm-raid1.c                  |   67 ++++++++++---------
 drivers/md/dm-snap.c                   |    6 -
 drivers/md/dm.c                        |    6 +
 drivers/md/md.c                        |    2 
 drivers/media/dvb/frontends/lgdt330x.c |    6 -
 drivers/media/video/tuner-simple.c     |    2 
 drivers/media/video/tuner-types.c      |   19 -----
 drivers/net/pcmcia/xirc2ps_cs.c        |   18 ++++-
 drivers/net/r8169.c                    |   36 +++++++---
 drivers/scsi/gdth.c                    |    4 -
 drivers/scsi/sata_nv.c                 |   10 ++
 drivers/scsi/scsi_lib.c                |    1 
 fs/nfs/dir.c                           |   14 +++-
 include/linux/netfilter_bridge.h       |   15 +++-
 include/linux/pci_ids.h                |    6 +
 kernel/softirq.c                       |    2 
 net/bridge/br_forward.c                |   10 ++
 net/ipv4/fib_semantics.c               |   12 +--
 net/ipv4/ip_fragment.c                 |   15 ++--
 net/sunrpc/sched.c                     |   10 +-
 sound/core/sound.c                     |    4 -
 sound/core/sound_oss.c                 |    2 
 sound/drivers/opl3/opl3_oss.c          |   12 ++-
 sound/drivers/opl3/opl3_seq.c          |   12 ++-
 sound/isa/ad1848/ad1848_lib.c          |    4 -
 sound/isa/es18xx.c                     |    1 
 sound/isa/sb/sb_mixer.c                |    4 -
 sound/pci/cs46xx/dsp_spos.c            |   10 ++
 sound/pci/rme9652/hdspm.c              |    4 -
 sound/usb/usbmixer.c                   |    1 
 45 files changed, 289 insertions(+), 181 deletions(-)
