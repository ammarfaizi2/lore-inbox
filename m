Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWEIQsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEIQsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWEIQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:48:38 -0400
Received: from [194.90.237.34] ([194.90.237.34]:59867 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1750712AbWEIQsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:48:37 -0400
Date: Tue, 9 May 2006 19:49:19 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: Heiko J Schick <schihei@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [PATCH 07/16] ehca: interrupt handling routines
Message-ID: <20060509164919.GC5063@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com> <445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com> <44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adalktbcgl1.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 09 May 2006 16:52:19.0031 (UTC) FILETIME=[EF11DE70:01C67388]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> The trivial way to do it would be to use the same idea as the current
> ehca driver: just create a thread for receive CQ events and a thread
> for send CQ events, and defer CQ polling into those two threads.

For RX, isn't this basically what NAPI is doing?
Only NAPI seems better, avoiding interrupts completely and avoiding latency hit
by only getting triggered on high load ...

-- 
MST
