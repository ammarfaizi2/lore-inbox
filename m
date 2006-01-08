Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWAHWZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWAHWZg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWAHWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:25:36 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:683 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S964836AbWAHWZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:25:35 -0500
X-IronPort-AV: i="3.99,344,1131350400"; 
   d="scan'208"; a="388997880:sNHT18493128986"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand updates
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 08 Jan 2006 14:25:25 -0800
Message-ID: <adaek3i9x2i.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 08 Jan 2006 22:25:25.0997 (UTC) FILETIME=[6C3F19D0:01C614A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Dotan Barak:
      IB/mthca: Add support for automatic path migration (APM)

Jack Morgenstein:
      IB/mthca: fix QP size limits for mem-free HCAs
      IB/umad: fix memory leaks
      IB/mthca: fix memory user DB table leak
      IB/mthca: check RDMA limits
      IB/mthca: correct log2 calculation
      IB/mthca: don't change driver's copy of attributes if modify QP fails
      IB/mthca: Fix SRQ cleanup during QP destroy
      IB/mthca: Fix IB_QP_ACCESS_FLAGS handling.
      IB/mthca: Fix corner cases in max_rd_atomic value handling in modify QP
      IB/mthca: fix WQE size calculation in create-srq
      IB/mthca: check return value in mthca_dev_lim call
      IB/mthca: check port validity in modify_qp
      IB/mthca: max_inline_data handling tweaks
      IB/mthca: fix for SQEr-to-RTS transition in modify QP
      IB/mthca: fix for RTR-to-RTS transition in modify QP
      IB/mthca: multiple fixes for multicast group handling
      IB/uverbs: Fix reference counting on error paths
      IB/uverbs: Release event file reference on ib_uverbs_create_cq() error

Michael S. Tsirkin:
      IB/mthca: Fix thinko in mthca_table_find()
      IB/mthca: create_eq with size not a power of 2
      IB/mthca: Fill in vendor_err field in completion with error

Ralph Campbell:
      IB/uverbs: set ah_flags when creating address handle
      IB: Set GIDs correctly in ib_create_ah_from_wc()

Sean Hefty:
      IB/cm: correct reported reject code
      IB/cm: avoid reusing local ID

 drivers/infiniband/core/cm.c                |   16 +-
 drivers/infiniband/core/user_mad.c          |    4 
 drivers/infiniband/core/uverbs_cmd.c        |   21 ++
 drivers/infiniband/core/verbs.c             |    4 
 drivers/infiniband/hw/mthca/mthca_cmd.c     |   12 +
 drivers/infiniband/hw/mthca/mthca_cq.c      |   23 ++
 drivers/infiniband/hw/mthca/mthca_eq.c      |    4 
 drivers/infiniband/hw/mthca/mthca_main.c    |    4 
 drivers/infiniband/hw/mthca/mthca_mcg.c     |   54 ++++--
 drivers/infiniband/hw/mthca/mthca_memfree.c |    4 
 drivers/infiniband/hw/mthca/mthca_qp.c      |  265 +++++++++++++++------------
 drivers/infiniband/hw/mthca/mthca_srq.c     |    2 
 12 files changed, 250 insertions(+), 163 deletions(-)
