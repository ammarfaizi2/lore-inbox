Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbTFSJug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbTFSJug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:50:36 -0400
Received: from dialup-221.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.221]:35334
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265745AbTFSJue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:50:34 -0400
Message-ID: <3EF18A1F.5050008@cyberone.com.au>
Date: Thu, 19 Jun 2003 20:02:07 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
 Windows!
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no> <bcrqq4$edi$1@cesium.transmeta.com> <3EF189D2.6080207@aitel.hist.no>
In-Reply-To: <3EF189D2.6080207@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:

> H. Peter Anvin wrote:
> [...]
>
>>> Whenever they quit one big app to run another big one,
>>> everything is pulled in from swap before the next
>>> big app start.  Then it starts, and push everything out
>>> again.  The current system lets you quit one app,
>>> the stuff in swap remains there until someone actually use it,
>>> and lots of free memory remain in case it is needed.
>>>
>>> The "intelligent" thing is to leave stuff in swap until
>>> some app needs it, and pull it in then.  Perhaps with
>>> some read-ahead/clustering to minimize io load.
>>>
>>
>>
>> This is why you pull things in from swap, but keep tabs on the fact
>> that it's clean against swap and therefore can be culled at will if
>> you don't need it.  In other words -- it's present *both* in swap and
>> RAM.
>
>
>
> Good point.
> The question is still what to pull in.  Stuff in swap
> is one option.  It has been used before, and might
> be needed again.
>
> Contents of memory mapped files (executables and others) are another.
> We can't know what we will need next, but at least the already opened
> files ought to be as likely as swap.
>
> Pulling other files into cache is a third option.  Going for open
> files (readahead) or recently used ones might be smart.
>
I think the pauses that desktop people notice and disagree to
is when mapped memory is paged out. If it is paged back in when
there is plenty of memory free, and ide disk, it might be useful
for a desktop load.


