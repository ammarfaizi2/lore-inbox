Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWGYDpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWGYDpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWGYDpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:45:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:59532 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932406AbWGYDpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:45:11 -0400
Date: Mon, 24 Jul 2006 20:42:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.17.7
Message-ID: <20060725034247.GA5837@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.7 kernel.

I'll also be replying to this message with a copy of the patch between
2.6.17.6 and 2.6.17.7, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Makefile                                   |    2 
 arch/i386/Kconfig                          |    3 
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |    5 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    2 
 arch/ia64/Kconfig                          |    3 
 arch/powerpc/Kconfig                       |    3 
 arch/x86_64/Kconfig                        |    2 
 arch/x86_64/kernel/setup.c                 |    2 
 block/ll_rw_blk.c                          |    2 
 drivers/acpi/namespace/nsxfeval.c          |    5 
 drivers/cdrom/cdrom.c                      |    2 
 drivers/infiniband/hw/mthca/mthca_reset.c  |   59 +++++++
 drivers/media/dvb/bt8xx/dvb-bt8xx.c        |   10 +
 drivers/media/dvb/bt8xx/dvb-bt8xx.h        |    1 
 drivers/media/dvb/dvb-core/dvb_frontend.c  |   14 +
 drivers/media/dvb/frontends/dvb-pll.c      |   10 -
 drivers/media/dvb/ttpci/budget-av.c        |   20 +-
 drivers/media/dvb/ttpci/budget.c           |    6 
 drivers/media/video/Kconfig                |    6 
 drivers/media/video/stradis.c              |    1 
 drivers/net/via-velocity.c                 |    6 
 drivers/pnp/resource.c                     |    3 
 drivers/serial/8250.c                      |   13 +
 drivers/usb/serial/ftdi_sio.c              |   84 ++++++++--
 fs/file.c                                  |    4 
 fs/namei.c                                 |    8 -
 fs/splice.c                                |  230 ++++++++++++++++-------------
 fs/xfs/xfs_dir2_node.c                     |    2 
 include/sound/initval.h                    |    3 
 mm/Kconfig                                 |    2 
 mm/filemap.c                               |   27 ++-
 mm/filemap.h                               |    4 
 mm/pdflush.c                               |   15 -
 net/core/dev.c                             |    1 
 net/core/ethtool.c                         |    2 
 net/core/skbuff.c                          |    2 
 net/decnet/dn_rules.c                      |    3 
 net/ieee80211/Kconfig                      |    1 
 net/ipv4/fib_rules.c                       |    4 
 net/sched/act_api.c                        |   18 +-
 sound/core/timer.c                         |    5 
 sound/isa/cs423x/Makefile                  |    1 
 sound/pci/Kconfig                          |   14 +
 sound/pci/au88x0/au88x0_mpu401.c           |    2 
 sound/pci/fm801.c                          |    2 
 sound/pci/hda/hda_intel.c                  |    4 
 sound/pci/hda/patch_analog.c               |   19 +-
 sound/pci/hda/patch_realtek.c              |    2 
 sound/pci/hda/patch_sigmatel.c             |    8 -
 sound/pci/rme9652/hdsp.c                   |    5 
 50 files changed, 434 insertions(+), 218 deletions(-)

Summary of changes from v2.6.17.6 to v2.6.17.7
==============================================

Andi Kleen:
      BLOCK: Fix bounce limit address check

Andrew de Quincey:
      v4l/dvb: Fix budget-av frontend detection
      v4l/dvb: Fix CI on old KNC1 DVBC cards
      v4l/dvb: Fix CI interface on PRO KNC1 cards
      v4l/dvb: Backport fix to artec USB DVB devices
      v4l/dvb: Backport the DISEQC regression fix to 2.6.17.x
      v4l/dvb: stradis: dont export MODULE_DEVICE_TABLE

Andrew Morton:
      pnp: suppress request_irq() warning
      generic_file_buffered_write(): handle zero-length iovec segments
      serial 8250: sysrq deadlock fix

Bob Moore:
      Reduce ACPI verbosity on null handle condition

Chuck Ebbert:
      ieee80211: TKIP requires CRC32

Dave Jones:
      Make powernow-k7 work on SMP kernels.

Francois Romieu:
      via-velocity: the link is not correctly detected when the device starts

Greg Kroah-Hartman:
      Linux 2.6.17.7

Herbert Xu:
      Add missing UFO initialisations

Ian Abbott:
      USB serial ftdi_sio: Prevent userspace DoS (CVE-2006-2936)

Jens Axboe:
      cdrom: fix bad cgc.buflen assignment
      splice: fix problems with sys_tee()

Kirill Korotaev:
      fix fdset leakage
      struct file leakage

Mandy Kirkconnell:
      XFS: corruption fix

Michael Krufky:
      v4l/dvb: Kconfig: fix description and dependencies for saa7115 module
      dvb-bt8xx: fix frontend detection for DViCO FusionHDTV DVB-T Lite rev 1.2

Michael S. Tsirkin:
      IB/mthca: restore missing PCI registers after reset

Oliver Endriss:
      v4l/dvb: Backport the budget driver DISEQC instability fix

Patrick McHardy:
      Fix IPv4/DECnet routing rule dumping

Pavel Machek:
      pdflush: handle resume wakeups

Piotr Kaczuba:
      x86_64: Fix modular pc speaker

Randy Dunlap:
      Fix powernow-k8 SMP kernel on UP hardware bug.

Remy Bruno:
      ALSA: RME HDSP - fixed proc interface (missing {})

Takashi Iwai:
      ALSA: au88x0 - Fix 64bit address of MPU401 MMIO port
      ALSA: Fix a deadlock in snd-rtctimer
      ALSA: Fix missing array terminators in AD1988 codec support
      ALSA: Fix model for HP dc7600
      ALSA: Fix mute switch on VAIO laptops with STAC7661
      ALSA: fix the SND_FM801_TEA575X dependencies
      ALSA: Fix undefined (missing) references in ISA MIRO sound driver
      ALSA: Fix workaround for AD1988A rev2 codec
      ALSA: hda-intel - Fix race in remove
      Suppress irq handler mismatch messages in ALSA ISA drivers

Thomas Graf:
      PKT_SCHED: Fix illegal memory dereferences when dumping actions
      PKT_SCHED: Return ENOENT if action module is unavailable
      PKT_SCHED: Fix error handling while dumping actions

Vladimir V. Saveliev:
      generic_file_buffered_write(): deadlock on vectored write

Willy Tarreau:
      ethtool: oops in ethtool_set_pauseparam()

Yasunori Goto:
      memory hotplug: solve config broken: undefined reference to `online_page'

