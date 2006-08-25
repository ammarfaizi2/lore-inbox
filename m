Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWHYPO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWHYPO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHYPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:14:40 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:54877 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964910AbWHYPOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:14:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zbm+XlFh7tpwRxoCKQ6rbf1EdEVzGk59V3mZadISPfI7SpaR/pzvcd+iLsa8EVeN6OgzXkfWSl/iOrli/7RlTZgNXt5miBLPWfgnwU1sZMQlZ+F/+HPLCBn0+0R9TXk+eoGxnUtmvikDs4wLXo8xg0GVh/7r+FAQEA7lB67oxWM=  ;
Message-ID: <44EF13BB.9030406@yahoo.com.au>
Date: Sat, 26 Aug 2006 01:14:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH] BC: resource beancounters (v2)
References: <44EC31FB.2050002@sw.ru>	<20060823100532.459da50a.akpm@osdl.org>	<44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
In-Reply-To: <20060825073003.e6b5ae16.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 25 Aug 2006 15:49:15 +0400
> Kirill Korotaev <dev@sw.ru> wrote:
> 
> 
>>>We need to go over this work before we can commit to the BC
>>>core.  Last time I looked at the VM accounting patch it
>>>seemed rather unpleasing from a maintainability POV.
>>
>>hmmm... in which regard?
> 
> 
> Little changes all over the MM code which might get accidentally broken.

I still think doing simple accounting per-page would be a better way to
go than trying to pin down all "user allocatable" kernel allocations.
And would require all of about 2 hooks in the page allocator. And would
track *actual* RAM allocated by that container.

Can we continue that discussion (ie. why it isn't good enough). Last I
was told it is not perfect and can be unfair... sounds like it fits the
semantics perfectly ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
