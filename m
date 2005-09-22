Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVIVPvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVIVPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIVPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:51:25 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:61600 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030417AbVIVPvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:51:24 -0400
Message-ID: <4332D2D9.7090802@cosmosbay.com>
Date: Thu, 22 Sep 2005 17:50:49 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de> <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 22 Sep 2005 17:50:50 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter a écrit :
> 
> It should really be do_set_mempolicy instead to be cleaner. I got a patch 
> here that fixes the policy layer.
> 
> But still I agree with Christoph that a real vmalloc_node is better. There 
> will be no fuzzing around with memory policies etc and its certainly 
> better performance wise.

vmalloc_node() should be seldom used, at driver init, or when a new ip_tables 
is loaded. If it happens to be a performance problem, then we can optimize it.
Why should we spend days of work for a function that is yet to be used ?

Eric

