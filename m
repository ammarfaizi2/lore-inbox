Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWIHVzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWIHVzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIHVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:55:44 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:7532 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751122AbWIHVzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:55:42 -0400
Cc: tom@opengridcomputing.com, swise@opengridcomputing.com
Subject: [PATCH 0/2] RDMA: merge iWARP support
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Fri, 8 Sep 2006 14:55:40 -0700
Message-Id: <2006981455.F7Cau4RN2pBSAVMu@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 08 Sep 2006 21:55:41.0526 (UTC) FILETIME=[86FFAF60:01C6D391]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rolandd@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches that adds iWARP (RDMA over IP) support to
the InfiniBand support already in the kernel.  Since the iWARP RDMA
model is quite close to the InfiniBand model, the changes are not that
large.  The biggest difference is in how connections are established,
since iWARP connections are TCP connections, while IB uses a different
(native IB) mechanism for establishing a connection.

The first patch in the series adds an iWARP connection manager, which
handles establishing and tearing down connections for iWARP devices.
The second patch is all the small changes required to hook in the
connection manager and make the rest of the IB stuff also work with
iWARP devices.  The third patch (compressed due to its size) adds the
first driver for an iWARP device, the Ammasso 1100 1 Gb/sec RNIC.

My current plan is to merge this stuff for 2.6.19.  Please let me know
if you see anything (major or minor) that needs to be fixed up.

Thanks,
  Roland
