Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275304AbTHSEan (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHSEaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:30:13 -0400
Received: from [63.247.75.124] ([63.247.75.124]:21167 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S275348AbTHSE3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:29:43 -0400
Date: Tue, 19 Aug 2003 00:29:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] 2.4 net driver updates
Message-ID: <20030819042917.GA1402@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(pending for Marcelo, for 2.4.23-pre1)


BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4
		or
	bk pull http://gkernel.bkbits.net/net-drivers-2.4

Patch:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-rc2-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/8139cp.c            |    4 
 drivers/net/8139too.c           |   10 
 drivers/net/bonding/bond_main.c |   17 -
 drivers/net/bonding/bonding.h   |    2 
 drivers/net/net_init.c          |    3 
 drivers/net/tulip/tulip_core.c  |    1 
 drivers/net/wireless/airo.c     |  568 ++++++++++++++++++++++------------------
 include/linux/netdevice.h       |    2 
 8 files changed, 342 insertions(+), 265 deletions(-)

through these ChangeSets:

<sziwan@hell.org.pl> (03/08/18 1.1064.1.13)
   [netdrvr 8139too] fix resume behavior,
   by correctly saving/restoring pci state.

<matthewn@snapgear.com> (03/08/18 1.1064.1.12)
   [netdrvr 8139cp] fix h/w vlan offload
   
   It wants big endian vlan tags.  IEEE, or just weird?

<javier@tudela.mad.ttd.net> (03/08/18 1.1064.1.11)
   [wireless airo] Replaces task queues by simpler kernel_thread

<javier@tudela.mad.ttd.net> (03/08/18 1.1064.1.10)
   [wireless airo] Fixes unregistering of PCI cards

<ionut@badula.org> (03/08/17 1.1064.1.9)
   [netdrvr tulip] add pci id for 3com 3CSOHO100B-TX

<amir.noam@intel.com> (03/08/07 1.1064.1.8)
   [netdrvr bonding] embed stats struct inside bonding private struct
   
   Simplification: Don't allocate the stats struct via kmalloc,
   embed it inside it's parent bonding_t.

<amir.noam@intel.com> (03/08/07 1.1064.1.7)
   [net] export alloc_netdev

<achirica@telefonica.net> (03/08/07 1.1064.1.6)
   [PATCH] Fix adhoc config

<achirica@telefonica.net> (03/08/07 1.1064.1.5)
   [PATCH] Safer unload code

<achirica@telefonica.net> (03/08/07 1.1064.1.4)
   [PATCH] MIC support with newer firmware

<achirica@telefonica.net> (03/08/07 1.1064.1.3)
   [PATCH] Missing lines for Wireless Extensions 16

<achirica@telefonica.net> (03/08/07 1.1064.1.2)
   [netdrvr airo] MAC type changed to unsigned

<achirica@telefonica.net> (03/08/07 1.1064.1.1)
   [netdrvr airo] Missing defines (only for documentation)

