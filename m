Return-Path: <linux-kernel-owner+w=401wt.eu-S1750986AbXAFReW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXAFReW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXAFReW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:34:22 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:50616 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXAFReU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:34:20 -0500
Date: Sat, 6 Jan 2007 19:34:40 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Felix Marti <felix@chelsio.com>
Cc: Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070106173439.GC26997@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <8A71B368A89016469F72CD08050AD334F3BE50@maui.asicdesigners.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A71B368A89016469F72CD08050AD334F3BE50@maui.asicdesigners.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Jan 2007 17:35:48.0252 (UTC) FILETIME=[1A40E5C0:01C731B9]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14918.000
X-TM-AS-Result: No--7.003500-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Felix Marti] In addition, is arming the CQ really in the performance
> path? - Don't apps poll the CQ as long as there are pending CQEs and
> only arm the CQ for notification once there is nothing left to do? If
> this is the case, it would mean that we waste a few cycles 'idle'
> cycles.

Applications such as IPoIB might queue up packets, then ARM the CQ,
and only then they are processed by the upper layers in the stack.
So arming the CQ is on hot datapath.

-- 
MST
