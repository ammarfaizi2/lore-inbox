Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbVIJDWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbVIJDWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVIJDWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:22:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbVIJDWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:22:07 -0400
Date: Fri, 9 Sep 2005 20:22:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.13.1
Message-ID: <20050910032202.GF7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.13.1 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.13 and 2.6.13.1, as it is small enough to do so.

The updated 2.6.13.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.13.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

----------

 Makefile                      |    2 -
 arch/i386/pci/common.c        |    1 
 arch/i386/pci/i386.c          |   49 +++++++++++++-----------------------------
 crypto/cipher.c               |   12 +++++++---
 drivers/char/rtc.c            |    5 +---
 drivers/media/video/Kconfig   |    1 
 drivers/pci/rom.c             |   24 ++++++++++++++------
 drivers/pci/setup-bus.c       |    2 -
 drivers/scsi/aacraid/aachba.c |    2 -
 include/net/compat.h          |    5 ++--
 net/compat.c                  |   44 ++++++++++++++++++++++---------------
 net/core/filter.c             |    6 ++---
 net/ipv4/ip_fragment.c        |    2 -
 net/ipv4/raw.c                |    2 -
 net/ipv6/raw.c                |    2 -
 net/socket.c                  |    3 +-
 16 files changed, 85 insertions(+), 77 deletions(-)

Summary of changes from v2.6.13 to v2.6.13.1
============================================

Al Viro:
  raw_sendmsg DoS (CAN-2005-2492)

Benjamin Herrenschmidt:
  Fix PCI ROM mapping

Chris Wright:
  Linux 2.6.13.1

David S. Miller:
  Use SA_SHIRQ in sparc specific code.

David Woodhouse:
  32bit sendmsg() flaw (CAN-2005-2490)

Herbert Xu:
  2.6.13 breaks libpcap (and tcpdump)
  Fix boundary check in standard multi-block cipher processors

Ivan Kokshaysky:
  x86: pci_assign_unassigned_resources() update

Mark Haverkamp:
  aacraid: 2.6.13 aacraid bad BUG_ON fix

Michael Krufky:
  Kconfig: saa7134-dvb must select tda1004x

Stephen Hemminger:
  Reassembly trim not clearing CHECKSUM_HW

