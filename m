Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWISRAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWISRAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWISRAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:00:50 -0400
Received: from dvhart.com ([64.146.134.43]:14310 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030298AbWISRAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:00:49 -0400
Message-ID: <45102240.7040100@mbligh.org>
Date: Tue, 19 Sep 2006 10:00:48 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-rc7-mm1
References: <20060919012848.4482666d.akpm@osdl.org>	<45100272.505@mbligh.org> <20060919093122.d8923263.akpm@osdl.org>
In-Reply-To: <20060919093122.d8923263.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 19 Sep 2006 07:45:06 -0700
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
> 
>>>- It took maybe ten hours solid work to get this dogpile vaguely
>>>  compiling and limping to a login prompt on x86, x86_64 and powerpc. 
>>>  I guess it's worth briefly testing if you're keen.
>>
>>PPC64 blades shit themselves in a strange way. Possibly the udev
>>breakage you mentioned? Hard to tell really if people are going to
>>go around breaking userspace compatibility ;-(
> 
> 
> What version of udev is it running?
> 
> 
>>http://test.kernel.org/abat/48127/debug/console.log
>>
>>..
>>
>>sda: Write Protect is off
>>sda: cache data unavailable
>>sda: assuming drive cache: write through
>>SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
>>sda: Write Protect is off
>>sda: cache data unavailable
>>sda: assuming drive cache: write through
>>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
>>sd 0:0:1:0: Attached scsi disk sda
>>creating device nodes .[: [0-9]*: bad number
>>0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>>0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>>[: [0-9]*: bad number
>>0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>>0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>>[: [0-9]*: bad number
>>0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>>0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>>[: [0-9]*: bad number
>>0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>>0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>>[: [0-9]*: bad number
>>
>>
> 
> 
> That all looks rather bad.
> 
> 
>>ReiserFS: sda2: Using r5 hash to sort names
>>looking for init ...
>>found /sbin/init
>>/init: cannot open .//dev//console: no such file
> 
> 
> Bizarrely-formed pathname.  Does it always do that?


Working one (-git3): http://test.kernel.org/abat/48064/debug/console.log

Same sgio shit. no mention of /dev/console, but it's an error message,
so not unexpected.

> Has udev actually attempted to do anything by this stage?

Buggered if I know. I always just turn it off on my machines.

> I wasn't seeing anything that spectacular.  It used to be the case that
> udev simply hung.  But in rc7-mm1 the symptoms are that incoming ssh
> sessions hang, but most other things work OK.
> 
> Oh well - Greg has split that tree apart and I shall not be pulling the
> more problematic bits henceforth.

OK, may not be that at all ... could be something entirely different.
Just seemed co-incicental to your comments.

M.
