Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBAC6P>; Wed, 31 Jan 2001 21:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbRBAC55>; Wed, 31 Jan 2001 21:57:57 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:63694 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129250AbRBAC5u>;
	Wed, 31 Jan 2001 21:57:50 -0500
Message-ID: <3A78D0A1.9070100@lycosmail.com>
Date: Wed, 31 Jan 2001 21:57:37 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFC7@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunlap, Randy wrote:

>> From: Adam Schrotenboer [mailto:ajschrotenboer@lycosmail.com]
>> 
>>> On Wed, 31 Jan 2001 10:01:08 -0500, Adam Schrotenboer wrote:
>>> 
>>>>> On Tue, 30 Jan 2001 23:25:22 -0500, Adam Schrotenboer wrote:
>>>>> 
>>>>>> ...
>>>>>> Linux version 2.4.1 (root@tabriel) (gcc version egcs-2.91.66 
>>>>> 
>>>> 19990314/Linux (egcs-1.1.2 release)) #9 Tue Jan 30 
>>> 
>> 15:35:21 EST 2001
>> 
>>>>>> BIOS-provided physical RAM map:
>>>>>> BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
>>>>>> BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
>>>>>> On node 0 totalpages: 16624
>>>>> 
>>>> ...
>>>> Linux version 2.4.0 (root@tabriel) (gcc version 
>>> 
>> pgcc-2.95.2 19991024 (release)) #2 Mon Jan 8 09:02:27 EST 2001
>> 
>>>> BIOS-provided physical RAM map:
>>>> BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>>>> BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
>>>> BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
>>>> BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
>>>> BIOS-e820: 000000000bef0000 @ 0000000000100000 (usable)
>>>> BIOS-e820: 000000000000d000 @ 000000000bff3000 (ACPI data)
>>>> BIOS-e820: 0000000000003000 @ 000000000bff0000 (ACPI NVS)
>>>> On node 0 totalpages: 49136
>>> 
>> It did it again. fresh tree, egcs 1.1.2, etc
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Different versions of gcc were used on 2.4.0 vs. 2.4.1.
> Were different versions of as also used?  (hint?)
> 
> Or somehow in linux/arch/i386/boot/setup.S, your source
> file has
> #define STANDARD_MEMORY_BIOS_CALL
> ?
> 
> ~Randy  /  503-677-5408
> 
granted, it is possible that a different gas was used, but extremely 
unlikely. I have been known to build my own compilers (need to try libc 
some time), but haven't played around w/ binutils. box is Redhat 6.[01]? 
upped to Mandrake 7.1 a month ago.

haven't installed any new compilers lately, I think that 2.4.1 makefile 
is different, selects diff compiler (haven't found out the differences 
btwn Mandrake and RedHat yet)

grepped sources for that #define; did not find anywhere

Sorry for bad grammar, usually not this bad, very very tired, can't make 
fingers type straight half the time.

currently running 2.4.1 rebuilt with mem=192M. Hope this is resolved soon.
Also will consider trying to specify compiler to be same as 2.4.0 build 
(not likely a good idea, given that pgcc 2.95.x borks 2.4.1 
[fxsr_alignment IIRC])

Also will look for different as executables. BTW, pgcc above is actually 
2.95.3, not 2.95.2

I'm rambling and need sleep.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
