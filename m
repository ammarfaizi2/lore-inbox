Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274884AbTHKWwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274885AbTHKWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:52:49 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:29956 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S274884AbTHKWws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:52:48 -0400
Message-ID: <3F38218C.5010407@techsource.com>
Date: Mon, 11 Aug 2003 19:06:52 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Neakums <sneakums@zork.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: NULL.  Again.  (was Re: [PATCH] 2.4.22pre10: {,un}likely_p())
References: <1060087479.796.50.camel@cube>	<20030809002117.GB26375@mail.jlokier.co.uk>	<20030809081346.GC29616@alpha.home.local>	<20030809015142.56190015.davem@redhat.com>	<1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk>	<20030809162332.GB29647@mail.jlokier.co.uk>	<20030809173001.GG24349@perlsupport.com> <6ufzkad8w1.fsf@zork.zork.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sean Neakums wrote:
> Chip Salzenberg <chip@pobox.com> writes:
> 
> 
>>According to Jamie Lokier:
>>
>>>Not just K&R.  These are different because of varargs:
>>>	printf ("%p", NULL);
>>>	printf ("%p", 0);
>>
>>*SIGH*  I thought incorrect folk wisdom about NULL and zero and pointer
>>conversions had long since died out.  More fool I.  Please, *please*,
>>_no_one_else_ argue about NULL/zero/false etc. until after reading this:
>>
>>  ===[[  http://www.eskimo.com/~scs/C-faq/s5.html  ]]===
>>
>>I thank you, and linux users everywhere thank you.
> 
> 
> I had thought that the need for writing NULL where a pointer is
> expected in varags functions was because the machine may have
> different sizes for pointers and int.  In the case of the second
> printf call above, if pointers are 64-bit and integers are 32-bit,
> printf will read eight bytes from the stack, and only four will have
> been occupied by the integer 0.
> 

Yes, but you're leaving information out.  If you read the FAQ, you'll 
find that NULL would not be the right thing to use in some cases.  For 
instance, (char *)0 may be a different value from (void *)0, so it's 
best to cast the pointer when passing to printf or something which uses 
varargs.


