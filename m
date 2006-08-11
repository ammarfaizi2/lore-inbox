Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWHKVej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHKVej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHKVej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:34:39 -0400
Received: from mail.suse.de ([195.135.220.2]:54927 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932338AbWHKVei convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:34:38 -0400
Date: Fri, 11 Aug 2006 14:34:31 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.18-rc4-gkh1 released
Message-ID: <20060811213431.GA14484@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've released a patch that contains the contents of my git staging tree
while Linus is on vacation, which can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/linux-2.6.git/

There currently are 64 patches in it, the shortlog and diffstat are
below.

The patch can be found at:
	kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/releases/patch-2.6.18-rc4-gkh1.gz
and will apply cleanly to the 2.6.18-rc4 kernel tree.

thanks,

greg k-h

------

 Documentation/kobject.txt                   |    2 
 MAINTAINERS                                 |    8 ++
 Makefile                                    |   24 ++++-
 arch/arm/common/rtctime.c                   |    1 
 arch/arm/mach-ixp4xx/common-pci.c           |    2 
 arch/arm/mach-ixp4xx/gtwx5715-setup.c       |    7 --
 drivers/ide/pci/generic.c                   |   30 +++++++
 drivers/media/dvb/bt8xx/dst.c               |   58 ++++++-------
 drivers/media/dvb/dvb-core/Makefile         |    6 +
 drivers/media/radio/Kconfig                 |   12 +++
 drivers/media/radio/Makefile                |    1 
 drivers/media/{video => radio}/dsbr100.c    |    0 
 drivers/media/video/Kconfig                 |   12 ---
 drivers/media/video/Makefile                |    2 
 drivers/media/video/compat_ioctl32.c        |   32 ++++++-
 drivers/media/video/cx25840/cx25840-core.c  |    4 -
 drivers/media/video/cx88/cx88-video.c       |    4 -
 drivers/media/video/msp3400-kthreads.c      |    4 -
 drivers/media/video/pwc/Kconfig             |    2 
 drivers/media/video/pwc/pwc-if.c            |    1 
 drivers/media/video/saa7134/saa7134-video.c |    2 
 drivers/media/video/tuner-types.c           |   14 ++-
 drivers/media/video/v4l1-compat.c           |    4 +
 drivers/media/video/v4l2-common.c           |    6 +
 drivers/media/video/videodev.c              |    2 
 drivers/media/video/vivi.c                  |    4 -
 drivers/mmc/mmc_queue.c                     |    3 -
 drivers/mmc/wbsd.c                          |    9 +-
 drivers/net/myri10ge/myri10ge.c             |    2 
 drivers/net/tg3.c                           |   51 ++++++------
 drivers/net/tg3.h                           |    8 +-
 drivers/pci/hotplug/Kconfig                 |    7 --
 drivers/pci/hotplug/pciehp.h                |    5 +
 drivers/pci/hotplug/pciehp_hpc.c            |    4 -
 drivers/s390/char/tape_class.c              |    2 
 drivers/s390/cio/device_fsm.c               |    1 
 drivers/s390/cio/device_ops.c               |    3 +
 drivers/scsi/arm/Kconfig                    |    3 +
 drivers/scsi/arm/scsi.h                     |    2 
 drivers/scsi/ata_piix.c                     |    5 +
 drivers/scsi/libata-core.c                  |   34 ++------
 drivers/scsi/libata-scsi.c                  |   13 +++
 drivers/scsi/sata_sil24.c                   |    1 
 drivers/usb/host/ohci-au1xxx.c              |    1 
 drivers/usb/input/appletouch.c              |    2 
 drivers/usb/misc/usbtest.c                  |    5 +
 drivers/usb/serial/ftdi_sio.c               |    2 
 drivers/usb/serial/ftdi_sio.h               |    6 +
 drivers/usb/serial/ipaq.c                   |    2 
 drivers/usb/storage/unusual_devs.h          |   10 ++
 fs/jfs/inode.c                              |   16 +---
 fs/jfs/jfs_inode.h                          |    1 
 fs/jfs/super.c                              |  118 ++++++++++++++++++++++++++-
 fs/xfs/xfs_alloc.c                          |  103 ++++++++++++------------
 include/linux/kernel.h                      |    1 
 include/linux/skbuff.h                      |    4 -
 include/media/v4l2-dev.h                    |    2 
 net/core/dst.c                              |    3 -
 net/core/pktgen.c                           |    4 +
 net/core/rtnetlink.c                        |   15 +++
 net/core/skbuff.c                           |    4 +
 net/core/wireless.c                         |   24 +++++
 net/ipv4/route.c                            |    2 
 net/ipv4/tcp_output.c                       |   12 ++-
 net/ipv6/addrconf.c                         |    4 -
 net/ipx/af_ipx.c                            |   10 ++
 sound/oss/Kconfig                           |    6 +
 sound/pci/Kconfig                           |   70 ++++++++--------
 usr/Makefile                                |    3 +
 69 files changed, 543 insertions(+), 284 deletions(-)
 rename drivers/media/{video/dsbr100.c => radio/dsbr100.c} (100%)

---------------

Alan Cox:
      PATCH: 2.6.18 oops on boot fix for IDE

Brandon Philips:
      genhd.c reference in Documentation/kobjects.txt

Brice Goglin:
      myri10ge: always re-enable dummy rdmas in myri10ge_resume

Chen-Li Tien:
      [PKTGEN]: Fix oops when used with balance-tlb bonding

Christoph Hellwig:
      [NET]: Fix alloc_skb comment typo
      [NET]: Assign skb->dev in netdev_alloc_skb
      [TG3]: skb->dev assignment is done by netdev_alloc_skb

Cornelia Huck:
      [S390] retry after deferred condition code.

Dave Jones:
      PCI: remove dead HOTPLUG_PCI_SHPC_PHPRM_LEGACY option.

Dave Kleikamp:
      JFS: Quota support broken, no quota_read and quota_write
      JFS: Fix bug in quota code.  tmp_bh.b_size must be initialized

David Kuehling:
      USB: unusual_devs entry for A-VOX WSX-300ER MP3 player

David S. Miller:
      [PKTGEN]: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.
      [RTNETLINK]: Fix IFLA_ADDRESS handling.
      [IPX]: Fix typo, ipxhdr() --> ipx_hdr()

Diego Calleja:
      V4L/DVB (4430): Quickcam_messenger compilation fix

Dmitry Mishin:
      [NET]: add_timer -> mod_timer() in dst_run_gc()

George G. Davis:
      [ARM] 3745/1: Add EXPORT_SYMBOL(rtc_next_alarm_time) to ARM rtctime.c

Hans Verkuil:
      V4L/DVB (4416): Cx25840_read4 has wrong endianness.
      V4L/DVB (4418): Fix broken msp3400 module option 'standard'
      V4L/DVB (4419): Turn on the Low Noise Amplifier of the Samsung tuners.

Heiko Carstens:
      [S390] tape class return value handling.

Herbert Xu:
      Send wireless netlink events with a clean slate
      [IPV6]: The ifa lock is a BH lock

Jeff Garzik:
      [libata] manually inline ata_host_remove()

Johannes Berg:
      USB: appletouch: fix atp_disconnect

Jonathan Davies:
      USB: ftdi_sio driver - new PIDs

Juha [êölä:
      [ARM] 3744/1: MMC: mmcqd gets stuck when block queue is plugged

Keith Owens:
      Fix compile problem when sata debugging is on

Kirill Korotaev:
      [IPV4]: Limit rt cache size properly.

Kristen Carlson Accardi:
      pciehp: make pciehp build for powerpc

Luc Van Oostenryck:
      V4L/DVB (4395): Restore compat_ioctl in pwc driver

Martin Michlmayr:
      [ARM] 3747/1: Fix compilation error in mach-ixp4xx/gtwx5715-setup.c

Mauro Carvalho Chehab:
      V4L/DVB (4340): Videodev.h should be included also when V4L1_COMPAT is selected.
      V4L/DVB (4371a): Fix V4L1 dependencies on compat_ioctl32
      V4L/DVB (4371b): Fix V4L1 dependencies at drivers under sound/oss and sound/pci
      V4L/DVB (4399): Fix a typo that caused some compat stuff to not work
      V4L/DVB (4407): Driver dsbr100 is a radio device, not a video one!
      V4L/DVB (4427): Fix V4L1 Compat for VIDIOCGPICT ioctl

Michael Chan:
      [TG3]: Fix tx race condition

Nathan Scott:
      [XFS] Fix xfs_free_extent related NULL pointer dereference.

Norihiko Tomiyama:
      USB: Additional PID for SHARP W-ZERO3

Orjan Friberg:
      USB: usbtest.c: unsigned retval makes ctrl_out return 0 in case of error

Pavel Machek:
      pr_debug() should not be used in drivers

Peter Oberparleiter:
      [S390] lost interrupt after chpid vary off/on cycle.

Pierre Ossman:
      [MMC] Fix base address configuration in wbsd
      [MMC] Another stray 'io' reference

Russell King:
      [ARM] Fix pci export warnings
      [ARM] Fix NCR5380-based SCSI card build
      [ARM] Fix Acorn platform SCSI driver build failures

Sam Ravnborg:
      kbuild: do not try to build content of initramfs
      kbuild: external modules shall not check config consistency

Stephen Hemminger:
      [IPX]: Header length validation needed
      [IPX]: Another nonlinear receive fix

Steven Rostedt:
      Add stable branch to maintainers file

Tejun Heo:
      libata: fix ata_port_detach() for old EH ports
      ata_piix: fix host_set private_data intialization
      sata_sil24: don't set probe_ent->mmio_base
      libata: fix ata_device_add() error path
      libata: clear sdev->locked on door lock failure

Trent Piepho:
      V4L/DVB (4411): Fix minor errors in build files

Wei Yongjun:
      [TCP]: SNMPv2 tcpOutSegs counter error

Yeasah Pell:
      V4L/DVB (4431): Add several error checks to dst

Yoichi Yuasa:
      USB: removed a unbalanced #endif from ohci-au1xxx.c

