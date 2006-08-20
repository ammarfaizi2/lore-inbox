Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWHTBdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWHTBdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbWHTBdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 21:33:39 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:47576 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S1751377AbWHTBdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 21:33:38 -0400
Message-ID: <44E7BBE5.1040600@tomt.net>
Date: Sun, 20 Aug 2006 03:33:25 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins>	<20060813215853.0ed0e973.akpm@osdl.org>	<44E3E964.8010602@google.com>	<20060816225726.3622cab1.akpm@osdl.org>	<44E5015D.80606@google.com>	<20060817230556.7d16498e.akpm@osdl.org>	<44E62F7F.7010901@google.com>	<20060818153455.2a3f2bcb.akpm@osdl.org>	<44E650C1.80608@google.com> <20060818194435.25bacee0.akpm@osdl.org> <44E728E2.4000804@redhat.com>
In-Reply-To: <44E728E2.4000804@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> Andrew Morton wrote:
>
>> - We expect that the lots-of-dirty-anon-memory-over-swap-over-network
>>   scenario might still cause deadlocks. 
>>   I assert that this can be solved by putting swap on local disks.  
>> Peter
>>   asserts that this isn't acceptable due to disk unreliability.  I point
>>   out that local disk reliability can be increased via MD, all goes 
>> quiet.
>>
>>   A good exposition which helps us to understand whether and why a
>>   significant proportion of the target user base still wishes to do
>>   swap-over-network would be useful.
>
> You cannot put disks in many models of blade servers.
>
> At all.

Or many thin clients in general. They are used in quite a few schools 
over here, running Linux.
Some of them do in fact have space for disks, but disks adds costs 
(heat, power, replacing failed drives)
