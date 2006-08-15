Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbWHOTCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbWHOTCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWHOTCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:02:04 -0400
Received: from spirit.analogic.com ([204.178.40.4]:26886 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1030460AbWHOTCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:02:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 Aug 2006 19:01:59.0239 (UTC) FILETIME=[48EAE570:01C6C09D]
Content-class: urn:content-classes:message
Subject: Re: Maximum number of processes in Linux
Date: Tue, 15 Aug 2006 15:01:58 -0400
Message-ID: <Pine.LNX.4.61.0608151501070.24785@chaos.analogic.com>
In-Reply-To: <20060815182219.GL8776@1wt.eu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Maximum number of processes in Linux
thread-index: AcbAnUj0SSi217RsSh6/h/q+o0Uscg==
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com> <20060815182219.GL8776@1wt.eu>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Irfan Habib" <irfan.habib@gmail.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Aug 2006, Willy Tarreau wrote:

> On Tue, Aug 15, 2006 at 02:22:02PM -0400, linux-os (Dick Johnson) wrote:
>>
>> On Tue, 15 Aug 2006, Irfan Habib wrote:
>>
>>> Hi,
>>>
>>> What is the maximum number of process which can run simultaneously in
>>> linux? I need to create an application which requires 40,000 threads.
>>> I was testing with far fewer numbers than that, I was getting
>>> exceptions in pthread_create
>>>
>>> Regards
>>> Irfan
>>
>> #include <stdio.h>
>> int main(){
>>      unsigned long i;
>       ^^^^^^^^^^^^^^^^
>
>>      while(fork() != -1)
>>          i++;
>>      printf("%u\n", i);
>>      return 0;
>> }
>> $ gcc -o xxx xxx.c
>> $ ./xxx
>>
>> 1251392833         <<---- At least this number
>
> Dick, would you please initialize your local variables when you send
> examples like this ? You should have been amazed by one billion processes
> on your box, at least.

Yep. I discovered it just as I hit the ^X button!


>
>> 1251392834
>> 1251392834
>> 1251392834
>> 1251392834
>> 1251392833
>> 1251392833
>> 1251392834
>> 1251392834
>> 1251392834
>> ^C
>> $ killall xxx
>>
>> BYW 40,000 threads? 40,000 tasks all sharing the same address space?
>> Hopefully this is just a training exercise to see if it's possible.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
>> New book: http://www.AbominableFirebug.com/
>
> Regards,
> Willy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
