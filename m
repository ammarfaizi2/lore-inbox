Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422912AbWBAUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbWBAUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 15:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWBAUD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 15:03:26 -0500
Received: from fmr20.intel.com ([134.134.136.19]:23461 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422910AbWBAUDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 15:03:25 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <openib-general@openib.org>
Subject: [PATCH 0/5] Infiniband: connection abstraction
Date: Wed, 1 Feb 2006 12:03:06 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcYnaoPoeQwbN57KSxu+/VIzb9oBFw==
Message-ID: <ORSMSX401KZmcK8r6be00000097@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 01 Feb 2006 20:03:07.0202 (UTC) FILETIME=[84A46220:01C6276A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of these patches based on feedback.   (The license
did not change and continues to match that of the other Infiniband code.)
Please consider for inclusion in 2.6.17.

The following set of patches defines a connection abstraction for Infiniband and
other RDMA devices, and serves several purposes:

* It implements a connection protocol over Infiniband based on IP addressing.
This greatly simplifies clients wishing to establish connections over
Infiniband.

* It defines a connection abstraction that works over multiple RDMA devices.
The submitted implementation targets Infiniband, but has been tested over other
RDMA devices as well.

* It handles RDMA device insertion and removal on behalf of its clients.

The changes have been broken into 5 separate patches.  The basic purpose of each
patch is:

1. Provide common handling for marshalling data between userspace clients and
kernel mode Infiniband drivers.

2. Extend the Infiniband CM to include private data comparisons as part of its
connection request matching process.

3. Provide an address translation service that maps IP addresses to Infiniband
addresses (GIDs).  This patch touches outside of the Infiniband core, so I'm
including the netdev mailing list.

4. Implement the kernel mode RDMA connection management agent.

5. Implement the userspace RDMA connection management agent kernel support
module.

Please copy the openib-general mailing list on any replies.

Thanks,
Sean

