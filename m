Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWHUN1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWHUN1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWHUN1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:27:55 -0400
Received: from roadrunner-base.egenera.com ([63.160.166.46]:4234 "EHLO
	roadrunner-base.egenera.com") by vger.kernel.org with ESMTP
	id S1751875AbWHUN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:27:54 -0400
Date: Mon, 21 Aug 2006 09:27:17 -0400
From: "Philip R. Auld" <pauld@egenera.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, riel@redhat.com, tgraf@suug.ch,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-ID: <20060821132717.GD26589@vienna.egenera.com>
References: <1155530453.5696.98.camel@twins> <20060813215853.0ed0e973.akpm@osdl.org> <44E3E964.8010602@google.com> <20060816225726.3622cab1.akpm@osdl.org> <44E5015D.80606@google.com> <20060817230556.7d16498e.akpm@osdl.org> <44E62F7F.7010901@google.com> <20060818153455.2a3f2bcb.akpm@osdl.org> <44E650C1.80608@google.com> <20060818194435.25bacee0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818194435.25bacee0.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Rumor has it that on Fri, Aug 18, 2006 at 07:44:35PM -0700 Andrew Morton said:
> On Fri, 18 Aug 2006 16:44:01 -0700
> Daniel Phillips <phillips@google.com> wrote:
> 
> - We expect that the lots-of-dirty-anon-memory-over-swap-over-network
>   scenario might still cause deadlocks.  
> 
>   I assert that this can be solved by putting swap on local disks.  Peter
>   asserts that this isn't acceptable due to disk unreliability.  I point
>   out that local disk reliability can be increased via MD, all goes quiet.

Putting swap on local disks really messes up the concept of stateless 
servers. I suppose you can do some sort of swap encryption, but
otherwise you need to scrub the swap partition on boot if you
re-purpose the hardware. You also then need to do hardware
configuration to make sure the local disks are all setup the 
same way across all server platforms so the common images can 
boot. 

Please don't require a hardware solution to a software problem.

> 
>   A good exposition which helps us to understand whether and why a
>   significant proportion of the target user base still wishes to do
>   swap-over-network would be useful.
> 

I can't claim to represent a significant proportion of the target 
user base. However, stateless hardware is a powerful and useful
model. 


Cheers,

Phil

-- 
Philip R. Auld, Ph.D.  	        	       Egenera, Inc.    
Software Architect                            165 Forest St.
(508) 858-2628                            Marlboro, MA 01752
