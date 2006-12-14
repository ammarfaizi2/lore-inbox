Return-Path: <linux-kernel-owner+w=401wt.eu-S932773AbWLNOUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWLNOUJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWLNOT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:19:57 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:46404 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932760AbWLNOTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:19:30 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  v4 00/13] 2.6.20 Chelsio T3 RDMA Driver
Date: Thu, 14 Dec 2006 07:52:33 -0600
To: rdreier@cisco.com
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Message-Id: <20061214135233.21159.78613.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland, 

I think this is ready to go once the ethernet driver is pulled in.

Version 4 changes:

- Cleaned up spacing in the Kconfig file
- Remove locking.txt file - its not needed
- Remove -O1 from the debug config option
- BugFix: support new LLD interface for dual-port adapters

Version 3 changes:

- BugFix: Don't use mutex inside of the mmap function.
- BugFix: Move QP to TERMINATE when TERMINATE AE is processed
- Support the new work queue design
- Merged up to linus's tree as of 12/8/2006
- Misc nits

Version 2 changes:

- Make code sparse endian clean
- Use IDRs for mapping QP and CQ IDs to structure pointers instead
  of arrays
- Clean up confusing bitfields
- Use random32() instead of local random function
- Use krefs to track endpoint reference counts
- Misc nits

-----

The following series implements the Chelsio T3 iWARP/RDMA Driver to
be considered for inclusion in 2.6.20.  It depends on the Chelsio T3
Ethernet driver which is also under review now for 2.6.20. 

The latest Chelsio T3 Ethernet driver patch can be pulled from:

	http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

A complete GIT kernel tree with all the T3 drivers can be pulled from:

	git://staging.openfabrics.org/~swise/cxgb3.git

Thanks,

Steve.
