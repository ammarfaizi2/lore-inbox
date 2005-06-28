Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVF1GZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVF1GZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVF1GZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:25:02 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:4229 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261971AbVF1Fev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:34:51 -0400
Message-ID: <42C0E173.30406@yahoo.com.au>
Date: Tue, 28 Jun 2005 15:34:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2] mm: speculative get_page
References: <42C0AAF8.5090700@yahoo.com.au>	<20050628040608.GQ3334@holomorphy.com>	<42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net>
In-Reply-To: <20050627.220827.21920197.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>From: Nick Piggin <nickpiggin@yahoo.com.au>
>Subject: Re: [patch 2] mm: speculative get_page
>Date: Tue, 28 Jun 2005 14:50:31 +1000
>
>
>>William Lee Irwin III wrote:
>>
>>
>>>On Tue, Jun 28, 2005 at 11:42:16AM +1000, Nick Piggin wrote:
>>>
>>>spin_unlock() does not imply a memory barrier.
>>>
>>>
>>Intriguing...
>>
>
>BTW, I disagree with this assertion.  spin_unlock() does imply a
>memory barrier.
>
>All memory operations before the release of the lock must execute
>before the lock release memory operation is globally visible.
>

Yes, it appears that way from looking at a sample set of arch
code too (ie. those without strictly ordered stores put an
explicit barrier there).

I've always understood spin_unlock to imply a barrier.


Send instant messages to your online friends http://au.messenger.yahoo.com 
