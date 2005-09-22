Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVIVNan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVIVNan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVIVNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:30:43 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:47794 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030313AbVIVNam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:30:42 -0400
Message-ID: <4332B1FF.8040202@cosmosbay.com>
Date: Thu, 22 Sep 2005 15:30:39 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com> <200509221503.21650.ak@suse.de>
In-Reply-To: <200509221503.21650.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 22 Sep 2005 15:30:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
>>1) No more central rwlock protecting each table (filter, nat, mangle, raw),
>>    but one lock per CPU. It avoids cache line ping pongs for each packet.
> 
> 
> Another useful change would be to not take the lock when there are no
> rules. Currently just loading iptables has a large overhead.
> 

Unfortunatly there are allways rules, after the loading of iptables, at least 
for the "packet_filter" table.

Eric
