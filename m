Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271293AbUJVMrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271293AbUJVMrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271260AbUJVMqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:46:06 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:19073 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271300AbUJVMpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:45:17 -0400
Message-ID: <417900D6.4030902@yahoo.com.au>
Date: Fri, 22 Oct 2004 22:45:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
References: <20041021221622.GA11607@mail.muni.cz> <20041021225825.GA10844@electric-eye.fr.zoreil.com> <20041022025158.7737182c.akpm@osdl.org> <20041022120821.GA12619@mail.muni.cz>
In-Reply-To: <20041022120821.GA12619@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> On Fri, Oct 22, 2004 at 02:51:58AM -0700, Andrew Morton wrote:
> 
>>I'd be interested in knowing if this fixes it - I don't expect it will,
>>because that's a zero-order allocation failure.  He's really out of memory.
>>
>>The e1000 driver has a default rx ring size of 256 which seems a bit nutty:
>>a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
>>page allocator pools.
>>
>>Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.
> 
> 
> It did not help.
> 

What did you increase it to? What was the allocation failure message?
