Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWJ3A2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWJ3A2q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbWJ3A2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 19:28:46 -0500
Received: from isilmar.linta.de ([213.239.214.66]:8893 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965230AbWJ3A2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 19:28:45 -0500
Date: Sun, 29 Oct 2006 19:28:28 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [git pull] pcmcia: bugfixes for 2.6.19-rc3
Message-ID: <20061030002828.GB24534@dominikbrodowski.de>
Mail-Followup-To: torvalds@osdl.org, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hej Linus,

The following eleven bugfix or "ID" patches have all been queued in -mm for
quite some time; please pull them from

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git

I won't send out individual patches this time, for these patches are the
same as those sent out as [RFC] on Oct 25th (
http://lkml.org/lkml/2006/10/25/245 ).

Thanks,
	Dominik


 drivers/net/wireless/hostap/hostap_cs.c |    7 +++++++
 drivers/pcmcia/at91_cf.c                |   28 +++++++++-------------------
 drivers/pcmcia/au1000_generic.c         |   25 +++++++++++++++++++------
 drivers/pcmcia/ds.c                     |   29 ++++++++++++++++++++++++-----
 drivers/pcmcia/i82092.c                 |    9 +++++----
 drivers/pcmcia/m8xx_pcmcia.c            |   12 ++++++++----
 drivers/pcmcia/omap_cf.c                |    3 ++-
 drivers/pcmcia/pcmcia_ioctl.c           |   11 ++++++++---
 drivers/pcmcia/pcmcia_resource.c        |    2 +-
 drivers/pcmcia/pd6729.c                 |    4 ++++
 drivers/pcmcia/soc_common.c             |    1 +
 drivers/pcmcia/yenta_socket.c           |   22 +++++++++++++++++-----
 12 files changed, 105 insertions(+), 48 deletions(-)

----
Alexey Dobriyan (2):
      CONFIG_PM=n slim: drivers/pcmcia/*
      i82092: wire up errors from pci_register_driver()

Amol Lad (1):
      ioremap balanced with iounmap for drivers/pcmcia

David Brownell (1):
      pcmcia: at91_cf update

Dominik Brodowski (2):
      pcmcia: add more IDs to hostap_cs.c
      PCMCIA: fix __must_check warnings

Jeff Garzik (1):
      PCMCIA: handle sysfs, PCI errors

Jonathan McDowell (1):
      Export soc_common_drv_pcmcia_remove to allow modular PCMCIA.

Kaustav Majumdar (1):
      pcmcia: update alloc_io_space for conflict checking for multifunction PC card

Om Narasimhan (1):
      pcmcia: au1000_generic fix

Randy Dunlap (1):
      pcmcia/ds: driver layer error checking
