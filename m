Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWAaXSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWAaXSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWAaXS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:18:28 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:22190 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932076AbWAaXS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:18:27 -0500
X-IronPort-AV: i="4.01,242,1136188800"; 
   d="scan'208"; a="1772181410:sNHT32203160"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand fixes for 2.6.16
X-Message-Flag: Warning: May contain useful information
References: <adar76zort4.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 31 Jan 2006 15:18:23 -0800
In-Reply-To: <adar76zort4.fsf@cisco.com> (Roland Dreier's message of "Mon,
 23 Jan 2006 08:03:03 -0800")
Message-ID: <adaek2o56m8.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 31 Jan 2006 23:18:24.0496 (UTC) FILETIME=[A247CF00:01C626BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Ingo Molnar:
      IB/srp: Semaphore to mutex conversion

Michael S. Tsirkin:
      IPoIB: Make sure path is fully initialized before using it
      IB/uverbs: Flush scheduled work before unloading module
      IB/sa_query: Flush scheduled work before unloading module
      IPoIB: Lock accesses to multicast packet queues
      IB/mthca: Use correct GID in MADs sent on port 2
      IB/mthca: Relax UAR size check
      IB/mthca: Don't cancel commands on a signal

Roland Dreier:
      IB/mthca: Semaphore to mutex conversions

 drivers/infiniband/core/sa_query.c             |    2 +
 drivers/infiniband/core/uverbs_main.c          |    1 +
 drivers/infiniband/hw/mthca/mthca_av.c         |    2 +
 drivers/infiniband/hw/mthca/mthca_cmd.c        |   13 +++------
 drivers/infiniband/hw/mthca/mthca_dev.h        |    8 +++--
 drivers/infiniband/hw/mthca/mthca_main.c       |   10 +++++--
 drivers/infiniband/hw/mthca/mthca_mcg.c        |   20 +++++--------
 drivers/infiniband/hw/mthca/mthca_memfree.c    |   36 ++++++++++++------------
 drivers/infiniband/hw/mthca/mthca_memfree.h    |    7 ++---
 drivers/infiniband/hw/mthca/mthca_provider.c   |    6 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    4 +--
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   25 +++++++++++++++--
 drivers/infiniband/ulp/srp/ib_srp.c            |   14 +++++----
 drivers/infiniband/ulp/srp/ib_srp.h            |    5 +--
 14 files changed, 86 insertions(+), 67 deletions(-)
