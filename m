Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032092AbWLGMCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032092AbWLGMCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032091AbWLGMCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:02:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1436 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032092AbWLGMCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:02:18 -0500
Date: Thu, 7 Dec 2006 13:02:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.35
Message-ID: <20061207120224.GE8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.34:
- CVE-2006-5751: bridge: fix possible overflow in get_fdb_entries


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.34:

Adrian Bunk (4):
      drivers/usb/input/ati_remote.c: fix cut'n'paste error
      remove garbage that sneaked into the ext3 fix
      Linux 2.6.16.35-rc1
      Linux 2.6.16.35

Al Viro (5):
      add forgotten ->b_data in memcpy() call in ext3/resize.c (oopsable)
      [EBTABLES]: Fix wraparounds in ebt_entries verification.
      [EBTABLES]: Verify that ebt_entries have zero ->distinguisher.
      [EBTABLES]: Deal with the worst-case behaviour in loop checks.
      [EBTABLES]: Prevent wraparounds in checks for entry components' sizes.

Alexey Dobriyan (1):
      proper flags type of spin_lock_irqsave()

Chris Wright (1):
      bridge: fix possible overflow in get_fdb_entries (CVE-2006-5751)

Dave Kleikamp (1):
      JFS: pageno needs to be long

Fernando J. Pereda (1):
      alpha: Fix ALPHA_EV56 dependencies typo

Herbert Xu (1):
      SCTP: Always linearise packet on input

Jean Delvare (1):
      Fix a masking bug in the 6pack driver.

Jens Axboe (3):
      block: Fix bad data direction in SG_IO
      cpqarray: fix iostat
      cciss: fix iostat

Jeremy Higdon (1):
      sgiioc4: Disable module unload

Jiri Slaby (1):
      Char: isicom, fix close bug

Josh Triplett (1):
      freevxfs: Add missing lock_kernel() to vxfs_readdir

Kim Nordlund (1):
      [PKT_SCHED] act_gact: division by zero

Kyle McMartin (1):
      Fix incorrent type of flags in <asm/semaphore.h>

Michael De Backer (1):
      alim15x3.c: M5229 (rev c8) support for DMA cd-writer

Nathan Lynch (1):
      nvidiafb: fix unreachable code in nv10GetConfig

Olaf Kirch (1):
      [UDP]: Make udp_encap_rcv use pskb_may_pull

Oliver Neukum (1):
      USB: failure in usblp's error path

Patrick McHardy (1):
      [NET_SCHED]: policer: restore compatibility with old iproute binaries

Pierre Ossman (1):
      MMC: Always use a sector size of 512 bytes

Roberto Castagnola (1):
      Input: logips2pp - fix button mapping for MX300

Trond Myklebust (1):
      fcntl(F_SETSIG) fix

Vasily Tarasov (1):
      block layer: elv_iosched_show should get elv_list_lock

Wink Saville (1):
      Fix divide by zero error for nvidia 7600 pci-express card

YOSHIFUJI Hideaki (1):
      [IPV6]: Fix address/interface handling in UDP and DCCP, according to the scoping architecture.

Zbigniew Luszpinski (1):
      Input: psmouse - add detection of Logitech TrackMan Wheel trackball

Zhou Yingchao (1):
      Remove redundant up() in stop_machine()


 Makefile                           |    2 -
 arch/alpha/Kconfig                 |    2 -
 arch/ia64/kernel/mca.c             |    2 -
 arch/ia64/sn/pci/pcibr/pcibr_ate.c |    2 -
 arch/ia64/sn/pci/pcibr/pcibr_dma.c |    2 -
 arch/parisc/kernel/firmware.c      |    7 ++-
 arch/v850/kernel/memcons.c         |    2 -
 arch/v850/kernel/rte_cb_leds.c     |    2 -
 arch/v850/kernel/rte_mb_a_pci.c    |   12 +++---
 block/elevator.c                   |    4 +-
 block/scsi_ioctl.c                 |    2 -
 drivers/block/cciss.c              |    6 +++
 drivers/block/cpqarray.c           |   13 +++++-
 drivers/char/ds1286.c              |   15 ++++----
 drivers/char/isicom.c              |    3 +
 drivers/i2c/busses/i2c-ite.c       |    2 -
 drivers/ide/pci/alim15x3.c         |    2 -
 drivers/ide/pci/sgiioc4.c          |    7 ---
 drivers/input/mouse/logips2pp.c    |    9 +++-
 drivers/mmc/mmc_block.c            |   49 ++------------------------
 drivers/net/hamradio/6pack.c       |    2 -
 drivers/usb/class/usblp.c          |    1 
 drivers/usb/input/ati_remote.c     |    2 -
 drivers/video/nvidia/nv_hw.c       |   12 ++++--
 drivers/video/nvidia/nv_setup.c    |   20 +++++++++-
 drivers/video/nvidia/nv_type.h     |    1 
 drivers/video/nvidia/nvidia.c      |   24 ++++++------
 fs/ext3/resize.c                   |    2 -
 fs/freevxfs/vxfs_lookup.c          |    2 +
 fs/jfs/jfs_imap.c                  |    4 +-
 fs/locks.c                         |    6 ++-
 include/asm-parisc/semaphore.h     |    6 ++-
 kernel/stop_machine.c              |    1 
 net/bridge/br_ioctl.c              |    9 ++--
 net/bridge/netfilter/ebtables.c    |   54 +++++++++++++++++------------
 net/dccp/ipv6.c                    |    2 -
 net/ipv4/udp.c                     |   19 +++++++---
 net/ipv6/udp.c                     |    7 +--
 net/sched/act_gact.c               |    4 +-
 net/sched/act_police.c             |   26 +++++++++++--
 net/sctp/input.c                   |    3 +
 sound/oss/swarm_cs4297a.c          |    2 -
 42 files changed, 199 insertions(+), 155 deletions(-)
