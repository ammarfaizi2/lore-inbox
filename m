Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVLPXtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVLPXtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLPXtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:49:14 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:10862 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932559AbVLPXtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:49:13 -0500
X-IronPort-AV: i="3.99,263,1131350400"; 
   d="scan'208"; a="242176686:sNHT31703976"
Subject: [PATCH 00/13]  [RFC] IB: PathScale InfiniPath driver
In-Reply-To: <20051031150618.627779f1.akpm@osdl.org>
X-Mailer: Roland's Patchbomber
Date: Fri, 16 Dec 2005 15:48:54 -0800
Message-Id: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 16 Dec 2005 23:48:55.0323 (UTC) FILETIME=[468956B0:01C6029B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an initial submission from PathScale of a driver for
InfiniPath InfiniBand HCAs.  The driver is fairly big -- some single
files are more than the 100 KB limit for lkml posts -- so I've split
it up into a patch series so it can be reviewed inline.  The split-up
doesn't make sense functionally but I want to make review as easy as
possible; any final import will merge the driver as a single git
patch.

I've also put the current splitup patchset into my git tree at

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git

in the ipath branch.

There are some things I noticed that could maybe be cleaned up, like
having sysctls that set values also settable through module parameters
under /sys/module, code inside #ifndef __KERNEL__ so include files can
be shared with other PathScale code, code in ipath_i2c.c that might be
simplified by using drivers/i2c, etc.  I'd like to try to get a sense
of whether I'm being too picky or whether PathScale really does need
to fix these up before the driver is merged.

Basically I'm trying to feel my way as a maintainer so I can find the
right balance between wanting kernel code to be absolutely perfect and
not wanting to put arbitrary hurdles in front of a vendor who has done
a lot of work on contributing an open driver for their hardware.

I am especially interested in feedback about the mergability of this
driver from the broader kernel community, although of course feedback
from the InfiniBand/RDMA community on IB-specific aspects of the
driver is very much appreciated as well.

Thanks,
  Roland
