Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUFQRUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUFQRUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUFQRUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:20:07 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:45738 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261156AbUFQRT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:19:59 -0400
Message-ID: <40D1D2F0.7080102@namesys.com>
Date: Thu, 17 Jun 2004 10:20:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Ken Ryan <linuxryan@leesburg-geeks.org>, linux-kernel@vger.kernel.org,
       pla@morecom.no
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40D1B110.7020409@leesburg-geeks.org> <40D1C18B.1030907@techsource.com>
In-Reply-To: <40D1C18B.1030907@techsource.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> Doesn't Reiser4 do wear-leveling for flash?

No, we don't.  We do have wandering logs, so it would be feasible to 
code, but bitmap blocks and super blocks get written to the same 
locations repeatedly.

Actually, most compact flash devices DO do wear leveling, from what I 
have heard.

>
> Ken Ryan wrote:
>
>>> > > > > Data integrity is much more important for us than speed.
>>> > > > > > You might want to consider ReiserFS or one of the others 
>>> which were > designed with journaling in mind.  And I hope you're 
>>> using RAID1 or RAID5.
>>>
>>> We are using ext3 on a compact flash disk in an embedded device. So we
>>> are not using RAID systems.
>>
>>
>>
>> [I'm not subscribed, hopefully this threads]
>>
>> Um, is this a new application or have you done this before?
>>
>> It's my understanding that very few (or no) CF devices do 
>> wear-levelling internally.
>> Using a journal, especially a true data journal, seems like *the* way 
>> to wear out your
>> flash as quickly as possible.
>>
>> If you've had success using ext2 in read/write mode on flash/CF in a 
>> shipping product,
>> I for one would like to know more details!
>>
>>         ken
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

