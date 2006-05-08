Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWEHFaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWEHFaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEHFaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:30:24 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:33458 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932312AbWEHFaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cBfZobAdDp1xdvNjjkALd9xoSEylKdEAg3an1FDYEtSzDjL935SETeYIBc4FmjiLt27UyeiJBTRzknr5eYJd9hLzGLoUg4JEiI6TFQ3wvhfw4iDy6eMQnlx1iRsVc4aOCUvuKgdYL7z9WGILgvSN/af8tXhHVQvB+8/YCkg3wz0=  ;
Message-ID: <445ED76B.3030701@yahoo.com.au>
Date: Mon, 08 May 2006 15:30:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk>	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>	 <1147023122.13315.16.camel@homer>  <1147061696.8544.12.camel@homer>	 <1147063063.8809.7.camel@homer>  <445ECD10.1090506@yahoo.com.au> <1147065899.8809.18.camel@homer>
In-Reply-To: <1147065899.8809.18.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

>On Mon, 2006-05-08 at 14:46 +1000, Nick Piggin wrote:
>
>>It should either get ripped out, or perhaps converted to use jiffies
>>until a sane high resolution, low overhead scheme is developed (if
>>ever). And that would exclude something that does this accounting in
>>fastpaths for the 99.99% of processes that never use it.
>>
>
>The accounting is really light compared to the interactivity part.  That
>doesn't need to be in the fast path, and in my tree it isn't.
>

And it is worse than useless if it is wrong.

>
>FWIW (0), yy tree is missing every last shred of the interactivity code,
>and not missing it one bit.
>

Join the club ;)

>
>[root@Homer]:> diffstat xx
> sched.c |  480
>+++++++++++++++++++++++++++++-----------------------------------
> 1 files changed, 219 insertions(+), 261 deletions(-)
>
>And that's with full throttling, and absolute starvation proofing.
>
>Ho hum.  Back to work on my never-going-anywhere-but-fun tree :)
>

Join the club ;)

Nah, the interactivity stuff isn't too bad (as a function of bug reports
to lkml). One day when there is nothing else wrong with the kernel, it will
probably end up getting reworked. No need to stir it up now though, really.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
