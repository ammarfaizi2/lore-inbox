Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVIQBYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVIQBYG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIQBYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:24:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbVIQBYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:24:04 -0400
Date: Fri, 16 Sep 2005 18:20:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.13.2
Message-ID: <20050917012050.GK7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.13.2 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.13.1 and 2.6.13.2, as it is small enough to do so.

The updated 2.6.13.y git tree can be found at:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.13.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

Note: The above info won't be valid until master.kernel.org is back
online.  In the interim you can find the tarball, patches, changelogs
etc. at <http://developer.osdl.org/chrisw/stable/2.6.13.2/>

thanks,
-chris

----------

 Makefile                            |    2 -
 arch/x86_64/ia32/ia32_ioctl.c       |   17 ++++++++++---
 drivers/ide/pci/cmd64x.c            |    2 -
 drivers/ide/pci/hpt34x.c            |    2 -
 drivers/ide/pci/hpt366.c            |    8 ++++--
 drivers/net/forcedeth.c             |    3 ++
 drivers/net/sungem.c                |   36 +++++++++++-----------------
 drivers/net/sunhme.c                |   45 ++++++++++++++----------------------
 drivers/usb/serial/ftdi_sio.c       |    2 -
 fs/compat_ioctl.c                   |    7 ++++-
 fs/jfs/inode.c                      |   24 +++++++++----------
 mm/mempolicy.c                      |    7 ++++-
 net/ipv4/netfilter/ipt_MASQUERADE.c |    6 ++++
 13 files changed, 87 insertions(+), 74 deletions(-)

Summary of changes from v2.6.13.1 to v2.6.13.2
============================================

Andi Kleen:
  Fix MPOL_F_VERIFY

Chris Wright:
  Linux 2.6.13.2

Dave Kleikamp:
  jfs: jfs_delete_inode must call clear_inode

Ian Abbott:
  USB: ftdi_sio: custom baud rate fix

Linus Torvalds:
  hpt366: write the full 4 bytes of ROM address, not just low 1 byte
  Sun GEM ethernet: enable and map PCI ROM properly
  Fix up more strange byte writes to the PCI_ROM_ADDRESS config word

Manfred Spraul:
  forcedeth: Initialize link settings in every nv_open()

Maxim Giryaev:
  lost fput in 32bit ioctl on x86-64
  Lost sockfd_put() in routing_ioctl()

Patrick McHardy:
  Fix DHCP + MASQUERADE problem

Willy Tarreau:
  Sun HME: enable and map PCI ROM properly
