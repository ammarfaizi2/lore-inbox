Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWEYEvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWEYEvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWEYEvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:51:05 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:28058 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965031AbWEYEvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:51:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mchfl58mReDH4CfbwHTtomNHscnU8FRQsEFP6Z52kTqfqQ1MmcdLgu2e6xuzvaEQ/vPgzaaGhTOrUAdJY/bVodyj3INVwZ2JY6huMdaiAuqtYfUzH8mgQkQFmzDRXlBUBgIXXjAzDXPbyS5Hq/NlfQZhrHWQ+0iKaVrc3AEPXRk=  ;
Message-ID: <447537B3.7050707@yahoo.com.au>
Date: Thu, 25 May 2006 14:50:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/33] readahead: min/max sizes
References: <20060524111246.420010595@localhost.localdomain> <348469541.17438@ustc.edu.cn>
In-Reply-To: <348469541.17438@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:

>- Enlarge VM_MAX_READAHEAD to 1024 if new read-ahead code is compiled in.
>  This value is no longer tightly coupled with the thrashing problem,
>  therefore constrained by it. The adaptive read-ahead logic merely takes
>  it as an upper bound, and will not stick to it under memory pressure.
>

I guess this size enlargement is one of the main reasons your
patchset improves performance in some cases.

There is currently some sort of thrashing protection in there.
Obviously you've found it to be unable to cope with some situations
and introduced a lot of really fancy stuff to fix it. Are these just
academic access patterns, or do you have real test cases that
demonstrate this failure (ie. can we try to incrementally improve
the current logic as well as work towards merging your readahead
rewrite?)

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
