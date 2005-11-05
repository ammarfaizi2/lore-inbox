Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVKEAUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVKEAUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKEAUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:20:13 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:49780 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751263AbVKEAUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:20:11 -0500
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] IB updates
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 04 Nov 2005 16:20:03 -0800
Message-ID: <523bmc2bf0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 05 Nov 2005 00:20:04.0155 (UTC) FILETIME=[AB18F8B0:01C5E19E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Jack Morgenstein:
      [IB] mthca: check P_Key index in modify QP

Michael S. Tsirkin:
      [IB] mthca: report asynchronous CQ events

Roland Dreier:
      [IPoIB] use spin_trylock_irqsave()
      [IB] uverbs: Avoid NULL pointer deref on CQ async event
      [IB] mthca: Avoid SRQ free WQE list corruption
      [IPoIB] cleanups: fix comment, remove useless variables
      [IB] kzalloc() conversions
      [IPoIB] remove unneeded initializations to 0
      [IPoIB] don't compile debug code if debugging isn't enabled
      [IB] mthca: fix format of FW version
      [IB] umad: fix hot remove of IB devices

Sean Hefty:
      [IB] ucm: 32/64 compatibility fixes

 drivers/infiniband/core/agent.c                |    3 -
 drivers/infiniband/core/cm.c                   |    6 +-
 drivers/infiniband/core/device.c               |   10 ---
 drivers/infiniband/core/mad.c                  |   31 ++++-----
 drivers/infiniband/core/sysfs.c                |    6 +-
 drivers/infiniband/core/ucm.c                  |    9 +--
 drivers/infiniband/core/user_mad.c             |   80 +++++++++++++++++++-----
 drivers/infiniband/core/uverbs.h               |    1 
 drivers/infiniband/core/uverbs_cmd.c           |    1 
 drivers/infiniband/core/uverbs_main.c          |   13 +---
 drivers/infiniband/hw/mthca/mthca_cq.c         |   31 +++++++++
 drivers/infiniband/hw/mthca/mthca_dev.h        |    4 +
 drivers/infiniband/hw/mthca/mthca_eq.c         |    4 +
 drivers/infiniband/hw/mthca/mthca_main.c       |    2 -
 drivers/infiniband/hw/mthca/mthca_mr.c         |    4 -
 drivers/infiniband/hw/mthca/mthca_profile.c    |    4 -
 drivers/infiniband/hw/mthca/mthca_provider.c   |    2 -
 drivers/infiniband/hw/mthca/mthca_qp.c         |    7 ++
 drivers/infiniband/hw/mthca/mthca_srq.c        |   13 ++--
 drivers/infiniband/ulp/ipoib/ipoib.h           |    3 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |   13 ++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   24 ++-----
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    8 ++
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    4 -
 include/rdma/ib_user_cm.h                      |   19 ++++--
 25 files changed, 178 insertions(+), 124 deletions(-)
