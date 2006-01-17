Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWAQXQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWAQXQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAQXQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:16:09 -0500
Received: from fmr19.intel.com ([134.134.136.18]:10204 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964885AbWAQXQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:16:06 -0500
From: "Sean Hefty" <sean.hefty@intel.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "'Sean Hefty'" <sean.hefty@intel.com>
Cc: <openib-general@openib.org>
Subject: [PATCH 0/5] [RFC] Infiniband: connection abstraction
Date: Tue, 17 Jan 2006 15:16:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcYbu/zrU6zfCVlKQduiSToJrEPb/g==
Message-ID: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com>
X-OriginalArrivalTime: 17 Jan 2006 23:16:05.0044 (UTC) FILETIME=[FD609F40:01C61BBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
kernel mode Infiniband 	drivers.

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

