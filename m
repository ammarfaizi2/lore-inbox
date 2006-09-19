Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWISTNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWISTNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbWISTNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:13:44 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:53119 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751953AbWISTNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:13:38 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git (one-liner fix for 2.6.18)
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 19 Sep 2006 12:13:36 -0700
Message-ID: <adaeju7llen.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Sep 2006 19:13:37.0463 (UTC) FILETIME=[B58CAC70:01C6DC1F]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This contains another one-liner that fixes a regression from 2.6.17:

Jack Morgenstein:
      IB/mthca: Fix lid used for sending traps

 drivers/infiniband/hw/mthca/mthca_mad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/drivers/infiniband/hw/mthca/mthca_mad.c b/drivers/infiniband/hw/mthca/mthca_mad.c
index d9bc030..45e106f 100644
--- a/drivers/infiniband/hw/mthca/mthca_mad.c
+++ b/drivers/infiniband/hw/mthca/mthca_mad.c
@@ -119,7 +119,7 @@ static void smp_snoop(struct ib_device *
 
 			mthca_update_rate(to_mdev(ibdev), port_num);
 			update_sm_ah(to_mdev(ibdev), port_num,
-				     be16_to_cpu(pinfo->lid),
+				     be16_to_cpu(pinfo->sm_lid),
 				     pinfo->neighbormtu_mastersmsl & 0xf);
 
 			event.device           = ibdev;
