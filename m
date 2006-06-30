Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWF3ApI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWF3ApI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWF3ApH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:45:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45699 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751366AbWF3ApE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:45:04 -0400
Date: Thu, 29 Jun 2006 17:39:56 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.17.2
Message-ID: <20060630003956.GE11588@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.17.2 kernel.
Assorted fixes, see the diffstat and short summary of the fixes below.

I'll also be replying to this message with a copy of the patch between
2.6.17.1 and 2.6.17.2, as it is small enough to do so.

The updated 2.6.17.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                                    |    2 -
 arch/sparc/mm/iommu.c                       |    3 +-
 arch/um/kernel/time_kern.c                  |    2 -
 drivers/ide/ide-io.c                        |    2 -
 drivers/ieee1394/ohci1394.c                 |    3 ++
 drivers/input/input.c                       |    2 -
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   28 ++++++++++-----------
 drivers/parport/Kconfig                     |    2 -
 drivers/scsi/libata-core.c                  |    2 -
 drivers/usb/serial/whiteheat.c              |    4 +--
 fs/ntfs/file.c                              |   13 +++++----
 include/asm-i386/alternative.h              |    2 +
 include/linux/libata.h                      |    9 ++++--
 include/linux/pfkeyv2.h                     |    2 -
 include/net/sctp/structs.h                  |    3 +-
 kernel/exit.c                               |    2 -
 lib/idr.c                                   |   16 +++++++++---
 net/core/ethtool.c                          |    3 +-
 net/ipv6/addrconf.c                         |   37 ++++++++++++++++++++++++----
 net/sctp/input.c                            |    3 +-
 net/sctp/ipv6.c                             |    6 +++-
 net/sctp/outqueue.c                         |    1 
 net/sctp/protocol.c                         |    8 +++++-
 net/sctp/sm_statefuns.c                     |   10 ++++++-
 net/sctp/socket.c                           |   28 +++++++++++++++++++--
 net/sctp/ulpevent.c                         |   30 +++++++++++++++++++++-
 usr/Makefile                                |    3 --
 27 files changed, 171 insertions(+), 55 deletions(-)

Summary of changes from v2.6.17.1 to v2.6.17.2
================================================

Al Boldi:
      ide-io: increase timeout value to allow for slave wakeup

Anton Altaparmakov:
      NTFS: Critical bug fix (affects MIPS and possibly others)

Anton Blanchard:
      Link error when futexes are disabled on 64bit architectures

Chris Wright:
      Linux 2.6.17.2

David Miller:
      SCTP: Reset rtt_in_progress for the chunk when processing its sack.
      SPARC32: Fix iommu_flush_iotlb end address

Herbert Xu:
      ETHTOOL: Fix UFO typo

Jeff Dike:
      UML: fix uptime

Kirill Smelkov:
      x86: compile fix for asm-i386/alternatives.h

Michael Buesch:
      bcm43xx: init fix for possible Machine Check

Neil Horman:
      SCTP: Fix persistent slowdown in sctp when a gap ack consumes rx buffer.

Nickolay:
      kbuild: bugfix with initramfs

Richard Purdie:
      Input: return correct size when reading modalias attribute

Robert Hancock:
      ohci1394: Fix broken suspend/resume in ohci1394

Sonny Rao:
      idr: fix race in idr code

Stuart MacDonald:
      USB: Whiteheat: fix firmware spurious errors

Tejun Heo:
      libata: minor patch for ATA_DFLAG_PIO

Tsutomu Fujii:
      SCTP: Send only 1 window update SACK per message.

Tushar Gohad:
      PFKEYV2: Fix inconsistent typing in struct sadb_x_kmprivate.

Vlad Yasevich:
      SCTP: Limit association max_retrans setting in setsockopt.
      SCTP: Reject sctp packets with broadcast addresses.

YOSHIFUJI Hideaki:
      IPV6: Sum real space for RTAs.
      IPV6 ADDRCONF: Fix default source address selection without CONFIG_IPV6_PRIVACY

Łukasz Stelmach:
      IPV6: Fix source address selection.

