Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWAZS4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWAZS4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWAZS4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:56:45 -0500
Received: from ns1.siteground.net ([207.218.208.2]:21642 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964791AbWAZS4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:56:44 -0500
Date: Thu, 26 Jan 2006 10:56:49 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, shai@scalex86.org,
       netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: [patch 0/4] net: Percpufy frequently used variables on struct proto
Message-ID: <20060126185649.GB3651@localhost.localdomain>
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

The following patches change struct proto.memory_allocated,
proto.sockets_allocated to use per-cpu counters. This patchset also switches
the proto.inuse percpu varible to use alloc_percpu, instead of NR_CPUS *
cacheline size padding.

We saw 5 % improvement in apache bench requests per second with this
patchset, on a multi nic 8 way 3.3 GHZ IBM x460 Xeon server.  

Patches follow.

Thanks,
Kiran
