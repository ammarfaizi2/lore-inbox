Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274979AbTHGBxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275025AbTHGBxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:53:13 -0400
Received: from [81.193.97.12] ([81.193.97.12]:19328 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S274979AbTHGBxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:53:11 -0400
Message-ID: <3F31B1A1.7070402@toxyn.org>
Date: Thu, 07 Aug 2003 02:55:45 +0100
From: RaTao <ratao@toxyn.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Daniel McNeil <daniel@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.0-test2-mm4 O_DIRECT
References: <3F30CFC1.1090205@toxyn.org>	 <20030806121759.50a48626.akpm@osdl.org>  <3F3173D5.8000705@toxyn.org> <1060209414.1903.7.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1060209414.1903.7.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Daniel!

Just recompiled test2-mm4 and I tested it with:

time iozone -f hello.data -i 0 -s 50000 -r 1 -I

(-I enables O_DIRECT, I straced it and fopen has O_DIRECT flag)

and everything works great! My app is working too!! I can't understand 
it but everything is fine, now.

I'm sorry for wasting your time :(

Thanks,
Ratao

Daniel McNeil wrote:
> O_DIRECT also works for me on ext3 using regular write and async i/o
> using 512-byte i/o.
> 
> Is your buffer alignment correct?
> O_DIRECT requires a 512-byte aligned buffer.
> 
> Daniel
> On Wed, 2003-08-06 at 14:32, RaTao wrote:
> 
>>Hi!
>>
>>I've correct my (don't know how) misspelled subject :)
>>
>>Andrew Morton wrote:
>>
>>[..snip..]
>>
>>>
>>>It works OK here.
>>>
>>>
>>>
>>>>- vmstat doesn't show bi/bo for O_DIRECT's disk access.
>>>
>>>
>>>It does here.
>>>
>>
>>Maybe goofed somewhere. I can't test it again today, I'll do it tomorrow.
>>
>>
>>
>>>I'd be suspecting your test app: is it checking the return value of all
>>>syscalls?
>>
>>I'll double check.
>>Thanks,
>>
>>Ratao
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

