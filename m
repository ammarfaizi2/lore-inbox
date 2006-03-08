Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWCHB5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWCHB5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWCHB5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:57:31 -0500
Received: from ns1.siteground.net ([207.218.208.2]:55722 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964846AbWCHB5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:57:30 -0500
Date: Tue, 7 Mar 2006 17:58:08 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: [patch 0/4] net: percpufy frequently used vars on struct proto
Message-ID: <20060308015808.GA9062@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patchset converts struct proto.memory_allocated to use batching
per-cpu counters, struct proto.sockets_allocated to use per-cpu counters and
changes the proto.inuse per-cpu variable to use alloc_percpu instead of the
NR_CPUS x cacheline size padding. 

We observed 5% improvement in apache bench requests per second with this 
patchset on a multi NIC 8 way IBM x460 box.

(This was posted earlier
http://marc.theaimsgroup.com/?l=linux-kernel&m=113830220408812&w=2 )

Can this go into -mm please?

Thanks,
Kiran

