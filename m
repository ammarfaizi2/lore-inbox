Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWJRPdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWJRPdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWJRPdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:33:39 -0400
Received: from web57803.mail.re3.yahoo.com ([68.142.236.81]:6541 "HELO
	web57803.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1161121AbWJRPdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:33:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0SzrNVPtObN6omcgQWwu8KrrUVkTEap5pfgryBJhTS1DmiPvlN8AGWSS51x1fF0SfVBY2BFlos4fGr/DD+nn44XtiMMFQOm7+lTjDKmdvTsII2szs8t4LmPPZB3NZePK5HfRtCYCM8vMTu57DlJ+NARnQwi4zf7gLUCAD5ywPI4=  ;
Message-ID: <20061018153337.39388.qmail@web57803.mail.re3.yahoo.com>
Date: Wed, 18 Oct 2006 08:33:37 -0700 (PDT)
From: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <453542EC.90509@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > eth6 is a NatSemi DP83815 NIC
> 
> Well... lot of changes in drivers/net/natsemi.c
> between 2.4 and 2.6
> 
> Previous versions had a max_interrupt_work = 20;
> RX_RING_SIZE is 32 for this NIC
> 
> But NAPI standard weight is 64, maybe you should try
> to lower it ? (so that an 
> interrupt dont try to queue/dequeue too many packets
> at once)
> 
> /proc/sys/net/core/dev_weight
> /proc/sys/net/core/netdev_budget

Eric,

Thanks for the suggestions, but I don't really
understand what you're saying.

Currently dev_weight is 64 and netdev_budget is 300. 
What do you recommend I set them to?



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
