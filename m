Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWBGB0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWBGB0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBGB0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:26:24 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:42369 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932132AbWBGB0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:26:24 -0500
Message-ID: <43E7F73E.2070004@comcast.net>
Date: Mon, 06 Feb 2006 20:26:22 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net>	 <43E3D103.70505@comcast.net>	 <Pine.LNX.4.58.0602060836520.1309@shark.he.net>	 <43E7A4C0.4020209@t-online.de> <1139255800.10437.51.camel@localhost.localdomain> <43E805D4.5010602@comcast.net>
In-Reply-To: <43E805D4.5010602@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.16-rc2 with the libata patch alan cox provided resulted in a system 
which correctly found my atapi drive on the pata bus.  

Also, moving from the mm kernels to 2.6.16-rc2 resulted in my pm timer 
working again. 

So, it may have been all along that libata had supported my atapi 
device, but either the patch when it got merged with mm became broken or 
something else in mm broke it, and something else in mm caused my pm 
timer to stop being used. 

Hopefully more people chime in with issues like this so the bug can be 
tracked down in mm before the offending code makes it's way to a regular 
release. 


Also just to note, the patch to 2.6.16-rc2 alan cox made switches the 
load order of pata and sata from mm, resulting in device name changes.  
I guess now is a good time to start making label'd mounting a priority 
in getting into actual use on my machine.


Ed Sweetman wrote:

> Alan Cox wrote:
>
>> On Llu, 2006-02-06 at 20:34 +0100, Harald Dunkel wrote:
>>  
>>
>>> how it is _supposed_ to work? Is there a conflict between
>>> ata_piix and piix/mpiix? A short summary could be very helpfull
>>> to identify problems, and to reduce confusion.
>>>   
>>
>>
>> MPIIX is totally different PCI identifiers so a different driver. It is
>> unrelated to any goings on here.
>>
>>  
>>
> Ok, but my nforce board works just fine with pata hdd's but doesn't 
> with atapi devices on the pata bus, which is what his message was in 
> reference to.   So forget about piix and such, how are you _supposed_ 
> to get atapi devices seen on the pata drivers (assuming they're 
> functioning at all on the pata drivers) so those that are testing 
> these drivers can make bug reports about them not working, instead of 
> just possibly getting the configuration wrong.
>
>
> No mention of atapi was made in the last patch / status report so i 
> take it You're under the assumption that atapi is _supposed_ to be 
> working in pata (at least the drives should be initialized and brought 
> up). 
>
> So if any info is needed, just mention what it is...  the drivers have 
> been rock solid so far for my sata and pata hdds. I'd like to continue 
> testing with the atapi drive detected because I can't have both ide 
> and pata drivers loaded at the same time, and switching between the 
> two changes device names around. -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

