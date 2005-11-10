Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVKJUSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVKJUSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKJUSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:18:52 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:38740 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751223AbVKJUSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:18:52 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB updates for 2.6.15
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 10 Nov 2005 12:18:45 -0800
Message-ID: <52wtjgjly2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 10 Nov 2005 20:18:47.0260 (UTC) FILETIME=[F4AC99C0:01C5E633]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Jack Morgenstein:
      [IB] mthca: report page size capability
      [IB] uverbs: have kernel return QP capabilities

Michael S. Tsirkin:
      [IB] umad: two small fixes
      [IB] mthca: fix posting of atomic operations
      [IB] mthca: fix posting long lists of receive work requests

Roland Dreier:
      [IPoIB] add path record information in debugfs
      [IB] umad: avoid potential deadlock when unregistering MAD agents
      [IPoIB] no need to set skb->dev right before freeing skb
      [IB] mthca: fix typo in catastrophic error polling
      [IB] Have cq_resize() method take an int, not int*
      [IB] umad: get rid of unused mr array
      [IB] mthca: fix wraparound handling in mthca_cq_clean()
      [IB] umad: further ib_unregister_mad_agent() deadlock fixes

 drivers/infiniband/core/user_mad.c             |  129 ++++++++++-------
 drivers/infiniband/core/uverbs_cmd.c           |   12 +-
 drivers/infiniband/core/verbs.c                |   12 --
 drivers/infiniband/hw/mthca/mthca_catas.c      |    2 
 drivers/infiniband/hw/mthca/mthca_cmd.c        |    2 
 drivers/infiniband/hw/mthca/mthca_cq.c         |   16 +-
 drivers/infiniband/hw/mthca/mthca_dev.h        |    2 
 drivers/infiniband/hw/mthca/mthca_main.c       |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c   |    3 
 drivers/infiniband/hw/mthca/mthca_provider.h   |    1 
 drivers/infiniband/hw/mthca/mthca_qp.c         |  113 +++++++++++++--
 drivers/infiniband/hw/mthca/mthca_srq.c        |   22 +++
 drivers/infiniband/hw/mthca/mthca_wqe.h        |    3 
 drivers/infiniband/ulp/ipoib/ipoib.h           |   15 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c        |  179 ++++++++++++++++++++----
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   72 +++++++++-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   26 +--
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    7 -
 include/rdma/ib_user_verbs.h                   |    9 +
 include/rdma/ib_verbs.h                        |    2 
 20 files changed, 466 insertions(+), 163 deletions(-)
