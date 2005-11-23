Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVKWPAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVKWPAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVKWPAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:00:44 -0500
Received: from spirit.analogic.com ([204.178.40.4]:36357 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750901AbVKWPAn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:00:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200511231624.49208.vda@ilport.com.ua>
X-OriginalArrivalTime: 23 Nov 2005 15:00:20.0108 (UTC) FILETIME=[9F4B54C0:01C5F03E]
Content-class: urn:content-classes:message
Subject: Re: Use enum to declare errno values
Date: Wed, 23 Nov 2005 10:00:19 -0500
Message-ID: <Pine.LNX.4.61.0511230958550.18085@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Use enum to declare errno values
Thread-Index: AcXwPp9qXP6q4no9SN2NzS8vrML1qg==
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> <Pine.LNX.4.61.0511230908320.17975@chaos.analogic.com> <200511231624.49208.vda@ilport.com.ua>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "moreau francis" <francis_moreau2000@yahoo.fr>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Nov 2005, Denis Vlasenko wrote:

> On Wednesday 23 November 2005 16:19, linux-os (Dick Johnson) wrote:
>>> I'm just wondering why not declaring errno values using enumaration ?
>>> It is just more convenient when debuging the kernel.
>>>
>>> Thanks
>>
>> There is an attempt to keep kernel errno values similar to
>> user-mode errno values. This simplifies the user-kernel
>> interface where the kernel will return -ERRNO and the user-mode
>> code negates it and puts it into the user errno then sets the
>> return value to -1 (a Unix convention).
>>
>> The user-mode errno's therefore must correspond. You can't
>> expect the 'C' runtime libraries to be rebuilt and/or all the
>> programs recompiled just because the kernel got changed so
>> the errno's are hard-coded. 0 will always mean "no error" and
>> 1 will always be EPERM, etc. There are error-codes that are
>> the same number also, EWOULDBLOCK and EAGAIN are examples.
>>
>> So, you can't just auto-enumerate. If auto-enumeration isn't
>> possible, then you might just as well use #define, which is
>> what is done.
>
> ?!!
>
> enum {
> 	one,
> 	two,
> 	ten = 10
> };
>
> --

Did you BOTHER to read or you just picking a fight??

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
