Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWCTSwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWCTSwt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCTSwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:52:49 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:15653 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932124AbWCTSwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:52:47 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand changes for 2.6.17
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 20 Mar 2006 10:52:11 -0800
Message-ID: <aday7z5dk4k.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Mar 2006 18:52:12.0718 (UTC) FILETIME=[662FE4E0:01C64C4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

The following changes since commit 7705a8792b0fc82fd7d4dd923724606bbfd9fb20:
  Linus Torvalds:
        Linux 2.6.16

are found in the git repository at:

  blah

Ami Perlmutter:
      IB/uverbs: Use correct alt_pkey_index in modify QP

Dotan Barak:
      IB/uverbs: Support for query QP from userspace
      IB/uverbs: Support for query SRQ from userspace
      IB/mthca: Return actual capacity from create_srq
      IB/uverbs: Return actual capacity from create SRQ operation
      IB/mthca: Add support for send work request fence flag
      IB/mthca: Check alternate P_Key index when setting alternate path
      IB: Fix modify QP checking of "current QP state" attribute
      IB/uverbs: Fix query QP return of sq_sig_all
      IB/mthca: Correct reported SRQ size in MemFree case.

Eli Cohen:
      IB/mthca: Support for query QP and SRQ
      IB/mthca: Write FW commands through doorbell page
      IPoIB: Close race in setting mcast->ah
      IPoIB: Clean up if posting receives fails
      IB/mthca: Optimize large messages on Sinai HCAs
      IB/mthca: Query SRQ srq_limit fixes

Ishai Rabinovitz:
      IB/mthca: Use an enum for HCA page size

Jack Morgenstein:
      IB/mthca: Implement query_ah method
      IB/umad: Add support for large RMPP transfers
      IPoIB: Move ipoib_ib_dev_flush() to ipoib workqueue

Michael S. Tsirkin:
      IPoIB: clarify to_ipoib_neigh()
      IPoIB: Fix multicast race between canceling and completing
      IB/mad: Fix oopsable race on device removal

Or Gerlitz:
      IB: Enable FMR pool user to set page size

Ralph Campbell:
      IB/mad: Remove redundant check from smi_check_local_dr_smp()
      IB/mad: Simplify SMI by eliminating smi_check_local_dr_smp()

Roland Dreier:
      IB/mthca: Make functions that never fail return void
      IB/mthca: Get rid of might_sleep() annotations
      IB: Add userspace support for resizing CQs
      IB/mthca: Add device-specific support for resizing CQs
      IB/mthca: Whitespace cleanups
      IB: Allow userspace to set node description
      IB/mthca: Add modify_device method to set node description
      IB/mthca: Generate SQ drained events when requested
      IB: Add ib_modify_qp_is_ok() library function
      IB/mthca: Convert to use ib_modify_qp_is_ok()
      IB: Whitespace cleanups
      IB/mthca: Bump driver version and release date
      IB/uverbs: Fix alignment of struct ib_uverbs_create_qp_resp
      IB/mthca: Update firmware versions
      IB/srp: Add SCSI host attributes to show target port
      IPoIB: Fix build now that neighbour destructor is in neigh_params
      IB: Coverity fixes to sysfs.c
      IB/mthca: Coverity fix to mthca_init_eq_table()
      IB/srp: Coverity fix to srp_parse_options()
      IPoIB: Get rid of useless test of queue length

Sean Hefty:
      IB/cm: Check cm_id state before handling a REP

 drivers/infiniband/core/agent.c                |   19 -
 drivers/infiniband/core/cm.c                   |   42 +-
 drivers/infiniband/core/fmr_pool.c             |    6 
 drivers/infiniband/core/mad.c                  |  195 ++++++++--
 drivers/infiniband/core/mad_priv.h             |   16 +
 drivers/infiniband/core/mad_rmpp.c             |  148 +++-----
 drivers/infiniband/core/smi.h                  |    9 
 drivers/infiniband/core/sysfs.c                |   36 ++
 drivers/infiniband/core/user_mad.c             |  225 ++++++++----
 drivers/infiniband/core/uverbs.h               |    5 
 drivers/infiniband/core/uverbs_cmd.c           |  202 ++++++++++-
 drivers/infiniband/core/uverbs_main.c          |    6 
 drivers/infiniband/core/verbs.c                |  259 ++++++++++++++
 drivers/infiniband/hw/mthca/mthca_av.c         |   33 ++
 drivers/infiniband/hw/mthca/mthca_cmd.c        |  323 +++++++++++++----
 drivers/infiniband/hw/mthca/mthca_cmd.h        |   14 +
 drivers/infiniband/hw/mthca/mthca_cq.c         |  161 ++++++---
 drivers/infiniband/hw/mthca/mthca_dev.h        |   33 +-
 drivers/infiniband/hw/mthca/mthca_eq.c         |    6 
 drivers/infiniband/hw/mthca/mthca_mad.c        |   17 +
 drivers/infiniband/hw/mthca/mthca_main.c       |   23 +
 drivers/infiniband/hw/mthca/mthca_mcg.c        |    2 
 drivers/infiniband/hw/mthca/mthca_memfree.c    |   29 +-
 drivers/infiniband/hw/mthca/mthca_memfree.h    |   10 -
 drivers/infiniband/hw/mthca/mthca_mr.c         |   42 +-
 drivers/infiniband/hw/mthca/mthca_pd.c         |    3 
 drivers/infiniband/hw/mthca/mthca_profile.c    |   10 -
 drivers/infiniband/hw/mthca/mthca_provider.c   |  170 +++++++++
 drivers/infiniband/hw/mthca/mthca_provider.h   |   53 ++-
 drivers/infiniband/hw/mthca/mthca_qp.c         |  448 ++++++++++--------------
 drivers/infiniband/hw/mthca/mthca_srq.c        |   43 ++
 drivers/infiniband/hw/mthca/mthca_user.h       |    7 
 drivers/infiniband/ulp/ipoib/ipoib.h           |   12 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   10 -
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   15 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   25 +
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    2 
 drivers/infiniband/ulp/srp/ib_srp.c            |   85 +++++
 include/rdma/ib_fmr_pool.h                     |    2 
 include/rdma/ib_mad.h                          |   48 ++-
 include/rdma/ib_user_verbs.h                   |   79 ++++
 include/rdma/ib_verbs.h                        |   38 ++
 42 files changed, 2097 insertions(+), 814 deletions(-)
