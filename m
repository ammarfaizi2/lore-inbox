Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTEZElg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEZElg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:41:36 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:49070
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263898AbTEZEld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:41:33 -0400
Date: Mon, 26 May 2003 00:54:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] more net driver merges
Message-ID: <20030526045444.GA27191@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk18-netdrvr2.patch.bz2

This will update the following files:

 drivers/net/bonding.c             | 3299 ------------------------------
 drivers/net/3c505.c               |  110 -
 drivers/net/Makefile              |    2 
 drivers/net/au1000_eth.c          |   33 
 drivers/net/bmac.c                |    1 
 drivers/net/bonding/Makefile      |   24 
 drivers/net/bonding/bond_3ad.c    | 2476 +++++++++++++++++++++++
 drivers/net/bonding/bond_3ad.h    |  298 ++
 drivers/net/bonding/bond_alb.c    | 1571 ++++++++++++++
 drivers/net/bonding/bond_alb.h    |  127 +
 drivers/net/bonding/bond_main.c   | 4053 ++++++++++++++++++++++++++++++++++++++
 drivers/net/bonding/bonding.h     |  181 +
 drivers/net/cs89x0.h              |    6 
 drivers/net/hamachi.c             |    4 
 drivers/net/tlan.c                |    2 
 drivers/net/tulip/de4x5.c         |    2 
 drivers/net/tulip/interrupt.c     |    2 
 drivers/net/tulip/tulip.h         |   13 
 drivers/net/tulip/xircom_cb.c     |   37 
 drivers/net/wireless/netwave_cs.c |   39 
 drivers/net/wireless/orinoco_cs.c |   24 
 drivers/net/wireless/wavelan_cs.c |   73 
 include/linux/if_bonding.h        |   91 
 include/linux/if_vlan.h           |    1 
 include/linux/skbuff.h            |    1 
 net/core/dev.c                    |    4 
 net/core/skbuff.c                 |    2 
 27 files changed, 8896 insertions(+), 3580 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/05/26 1.1366)
   [netdrvr tulip] fix bogus merges

<jgarzik@redhat.com> (03/05/26 1.1365)
   [netdrvr bonding] minor merge/kbuild fixes

<jgarzik@redhat.com> (03/05/26 1.1364)
   [netdrvr bonding] add 802.3ad support
   
   Contributed by Intel, with updates by
   Jay Vosburgh @ IBM (bonding maintainer)

<hch@lst.de> (03/05/25 1.1363)
   [PATCH] wireless pcmcia updates
   
   the same patch stil applies..

<davej@codemonkey.org.uk> (03/05/25 1.1362)
   [PATCH] au1000 init cleanups.
   
   Not sure if I incorporated all your feedback on this one last time.
   Bug me if not...

<davej@codemonkey.org.uk> (03/05/25 1.1361)
   [PATCH] hamachi PCI DMA fix from 2.4
   
   Maintainer fix that went into 2.4 last August with the comments
   "Get hamachi net driver RX working again.
    Apparently the PCI DMA conversion still has a bug or two left in it..."

<davej@codemonkey.org.uk> (03/05/25 1.1360)
   [PATCH] 3c505 printk levels.

<davej@codemonkey.org.uk> (03/05/25 1.1359)
   [PATCH] xircom init cleanups

<davej@codemonkey.org.uk> (03/05/25 1.1358)
   [PATCH] fix tlan 64bit check

<davej@codemonkey.org.uk> (03/05/25 1.1357)
   [PATCH] Age old cs89x0 register define 'fixes' ?
   
   Remember these? There never was an outcome as to whether or
   not their doing the right thing.  Any complaints from this being
   in 2.4 for nearly a year ?

<davej@codemonkey.org.uk> (03/05/25 1.1356)
   [PATCH] Nuke stale comment from bmac
   
   Leftovers from before we used memset to clear the struct.

<jgarzik@redhat.com> (03/05/25 1.1355)
   [netdvr tulip] nuke stale defines
   
   Noticed (indirectly) by davej

