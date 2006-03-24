Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWCXS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWCXS1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWCXS1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:27:17 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:53881 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932534AbWCXS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:27:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bt+0ggZmmPs3xHpiQWX9K5ody//9Ciz54OsaUpvOzwb+iuBTlQDhHCfjiCl4PMU0p2ehuWTkvQ+QJLTD9aqpJ7X4Vrh7IgQVdM84h9PceBtdR36ezmOMMYiIacxshKH+xaIQbhGv2qG2lY132VcFV4gEYVWFq1wCvd4PoOrKxAI=  ;
Message-ID: <442424FF.3090405@yahoo.com.au>
Date: Sat, 25 Mar 2006 03:57:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced
 mlock-LRU semantic
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>	 <441FEF8D.7090905@yahoo.com.au> <bc56f2f0603240705y3b4abe3ej@mail.gmail.com>
In-Reply-To: <bc56f2f0603240705y3b4abe3ej@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> 2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:

>>In what way are we not now posix compliant now?
> 
> 
> Currently, Linux's mlock for example, may fail with  only part of its
> task finished.
> 
> While accroding to POSIX definition:
> 
> man mlock(2)
> 
> "
> RETURN VALUE
>        On success, mlock returns zero.  On error, -1 is returned, errno is set
>        appropriately, and no changes are made to  any  locks  in  the  address
>        space of the process.
> "
> 

Looks like you're right, so good catch. You should probably try to submit your
posix mlock patch by itself then. Make sure you look at the coding standards
though, and try to _really_ follow coding conventions of the file you're
modifying.

You also should make sure the patch works standalone (ie. not just as part of
a set). Oh, and introducing a new field in vma for a flag is probably not the
best option if you still have room in the vm_flags field.

And the patch changelog should contain the actual problem, and quote the
relevant part of the POSIX definition, if applicable.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
