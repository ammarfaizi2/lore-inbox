Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWH1Q5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWH1Q5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWH1Q5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:57:13 -0400
Received: from spirit.analogic.com ([204.178.40.4]:53001 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750701AbWH1Q5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:57:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 28 Aug 2006 16:57:03.0509 (UTC) FILETIME=[FC7C0450:01C6CAC2]
Content-class: urn:content-classes:message
Subject: Re: Serial custom speed deprecated?
Date: Mon, 28 Aug 2006 12:57:03 -0400
Message-ID: <Pine.LNX.4.61.0608281248420.683@chaos.analogic.com>
In-Reply-To: <87lkp8kgdv.fsf@graviton.dyn.troilus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbKwvyDl2vXhIHxQ1+ky/ZGuDmucA==
References: <20060826181639.6545.qmail@science.horizon.com><Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com><1156775994.6271.28.camel@localhost.localdomain><Pine.LNX.4.61.0608281047360.388@chaos.analogic.com> <87lkp8kgdv.fsf@graviton.dyn.troilus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Poole" <mdpoole@troilus.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux@horizon.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2006, Michael Poole wrote:

> linux-os \(Dick Johnson\) writes:
>
>> On Mon, 28 Aug 2006, Alan Cox wrote:
>>
>>> Ar Llu, 2006-08-28 am 08:17 -0400, ysgrifennodd linux-os (Dick Johnson):
>>>> On Sat, 26 Aug 2006 linux@horizon.com wrote:
>>>>
>>>>>> Or we could just add a standardised extra set of speed ioctls, but then
>>>>>> we need to decide what occurs if I set the speed and then issue a
>>>>>> termios call - does it override or not.
>>>>>
>>>>> Actually, we're not QUITE out of bits.  CBAUDEX | B0 is not taken.
>>>>
>>>> B0 is not a bit (there are no bits in 0). It won't work.
>>>
>>> Well that is how it is implemented and everyone else seems happy. If it
>>> violates your personal laws of physics you'll just have to cope.
>>
>> It has nothing to do with 'personal laws of physics'. On all recent
>> implementations, B0 is 0, i.e., the absence of any bits set. Therefore,
>> there is no observable difference between CBAUDEX and CBAUDEX | B0,
>> as shown above. Therefore, as I stated, it won't work.
>
> What baud rate does your system define CBAUDEX | B0 to be?  On my

B0 is 0 (zero), no bits. If you are trying to play semantic games and
claim B0 is 1, i.e., bit 0, then it would not be written as B0, it
would be written as B(0) or B:0. B0 is defined to be the baud-rate
used to hang up the modem. It is zero in all bits on most all
implementations including my Sun. On most recent Linux distributions,
CBAUDEX is (octal) 0010000. Since B0 is zero, ORing it into CBAUDEX
does nothing.

> AMD64 machine, both the x86-64 and i386 asm/termbits.h files skip
> CBAUDEX -- B38400 is 0000017 and B57600 is 0010001 (CBAUDEX | B50).
> The headers do not define any baud rate between those two, either by
> rate or by c_cflag value.
>
> Michael Poole
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
