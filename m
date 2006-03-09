Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWCIIWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWCIIWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 03:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWCIIWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 03:22:13 -0500
Received: from ns1.siteground.net ([207.218.208.2]:6576 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750918AbWCIIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 03:22:12 -0500
Date: Thu, 9 Mar 2006 00:22:51 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, bcrl@kvack.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       netdev@vger.kernel.org, shai@scalex86.org, Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060309082251.GB3599@localhost.localdomain>
References: <20060308203642.GZ5410@kvack.org> <20060308210726.GD4493@localhost.localdomain> <20060308211733.GA5410@kvack.org> <20060308222528.GE4493@localhost.localdomain> <20060308224140.GC5410@kvack.org> <20060308154321.0e779111.akpm@osdl.org> <20060309001803.GF4493@localhost.localdomain> <20060308163258.36f3bd79.akpm@osdl.org> <20060309080651.GA3599@localhost.localdomain> <440FE3E2.1060307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FE3E2.1060307@yahoo.com.au>
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

On Thu, Mar 09, 2006 at 07:14:26PM +1100, Nick Piggin wrote:
> Ravikiran G Thirumalai wrote:
> 
> >Here's a patch making x86_64 local_t to 64 bits like other 64 bit arches.
> >This keeps local_t unsigned long.  (We can change it to signed value 
> >along with other arches later in one go I guess) 
> >
> 
> Why not just keep naming and structure of interfaces consistent with
> atomic_t?
> 
> That would be signed and 32-bit. You then also have a local64_t.

No, local_t is supposed to be 64-bits on 64bits arches and 32 bit on 32 bit
arches.  x86_64 was the only exception, so this patch fixes that.

