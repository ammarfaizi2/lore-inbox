Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbTGHXMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267906AbTGHXMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:12:35 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:24729
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S267890AbTGHXL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:11:57 -0400
Date: Tue, 8 Jul 2003 19:26:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] net driver merges
Message-ID: <20030708232634.GA29175@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(note to others -- more coming, the queue isn't empty yet)

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.74-bk5-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/8139too.c             |    2 
 drivers/net/e1000/e1000.h         |    1 
 drivers/net/e1000/e1000_ethtool.c |    5 -
 drivers/net/e1000/e1000_hw.c      |   59 ++++++++++--
 drivers/net/e1000/e1000_hw.h      |   18 +++
 drivers/net/e1000/e1000_main.c    |  186 ++++++++++++++++++++------------------
 drivers/net/via-rhine.c           |   36 +++++--
 7 files changed, 198 insertions(+), 109 deletions(-)

through these ChangeSets:

<scott.feldman@intel.com> (03/07/08 1.1431)
   [e1000] misc cleanup
   
   * whitespace cleanup
   * removal of unused members of netdev priv struct
   * extendable arrangement of h/w reset logic

<scott.feldman@intel.com> (03/07/08 1.1430)
   [e1000] s/int/unsigned int/ for descriptor ring indexes
   
   * Perf cleanup: s/int/unsigned int/ for descriptor ring indexes
     [suggestion by Jeff Garzik].
   * Perf cleanup: cache references to ring elements using local pointer

<scott.feldman@intel.com> (03/07/08 1.1429)
   [e1000] h/w workaround for mis-fused parts
   
   * h/w workaround: several 10's of thousands of 82547 controllers where
     mis-fused during manufacturing, resulting in PHY Tx amplitude to be
     too high and out of spec.  This workaround detects those parts, and
     compensates the Tx amplitude by subtracting ~80mV.

<scott.feldman@intel.com> (03/07/08 1.1428)
   [e1000] ethtool diag cleanup
   
   * Cleanup: ethtool diags: only reset if not if_running.

<scott.feldman@intel.com> (03/07/08 1.1427)
   [e1000] alloc_etherdev failure didn't cleanup regions
   
   * Bug fix: alloc_etherdev failure didn't cleanup regions in probe.

<scott.feldman@intel.com> (03/07/08 1.1426)
   [e1000] missing Tx cleanup opportunities during intr handling
   
   * Bug fix: missing Tx cleanup opportunities during interrupt handling.

<scott.feldman@intel.com> (03/07/08 1.1425)
   [e1000] fix VLAN support on PPC64
   
   * Bug fix: fix VLAN support on PPC64 [Mark Rakes (mrakes@vivato.net)]

<scott.feldman@intel.com> (03/07/08 1.1424)
   [e1000] request_irq() failure resulted in freeing twice
   
   * Bug fix: request_irq() failure resulted in freeing resources twice!
     [Don Fry (brazilnut@us.ibm.com)]

<rl@hellgate.ch> (03/07/08 1.1423)
   [PATCH] via-rhine 1.18-2.5: Fix Rhine-I regression
   
   This patch addresses a minor regression reported by Rhine-I users (leading
   to occasional Tx timeouts).
   
   I also merged some cosmetic changes.

<jgarzik@redhat.com> (03/07/05 1.1422)
   [netdrvr 8139too] fix debug printk
   
   printk args had been accidentally reversed

