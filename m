Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWA1AkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWA1AkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWA1AkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:40:25 -0500
Received: from ns1.siteground.net ([207.218.208.2]:59582 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030209AbWA1AkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:40:24 -0500
Date: Fri, 27 Jan 2006 16:40:27 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060128004027.GE3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <43DA9EFF.1020200@cosmosbay.com> <20060127225036.GC3565@localhost.localdomain> <43DAAAE3.2030107@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DAAAE3.2030107@cosmosbay.com>
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

On Sat, Jan 28, 2006 at 12:21:07AM +0100, Eric Dumazet wrote:
> Ravikiran G Thirumalai a écrit :
> >On Fri, Jan 27, 2006 at 11:30:23PM +0100, Eric Dumazet wrote:
> 
> Why not use a boot time allocated percpu area (as done today in 
> setup_per_cpu_areas()), but instead of reserving extra space for module's 
> percpu data, being able to serve alloc_percpu() from this reserved area (ie 
> no kmalloced data anymore), and keeping your

At that time ia64 placed a limit on the max size of per-CPU area 
(PERCPU_ENOUGH_ROOM).  I think that the limit is still there, But hopefully
64K per-CPU should be enough for static + dynamic + modules?

Let me do a allyesconfig on my box and verify.

Thanks,
Kiran
