Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTKHR25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKHR24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:28:56 -0500
Received: from havoc.gtf.org ([63.247.75.124]:51679 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261891AbTKHR2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:28:54 -0500
Date: Sat, 8 Nov 2003 12:27:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] net driver fixes
Message-ID: <20031108172748.GA8186@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5

This will update the following files:

 drivers/net/b44.c     |   56 ++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/pcnet32.c |    4 +++
 2 files changed, 58 insertions(+), 2 deletions(-)

through these ChangeSets:

<ralf@linux-mips.org> (03/11/08 1.1416)
   [netdrvr pcnet32] add missing pci_dma_sync_single
   
   a patch for the pcnet32.c driver which adds a missing call to
   pci_dma_sync_single.  If a received packet is smaller than rx_copybreak
   the pcnet driver will recycle the receive buffer which requires calling
   pci_dma_sync_single.  Patch is against 2.6 but I it's also needed in 2.4.
   
   Without that call the processor might still have old stale data in
   the data cache when the processor accesses the recycled buffer.
   

<pp@ee.oulu.fi> (03/11/08 1.1415)
   [netdrvr b44] Fix irq enable/disable; fix oops due to lack of SET_NETDEV_DEV() call
   
   Also, add suspend/resume functions.

