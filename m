Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUD3Ge7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUD3Ge7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUD3Ge7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:34:59 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:2168 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265083AbUD3Ge5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:34:57 -0400
Message-ID: <4091F38C.3010400@yahoo.com.au>
Date: Fri, 30 Apr 2004 16:34:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
In-Reply-To: <slrn-0.9.7.4-14292-10175-200404301617-tc@hexane.ssi.swin.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:
> Horst von Brand <vonbrand@inf.utfsm.cl> said on Thu, 29 Apr 2004 16:01:11 -0400:
> 
>>Nick Piggin <nickpiggin@yahoo.com.au> said:
>>
>>[...]
>>
>>
>>>I don't know. What if you have some huge application that only
>>>runs once per day for 10 minutes? Do you want it to be consuming
>>>100MB of your memory for the other 23 hours and 50 minutes for
>>>no good reason?
>>
>>How on earth is the kernel supposed to know that for this one particular
>>job you don't care if it takes 3 hours instead of 10 minutes, just because
>>you don't want to spare enough preciousss RAM?
> 
> 
> Note that we are not talking about having insufficient memory. In my
> case (2.4 kernel - ie, 2.6 with swapiness 0%) there is more than
> enough memory to contain all my working set - it's only because cache
> is too eager to claim memory that is otherwise in use that
> non-optimalities occur.
> 

Well depends on what you mean by working set.

In our memory manager, there is a point where often used
"file cache" (ie. unmapped cache) is considered preferable
to unused or little used "application memory" (mapped
memory).

There will be a point where even the most swap phobic desktop
users will want to start swapping.

I missed the description of your exact problem... was it in
this thread somewhere? Testing 2.6 would be appreciated if
possible too.
