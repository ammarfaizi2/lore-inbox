Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVLOAvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVLOAvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVLOAvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:51:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:48051 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965095AbVLOAvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:51:36 -0500
Date: Wed, 14 Dec 2005 16:50:41 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.14.4
Message-ID: <20051215005041.GB4148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.14.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.14.3 and 2.6.14.4, as it is small enough to do so.

The updated 2.6.14.y git tree can be found at:
 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.14.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                    |    2 -
 drivers/acpi/scan.c                         |    2 -
 drivers/block/cciss.c                       |    7 +++---
 drivers/char/agp/sworks-agp.c               |   18 ++++++++++++++-
 drivers/char/i8k.c                          |    6 +++--
 drivers/char/vt_ioctl.c                     |    6 +++++
 drivers/ide/ide-floppy.c                    |    6 +----
 drivers/infiniband/core/mad.c               |    4 +--
 drivers/media/dvb/ttpci/Kconfig             |    1 
 drivers/media/video/cx88/cx88-cards.c       |    2 +
 drivers/media/video/saa7134/saa7134-cards.c |    2 -
 drivers/message/i2o/pci.c                   |    2 -
 drivers/net/bonding/bond_main.c             |   32 +++++++++-------------------
 drivers/net/bonding/bonding.h               |    7 +-----
 drivers/pcmcia/i82365.c                     |    1 
 drivers/scsi/dpt_i2o.c                      |    9 ++++---
 drivers/scsi/libata-core.c                  |    2 -
 drivers/scsi/libata-scsi.c                  |    9 +++++++
 drivers/usb/image/microtek.c                |   31 +++++++++++++++++++++------
 drivers/usb/image/microtek.h                |    2 -
 fs/xattr.c                                  |    2 -
 include/linux/cciss_ioctl.h                 |    2 -
 kernel/audit.c                              |    4 ++-
 kernel/ptrace.c                             |    3 +-
 mm/truncate.c                               |    6 ++---
 net/bridge/br_if.c                          |    1 
 net/ipv4/fib_frontend.c                     |    8 +++++--
 sound/pci/nm256/nm256.c                     |   23 +++++++++++++++++---
 28 files changed, 131 insertions(+), 69 deletions(-)

Summary of changes from v2.6.14.3 to v2.6.14.4
==============================================

Adrian Bunk:
      drivers/scsi/dpt_i2o.c: fix a user-after-free
      drivers/message/i2o/pci.c: fix a use-after-free
      drivers/infiniband/core/mad.c: fix a use-after-free

Carlos Silva:
      DVB: BUDGET CI card depends on STV0297 demodulator

Daniel Drake:
      setkeys needs root
      Fix listxattr() for generic security attributes

Dave Jones:
      AGPGART: Fix serverworks TLB flush.

David Gibson:
      Fix crash when ptrace poking hugepage areas

Dmitry Torokhov:
      I8K: fix /proc reporting of blank service tags

Greg Kroah-Hartman:
      Linux 2.6.14.4

Igor Popik:
      i82365: release all resources if no devices are found

Jay Vosburgh:
      bonding: fix feature consolidation

Jeff Garzik:
      libata: locking rewrite (== fix)

Jens Axboe:
      cciss: bug fix for BIG_PASS_THRU

John W. Linville:
      ALSA: nm256: reset workaround for Latitude CSx

Linux Kernel Mailing List:
      cciss: bug fix for hpacucli

Michael Krufky:
      V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner

Olaf Rempel:
      BRIDGE: recompute features when adding a new device

Oleg Drokin:
      32bit integer overflow in invalidate_inode_pages2()

Oliver Neukum:
      USB: Adapt microtek driver to new scsi features

Ondrej Zary:
      ide-floppy: software eject not working with LS-120 drive

Pierre Ossman:
      Add try_to_freeze to kauditd

Ricardo Cerqueira:
      V4L/DVB (3135) Fix tuner init for Pinnacle PCTV Stereo

Thomas Graf:
      NETLINK: Fix processing of fib_lookup netlink messages

Thomas Renninger:
      ACPI: fix HP nx8220 boot hang regression

