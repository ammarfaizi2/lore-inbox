Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTHHDcV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 23:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271196AbTHHDcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 23:32:21 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:58523
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271194AbTHHDcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 23:32:20 -0400
Date: Thu, 7 Aug 2003 23:32:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [bk patches 2.6] ethtool_ops
Message-ID: <20030808033219.GA5779@gtf.org>
Reply-To: netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eventually destined for Linus, after some testing, and I after I merge
willy's 8139too.c conversion.  This ethtool_ops update doesn't break
existing drivers, allowing for piecemeal migration.


BK users:

	bk pull http://gkernel.bkbits.net/ethtool-2.6

GNU diff:

ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test2-bk7-ethtool1.patch.bz2

This will update the following files:

 drivers/net/tg3.c         |  664 +++++++++++++++++++--------------------------
 include/linux/ethtool.h   |   99 ++++++
 include/linux/netdevice.h |    9 
 net/core/Makefile         |    4 
 net/core/dev.c            |   16 -
 net/core/ethtool.c        |  672 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1076 insertions(+), 388 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/07 1.1119.3.3)
   [netdrvr] add SET_ETHTOOL_OPS back-compat hook

<jgarzik@redhat.com> (03/08/07 1.1119.3.2)
   [netdrvr tg3] convert to using ethtool_ops

   [also contributed by Matthew Wilcox -jg]

<jgarzik@redhat.com> (03/08/07 1.1119.3.1)
   [netdrvr] add ethtool_ops to struct net_device, and associated infrastructure
   
   Contributed by Matthew Wilcox.

