Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWGINkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWGINkI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbWGINkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:40:07 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:12889 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030510AbWGINkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:40:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lm4LEw3eucHGVgPqt6tamFUQTVNOknoT9bPuGEuFdXbCrhgpJmAgkPRXF4Llu9gfnNoEZRiZssWFVZyt5WXt+T9PzNiAl/FI2+0oFRN4uigi4e3F2TVpB2adNciDBzU9Tw7y2mFH9rnVvAqapBZrR86iT8AFe3AekU5vVoVxhwM=  ;
Message-ID: <44B0F0AA.20708@yahoo.com.au>
Date: Sun, 09 Jul 2006 22:03:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Abu M. Muttalib" <abum@aftek.com>, Robert Hancock <hancockr@shaw.ca>,
       chase.venters@clientec.com, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
References: <BKEKJNIHLJDCFGDBOHGMAEFDDCAA.abum@aftek.com> <1152446997.27368.52.camel@localhost.localdomain>
In-Reply-To: <1152446997.27368.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Sul, 2006-07-09 am 17:18 +0530, ysgrifennodd Abu M. Muttalib:
> 
>>but I am running the application on an embedded device and have no swap..
>>what do I need to do in this case??
> 
> 
> Use less memory ?

Abu, I guess you have turned on CONFIG_EMBEDDED and disabled everything
you don't need, turned off full sized data structures, removed everything
else you don't need from the kernel config, turned off kernel debugging
(especially slab debugging).

If you still have problems, what does /proc/slabinfo tell you when running
your application under both 2.4 and 2.6?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
