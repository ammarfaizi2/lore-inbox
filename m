Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWF2QXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWF2QXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWF2QXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:23:40 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:36479 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750868AbWF2QXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:23:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xflqNpLFEiYbQyyzXumyLiHmQHt99/I+K/7xyOXclOlxqYyvuxMoZ8rd2t1SWcgJqEr2XS97ULiQtCIb6XmvoZuQQM/bh9VMxPFhOlIYGClKk7jXAknA+JtBG7CTLEU1hg0ebLHY4xe7Ft4UHaNNizqlGCNS15AQolX5djh+uB0=  ;
Message-ID: <44A3FE3B.6070103@yahoo.com.au>
Date: Fri, 30 Jun 2006 02:22:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: nigel@suspend2.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 07/13] [Suspend2] Page_alloc paranoia.
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net> <20060627044248.15066.52507.stgit@nigel.suspend2.net> <44A0CC28.5030508@yahoo.com.au> <200606271634.43662.nigel@suspend2.net>
In-Reply-To: <200606271634.43662.nigel@suspend2.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 16:11, Nick Piggin wrote:
> 
>>Nigel Cunningham wrote:
>>
>>>Add paranoia to the page_alloc code to ensure we don't start page reclaim
>>>during suspending.
>>
>>Nack. Set PF_MEMALLOC if you must.
> 
> 
> That would work for the thread doing the suspending. What about other kernel 
> threads that might run and allocate memory during the cycle because of 
> $RANDOM_EVENT? We don't want them triggering memory freeing either.

Haven't you suspended the other threads at this point?

What are the consequences of allocating memory?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
