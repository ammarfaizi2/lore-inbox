Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWH1SOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWH1SOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWH1SOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:14:44 -0400
Received: from spirit.analogic.com ([204.178.40.4]:24841 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751234AbWH1SOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:14:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 28 Aug 2006 18:04:15.0754 (UTC) FILETIME=[5FE3C6A0:01C6CACC]
Content-class: urn:content-classes:message
Subject: Re: Serial custom speed deprecated?
Date: Mon, 28 Aug 2006 14:04:12 -0400
Message-ID: <Pine.LNX.4.61.0608281347500.818@chaos.analogic.com>
In-Reply-To: <87hczwkbcc.fsf@graviton.dyn.troilus.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbKzF/tgUqTeJLkTgeZCFS56VfYyA==
References: <20060826181639.6545.qmail@science.horizon.com><Pine.LNX.4.61.0608280817030.32531@chaos.analogic.com><1156775994.6271.28.camel@localhost.localdomain><Pine.LNX.4.61.0608281047360.388@chaos.analogic.com><87lkp8kgdv.fsf@graviton.dyn.troilus.org><Pine.LNX.4.61.0608281248420.683@chaos.analogic.com> <87hczwkbcc.fsf@graviton.dyn.troilus.org>
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
>> On Mon, 28 Aug 2006, Michael Poole wrote:
>>
>>> What baud rate does your system define CBAUDEX | B0 to be?  On my
>>
>> B0 is 0 (zero), no bits. If you are trying to play semantic games and
>> claim B0 is 1, i.e., bit 0, then it would not be written as B0, it
>> would be written as B(0) or B:0. B0 is defined to be the baud-rate
>> used to hang up the modem. It is zero in all bits on most all
>> implementations including my Sun. On most recent Linux distributions,
>> CBAUDEX is (octal) 0010000. Since B0 is zero, ORing it into CBAUDEX
>> does nothing.
>
> Thanks, Sherlock!  Again: What does CBAUDEX, by itself, do on your
> system?  As Alan Cox obviously thought the rest of the world was
> bright enough to notice, and as I tried to explain, the CBAUDEX bit is
> currently not defined when set by itself (i.e. as if it were CBAUDEX,
> CBAUDEX | B0, CBAUDEX << 0 or however else you want to denote it);
> there is always some other low-order (CBAUD) bit associated with it:
>

Certainly CBAUDEX does not represent a baud-rate itself. It is
a bit that is used to extend the baud-rate setting from the values
that could fit within the (CBAUD & ~CBAUDEX) mask so B50 through
B38400 could become B57600 through B4000000 when this bit is set.

The confusion arises when you use B0 in your argument. CBAUDEX was
the relevant bit, sufficiently defined, without adding a non-existent
bit.

I am sensitive to 'B0' because any new implementation must also
provide for its functionality. There still are modem-controlled
or connected devices that need to secure a line by hanging up.

>>> AMD64 machine, both the x86-64 and i386 asm/termbits.h files skip
>>> CBAUDEX -- B38400 is 0000017 and B57600 is 0010001 (CBAUDEX | B50).
>>> The headers do not define any baud rate between those two, either by
>>> rate or by c_cflag value.
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
