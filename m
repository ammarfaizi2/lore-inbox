Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFDC3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFDC3G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFDC3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:29:06 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:52142 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261186AbVFDC3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:29:02 -0400
Message-ID: <42A111DF.8070806@yahoo.com.au>
Date: Sat, 04 Jun 2005 12:28:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Subrahmanyam Ongole <songole@gmail.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64: Kernel with large page size
References: <a8447f24050603175061598809@mail.gmail.com> <20050604005930.GA31508@holomorphy.com>
In-Reply-To: <20050604005930.GA31508@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, Jun 03, 2005 at 05:50:55PM -0700, Subrahmanyam Ongole wrote:
> 
>>When we run our application on AMD Opteron processors, we are seeing a
>>large number of   L1_AND_L2_DTLB_MISSES. We used oprofile to measure
>>these numbers.
[...]

> 
> 
> PAGE_SIZE at the moment is intimately tied to the MMU's notions of
> address translation, which are determined by hardware.
> 

And even if we were able to increase the PAGE_SIZE that
the kernel uses, this wouldn't really help your TLB misses.

You may be able to use "huge pages" for your workload, which
can use the 2/4MB pages. There is some good documentation for
it in Documentation/vm/ (and probably on the web).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
