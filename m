Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWHYPwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWHYPwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWHYPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:52:38 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:57873 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964923AbWHYPwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:52:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 25 Aug 2006 15:52:35.0047 (UTC) FILETIME=[7B764F70:01C6C85E]
Content-class: urn:content-classes:message
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:52:34 -0400
Message-ID: <Pine.LNX.4.61.0608251148490.18661@chaos.analogic.com>
In-Reply-To: <043401c6c859$9c611350$294b82ce@stuartm>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Serial custom speed deprecated?
Thread-Index: AcbIXnt/nn5LMr4rQamt9KLObSC/Hw==
References: <043401c6c859$9c611350$294b82ce@stuartm>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Stuart MacDonald" <stuartm@connecttech.com>
Cc: "Krzysztof Halasa" <khc@pm.waw.pl>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "David Woodhouse" <dwmw2@infradead.org>, <linux-serial@vger.kernel.org>,
       "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Aug 2006, Stuart MacDonald wrote:

> From: On Behalf Of linux-os (Dick Johnson)
>> But the baud-rates have always been some approximation that starts
>> at 75 and increases by powers-of-two. This is because the hardware
>> always had fixed clocks with dividers that divided by powers-of-two.
>> What is the claim for the requirement of strange baud-rates set
>> as an integer of dimension "baud?" Where does this requirement
>> come from and what devices use these?
>
> Perhaps you'd like to check out our products
> http://www.connecttech.com/
>
> We build a lot of custom boards that have odd clocks to generate very
> odd baud rates for random serial devices. The Bxxx style has been a
> thorn in my side since 1999.
>
> Also, Oxford's 16PCI95x family has three different points of altering
> the clock; the clock prescaler, the actual sample rate (which is the
> classic /16 that most are used to), and the actual divisor. That can
> produce pretty much any baud rate, albeit with some error.
>
> ..Stu
>

Well when you change things, remember that you need not only something
that translates B9600 to your new 9600 (trivial it's a #define, but
ALSO (very important!) B0 needs to hang up the modem! This means
that some value (perhaps 0), as a divisor, needs to perform this
same function.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
