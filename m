Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWIMSvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWIMSvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWIMSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:51:33 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6916 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751109AbWIMSvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:51:31 -0400
Date: Wed, 13 Sep 2006 20:51:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.29
Message-ID: <20060913185130.GA5031@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.28:
- CVE-2006-3468: fix NFS over ext3 DoS
- fix NFS over ext2 DoS
- ipv6: fix oops triggerable by any user


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.28:

Adrian Bunk:
      Linux 2.6.16.29-rc1
      Linux 2.6.16.29-rc2
      Linux 2.6.16.29

Alan Cox:
      Missing PCI id update for VIA IDE
      pci_ids.h: add some VIA IDE identifiers

Alexey Dobriyan:
      eicon: fix define conflict with ptrace

Chen-Li Tien:
      [PKTGEN]: Fix oops when used with balance-tlb bonding

Christian Borntraeger:
      fix misoptimization in futex unqueue_me

David S. Miller:
      [PKTGEN]: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.

Dean Nelson:
      ia64 SGI-SN2: fix silent data corruption caused by XPC

Eric Sandeen:
      Have ext3 reject file handles with bad inode numbers early

Hannes Reinecke:
      aic79xx: use BIOS settings

Herbert Xu:
      ETHTOOL: Fix UFO typo

Kirill Korotaev:
      fix struct file leakage

Mark Huang:
      ulog: fix panic on SMP kernels

maximilian attems:
      [SERIAL] icom: select FW_LOADER

Neil Brown:
      Fix a potential NULL dereference in md/raid1
      ext3: avoid triggering ext3_error on bad NFS file handle
      Have ext2 reject file handles with bad inode numbers early.

Neil Horman:
      SCTP: Fix persistent slowdown in sctp when a gap ack consumes rx buffer.

Patrick McHardy:
      ip_tables: fix table locking in ipt_do_table

Paul Fulghum:
      tty serialize flush_to_ldisc

Remy Bruno:
      ALSA: RME HDSP - fixed proc interface (missing {})

Sonny Rao:
      idr: fix race in idr code

Sridhar Samudrala:
      Fix sctp_primitive_ABORT() call in sctp_close()

Takashi Iwai:
      ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port
      ALSA: Fix a deadlock in snd-rtctimer
      ALSA: Fix missing array terminators in AD1988 codec support
      ALSA: Fix model for HP dc7600
      ALSA: Fix workaround for AD1988A rev2 codec
      ALSA: hda-intel - Fix race in remove

Tsutomu Fujii:
      SCTP: Send only 1 window update SACK per message.

Vlad Yasevich:
      SCTP: Reject sctp packets with broadcast addresses.
      SCTP: Limit association max_retrans setting in setsockopt.
      SCTP: Reset rtt_in_progress for the chunk when processing its sack.

Willy Tarreau:
      ethtool: fix oops in ethtool_set_pauseparam()

YOSHIFUJI Hideaki:
      [IPV6]: Fix kernel OOPs when setting sticky socket options.


 Makefile                               |    2 -
 arch/ia64/sn/kernel/xpc_channel.c      |    4 +-
 arch/ia64/sn/kernel/xpc_main.c         |   28 +++++++++--------
 arch/ia64/sn/kernel/xpc_partition.c    |   22 ++++---------
 drivers/char/tty_io.c                  |   14 +++++---
 drivers/ide/pci/via82cxxx.c            |    3 +
 drivers/isdn/hardware/eicon/divasync.h |    1 
 drivers/md/raid1.c                     |    4 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c     |   35 +++++++++++++++++----
 drivers/serial/Kconfig                 |    1 
 fs/ext2/super.c                        |   41 +++++++++++++++++++++++++
 fs/ext3/inode.c                        |   15 ++++-----
 fs/ext3/namei.c                        |   15 +++++++--
 fs/ext3/super.c                        |   40 ++++++++++++++++++++++++
 fs/namei.c                             |    8 ++++
 include/asm-ia64/sn/xp.h               |   22 ++++++++++---
 include/asm-ia64/sn/xpc.h              |    3 +
 include/linux/ext3_fs.h                |    9 +++++
 include/linux/pci_ids.h                |    5 ++-
 include/net/sctp/structs.h             |    3 +
 kernel/futex.c                         |    1 
 lib/idr.c                              |   16 +++++++--
 net/bridge/netfilter/ebt_ulog.c        |    3 +
 net/core/ethtool.c                     |    5 +--
 net/core/pktgen.c                      |    4 ++
 net/ipv4/netfilter/arp_tables.c        |    3 +
 net/ipv4/netfilter/ip_tables.c         |    3 +
 net/ipv4/netfilter/ipt_ULOG.c          |    5 +++
 net/ipv6/exthdrs.c                     |   29 +++++++++--------
 net/netfilter/nfnetlink_log.c          |    3 +
 net/sctp/input.c                       |    3 +
 net/sctp/ipv6.c                        |    6 ++-
 net/sctp/outqueue.c                    |    1 
 net/sctp/protocol.c                    |    8 ++++
 net/sctp/sm_statefuns.c                |   10 +++++-
 net/sctp/socket.c                      |   38 ++++++++++++++++++++---
 net/sctp/ulpevent.c                    |   30 +++++++++++++++++-
 sound/core/timer.c                     |    5 +--
 sound/pci/au88x0/au88x0_mpu401.c       |    2 -
 sound/pci/hda/hda_intel.c              |    4 +-
 sound/pci/hda/patch_analog.c           |   19 +++++++----
 sound/pci/hda/patch_realtek.c          |    2 -
 sound/pci/rme9652/hdsp.c               |    3 +
 43 files changed, 369 insertions(+), 109 deletions(-)

