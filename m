Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVITWIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVITWIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVITWI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:27 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:48177 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965060AbVITWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:25 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand fixes
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Tue, 20 Sep 2005 15:08:10 -0700
Message-Id: <2005920158.2ndgBgW8RwzzVaAk@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 20 Sep 2005 22:08:11.0837 (UTC) FILETIME=[CA664ED0:01C5BE2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git

This tree is also available from kernel.org mirrors at:

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git

This will pull the following changes (patches also sent as replies to this email):

Hal Rosenstock:
  IPoIB: Fix SA client retransmission strategy
  IB: Fix data length for RMPP SA sends

Michael S. Tsirkin:
  IPoIB: fix module removal race
  IB/mthca: Fix device removal memory leak

Roland Dreier:
  IB/mthca: assign ACK timeout field correctly
  IB/mthca: fix posting of first work request
  IB/mthca: Initialize eq->nent before we use it
  IB/mthca: Fix posting work requests to shared receive queues
  IB/mthca: Don't try to set srq->last for userspace SRQs
  IPoIB: Don't flush workqueue from within workqueue

 drivers/infiniband/core/user_mad.c             |    5 +-
 drivers/infiniband/hw/mthca/mthca_eq.c         |   16 ++------
 drivers/infiniband/hw/mthca/mthca_qp.c         |   51 +++++++++++-------------
 drivers/infiniband/hw/mthca/mthca_srq.c        |   25 +++++-------
 drivers/infiniband/ulp/ipoib/ipoib.h           |    2 -
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |    2 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   13 +++---
 8 files changed, 55 insertions(+), 63 deletions(-)

