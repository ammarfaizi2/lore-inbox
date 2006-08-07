Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWHGFLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWHGFLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWHGFLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:11:53 -0400
Received: from ns1.suse.de ([195.135.220.2]:14758 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751049AbWHGFLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:11:53 -0400
Date: Sun, 6 Aug 2006 22:11:18 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.8
Message-ID: <20060807051118.GA29831@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.8 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.17.7 and 2.6.17.8, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 MAINTAINERS                                   |    8 +
 Makefile                                      |    2 
 arch/i386/pci/mmconfig.c                      |    9 +-
 arch/x86_64/pci/mmconfig.c                    |   13 ++-
 drivers/char/tty_io.c                         |   14 ++-
 drivers/i2c/busses/scx200_acb.c               |   20 ++--
 drivers/i2c/i2c-core.c                        |    4 
 drivers/ieee1394/sbp2.c                       |    3 
 drivers/media/dvb/ttpci/budget-av.c           |   10 +-
 drivers/net/e1000/e1000_hw.c                  |    1 
 drivers/net/e1000/e1000_hw.h                  |    1 
 drivers/net/sky2.c                            |    5 -
 drivers/usb/host/uhci-q.c                     |    6 -
 fs/buffer.c                                   |    7 +
 fs/ext3/inode.c                               |   19 ++--
 fs/ext3/namei.c                               |   15 +++
 fs/proc/base.c                                |   33 +++++++-
 include/asm-s390/futex.h                      |    5 -
 include/asm-sparc64/sfp-machine.h             |    2 
 include/linux/ext3_fs.h                       |    9 ++
 include/linux/skbuff.h                        |   24 ++---
 kernel/sched.c                                |   25 +++---
 net/8021q/vlan.c                              |    8 -
 net/core/skbuff.c                             |  106 ++++++++++++++++++--------
 net/ipv4/netfilter/ip_conntrack_helper_h323.c |    2 
 net/sunrpc/cache.c                            |    6 +
 sound/core/oss/pcm_oss.c                      |    2 
 27 files changed, 246 insertions(+), 113 deletions(-)

Summary of changes from v2.6.17.7 to v2.6.17.8
==============================================

Alan Stern:
      UHCI: Fix handling of short last packet

Andrew de Quincey:
      Fix budget-av compile failure

Andrew Morton:
      invalidate_bdev() speedup
      cond_resched() fix

Auke Kok:
      e1000: add forgotten PCI ID for supported device

Badari Pulavarty:
      ext3 -nobh option causes oops

Chuck Ebbert:
      PCI: fix issues with extended conf space when MMCONFIG disabled because of e820

David Miller:
      Sparc64 quad-float emulation fix

Greg Kroah-Hartman:
      Linux 2.6.17.8

Herbert Xu:
      Update frag_list in pskb_trim

Jean Delvare:
      scx200_acb: Fix the block transactions

Marcel Holtmann:
      Don't allow chmod() on the /proc/<pid>/ files

Mark M. Hoffman:
      i2c: Fix 'ignore' module parameter handling in i2c-core

Martin Schwidefsky:
      S390: fix futex_atomic_cmpxchg_inatomic

Neil Brown:
      Fix race related problem when adding items to and svcrpc auth cache.
      ext3: avoid triggering ext3_error on bad NFS file handle

Patrick McHardy:
      H.323 helper: fix possible NULL-ptr dereference

Paul Fulghum:
      tty serialize flush_to_ldisc

Stefan Richter:
      ieee1394: sbp2: enable auto spin-up for Maxtor disks

Stefan Rompf:
      VLAN state handling fix

Stephen Hemminger:
      sky2: NAPI bug

Steven Rostedt:
      Add stable branch to maintainers file

Takashi Iwai:
      ALSA: Don't reject O_RDWR at opening PCM OSS

Thomas Andrews:
      scx200_acb: Fix the state machine

