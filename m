Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUBIQnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUBIQnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:43:31 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:16570 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265256AbUBIQna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:43:30 -0500
Date: Mon, 09 Feb 2004 08:43:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Timothy Miller <miller@techsource.com>,
       Nick Piggin <piggin@cyberone.com.au>
cc: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <144560000.1076344998@[10.10.2.4]>
In-Reply-To: <4027B758.8060908@techsource.com>
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay> <40242D14.6070908@cyberone.com.au> <4027B758.8060908@techsource.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can we keep current behaviour default, and if arches want to
>> override it they can? And if someone one day does testing to
>> show it really isn't a good idea, then we can change the default.
>> 
>> I like to try stick to the fairness first approach.
>> 
>> We got quite a few complaints about unfairness when the
>> scheduler used to keep 2 on one cpu and 1 on another, even in
>> development kernels. I suspect that most wouldn't have known
>> one way or the other if only top showed 66% each, but still.
> 
> Stupid question:  Does the balancing consider process priority?  Is it 
> unfair to have two lower pri tasks always on one cpu while the highest 
> pri of the three is always by itself?

No, it doesn't take account of that. We've discussed that before at some 
point, and yes, I  think it's wrong, but on the other hand, we want to be 
reasonably fast at deciding what to take, and there are a whole bunch of 
other criteria that we ought to be taking account as well - it's difficult.

M.

