Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHAXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHAXyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWHAXyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:54:15 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:17750 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750790AbWHAXyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:54:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gXWr2BmaQnvPETaV9G1jWtS+b9Ola11HLFU6Eqr60eWSvj06FKXBg7RruOE19k2l5kNz3smjmjp+7o8qStUqTm1xEn640heRey+0s6+spBK5Or+foLJKlfWEYL386W+epo7zNZi227BdnpN281Rvbw7iZ3UlBCfEXpneF/6OI4s=  ;
Message-ID: <44CFE98D.2060901@yahoo.com.au>
Date: Wed, 02 Aug 2006 09:53:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Dave Kleikamp <shaggy@austin.ibm.com>, Nick Piggin <npiggin@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] mm: speculative get_page
References: <20060801193203.GA191@oleg> <1154447729.10401.16.camel@kleikamp.austin.ibm.com> <20060801204202.GA223@oleg>
In-Reply-To: <20060801204202.GA223@oleg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 08/01, Dave Kleikamp wrote:

>>Isn't the page locked when calling remove_mapping()?  It looks like
>>SetPageNoNewRefs & ClearPageNoNewRefs are called in safe places.  Either
>>the page is locked, or it's newly allocated.  I could have missed
>>something, though.
> 
> 
> No, I think it is I who missed something, thanks.

Yeah, SetPageNoNewRefs is indeed called only under PageLocked or for
newly allocated pages. I should make a note about that, as it isn't
immediately clear.

Thanks

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
