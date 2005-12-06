Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVLFFsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLFFsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVLFFsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:48:19 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:10644 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964784AbVLFFsT (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 6 Dec 2005 00:48:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Lhs2fj99me9s8gmNMPwwMwiS1tklJsddC+8zYX2uF6cLVkBrgV9fAp0Sf6pZuat2X8kGtYpEhtkhOa0D2z8YxYPAZry/n9hlq2o4dj4bdXjuu0sPJfosTGZZDyTztQ+h69EFpQHfcby4pfbY5Ue+mwgoRmnpeLhWdNlhzjIrsIw=  ;
Message-ID: <4395261C.8000907@yahoo.com.au>
Date: Tue, 06 Dec 2005 16:48:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Linux-Kernel@vger.kernel.org, linux-mm@kvack.org, paul.mckenney@us.ibm.com,
       wfg@mail.ustc.edu.cn
Subject: Re: [RFC] lockless radix tree readside
References: <4394EC28.8050304@yahoo.com.au> <20051205.191153.19905732.davem@davemloft.net>
In-Reply-To: <20051205.191153.19905732.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Tue, 06 Dec 2005 12:40:56 +1100
> 
> 
>>I realise that radix-tree.c isn't a trivial bit of code so I don't
>>expect reviews to be forthcoming, but if anyone had some spare time
>>to glance over it that would be great.
> 
> 
> I went over this a few times and didn't find any obvious
> problems with the RCU aspect of this.
> 

Thanks!

> 
>>Is my given detail of the implementation clear? Sufficient? Would
>>diagrams be helpful?
> 
> 
> If I were to suggest an ascii diagram for a comment, it would be
> one which would show the height invariant this patch takes advantage
> of.
> 

I'll see if I can make something reasonably descriptive. And possibly
another diagram to show the node insertion concurrency cases vs lookup.
These things are the main concepts to understand, so I agree diagrams
might be helpful.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
