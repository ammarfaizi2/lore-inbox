Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSKUAUv>; Wed, 20 Nov 2002 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266121AbSKUAUu>; Wed, 20 Nov 2002 19:20:50 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:10234 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S266041AbSKUAUr>; Wed, 20 Nov 2002 19:20:47 -0500
Message-ID: <3DDC28E2.30404@mvista.com>
Date: Wed, 20 Nov 2002 17:29:22 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>	<3DDBC0D9.5030904@mvista.com> <15836.8031.649441.843857@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Neil Brown wrote:

>On Wednesday November 20, sdake@mvista.com wrote:
>  
>
>>Neil,
>>
>>I would suggest adding a 64 bit field called "unique_identifier" to the 
>>per-device structure.  This would allow a RAID volume to be locked to a 
>>specific host, allowing the ability for true multihost operation.
>>    
>>
>
>You seem to want a uniq id in 'per device' which will identify the
>'volume'.
>That doesn't make sense to me so maybe I am missing something.
>If you want to identify the 'volume', you put some sort of id in the
>'per-volume' data structure.
>
>This is what the 'name' field is for.
>  
>
This is useful, atleast in the current raid implementation, because 
md_import can be changed to return an error if the device's unique 
identifier doesn't match the host identifier.  In this way, each device 
of a RAID volume is individually locked to the specific host, and 
rejection occurs at import of the device time.

Perhaps locking using the name field would work except that other 
userspace applications may reuse that name field for some other purpose, 
not providing any kind of uniqueness.

Thanks for the explination of how the name field was intended to be used.

-steve


