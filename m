Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269783AbUHZX2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbUHZX2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269762AbUHZXZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:25:41 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57261 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269681AbUHZXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:23:48 -0400
Date: Fri, 27 Aug 2004 08:28:56 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
In-reply-to: <1093561869.2984.360.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
Message-id: <412E7238.8060601@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <412DD1AA.8080408@jp.fujitsu.com>
 <1093535402.2984.11.camel@nighthawk> <412E6CC3.8060908@jp.fujitsu.com>
 <1093561869.2984.360.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Hansen wrote:

> On Thu, 2004-08-26 at 16:05, Hiroyuki KAMEZAWA wrote:
> 
>>I understand using these macros cleans up codes as I used them in my previous
>>version.
>>
>>In the previous version, I used SetPagePrivate()/ClearPagePrivate()/PagePrivate().
>>But these are "atomic" operation and looks very slow.
>>This is why I doesn't used these macros in this version.
>>
>>My previous version, which used set_bit/test_bit/clear_bit, shows very bad performance
>>on my test, and I replaced it.
>>
>>If I made a mistake on measuring the performance and set_bit/test_bit/clear_bit
>>is faster than what I think, I'd like to replace them.
> 
> 
> Sorry, I misread your comment:
> 
> /* Atomic operation is needless here */
> 
> I read "needless" as "needed".  Would it make any more sense to you to
> say "already have lock, don't need atomic ops", instead?
> 
Thanks. I'm not so good at writing good comment, as you know :).
I'll rewrite it.


-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

