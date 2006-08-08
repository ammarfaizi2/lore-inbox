Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWHHU3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWHHU3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWHHU3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:29:39 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:30347 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S932227AbWHHU3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:29:38 -0400
Date: Tue, 8 Aug 2006 13:31:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: [RFC] NUMA futex hashing
Message-ID: <20060808203120.GA3762@localhost.localdomain>
References: <20060808070708.GA3931@localhost.localdomain> <200608081114.50256.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608081114.50256.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 11:14:49AM +0200, Eric Dumazet wrote:
> On Tuesday 08 August 2006 09:07, Ravikiran G Thirumalai wrote:
> >
> 
> Your patch seems fine, but I have one comment.
> 
> For non NUMA machine, we would have one useless indirection to get the 
> futex_queues pointer.
> 
> static struct futex_hash_bucket *futex_queues[1];
> 
> I think it is worth to redesign your patch so that this extra-indirection is 
> needed only for NUMA machines.

Yes.  Will do in the next iteration.

Thanks,
Kiran
