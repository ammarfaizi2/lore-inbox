Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbWFVQWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWFVQWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWFVQWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:22:36 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:35613 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1161165AbWFVQWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:22:35 -0400
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="1830694733:sNHT34124664"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 22 Jun 2006 09:22:33 -0700
Message-ID: <aday7vpkvna.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2006 16:22:33.0974 (UTC) FILETIME=[1144C960:01C69618]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This is mostly merging the new iSER (iSCSI over RDMA transport) initiator:

Krishna Kumar:
      IB/uverbs: Don't free wr list when it's known to be empty

Or Gerlitz:
      IB/iser: iSCSI iSER transport provider header file
      IB/iser: iSCSI iSER transport provider high level code
      IB/iser: iSER initiator iSCSI PDU and TX/RX
      IB/iser: iSER RDMA CM (CMA) and IB verbs interaction
      IB/iser: iSER handling of memory for RDMA
      IB/iser: iSER Kconfig and Makefile

Roland Dreier:
      IB/uverbs: Remove unnecessary list_del()s

 drivers/infiniband/Kconfig                   |    2 
 drivers/infiniband/Makefile                  |    1 
 drivers/infiniband/core/uverbs_cmd.c         |    2 
 drivers/infiniband/core/uverbs_main.c        |    6 
 drivers/infiniband/ulp/iser/Kconfig          |   11 
 drivers/infiniband/ulp/iser/Makefile         |    4 
 drivers/infiniband/ulp/iser/iscsi_iser.c     |  790 +++++++++++++++++++++++++
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  354 +++++++++++
 drivers/infiniband/ulp/iser/iser_initiator.c |  738 +++++++++++++++++++++++
 drivers/infiniband/ulp/iser/iser_memory.c    |  401 +++++++++++++
 drivers/infiniband/ulp/iser/iser_verbs.c     |  827 ++++++++++++++++++++++++++
 drivers/scsi/Makefile                        |    1 
 12 files changed, 3130 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/ulp/iser/Kconfig
 create mode 100644 drivers/infiniband/ulp/iser/Makefile
 create mode 100644 drivers/infiniband/ulp/iser/iscsi_iser.c
 create mode 100644 drivers/infiniband/ulp/iser/iscsi_iser.h
 create mode 100644 drivers/infiniband/ulp/iser/iser_initiator.c
 create mode 100644 drivers/infiniband/ulp/iser/iser_memory.c
 create mode 100644 drivers/infiniband/ulp/iser/iser_verbs.c
