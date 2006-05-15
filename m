Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWEONg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWEONg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEONgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:36:25 -0400
Received: from spirit.analogic.com ([204.178.40.4]:50959 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964897AbWEONgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:36:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 15 May 2006 13:36:13.0220 (UTC) FILETIME=[88941640:01C67824]
Content-class: urn:content-classes:message
Subject: Re: Segfault on the i386 enter instruction
Date: Mon, 15 May 2006 09:36:12 -0400
Message-ID: <Pine.LNX.4.61.0605150933060.22830@chaos.analogic.com>
In-Reply-To: <446867C4.3070108@etpmod.phys.tue.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Segfault on the i386 enter instruction
Thread-Index: AcZ4JIisYTg3iPa9QHSjPGtD5SY2mw==
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <p734pzv73oj.fsf@bragg.suse.de> <20060512153139.GA4852@duch.mimuw.edu.pl> <446867C4.3070108@etpmod.phys.tue.nl>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bart Hartgers" <bart@etpmod.phys.tue.nl>
Cc: "Tomasz Malesinski" <tmal@mimuw.edu.pl>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Bart Hartgers wrote:

> Tomasz Malesinski wrote:
>> On Fri, May 12, 2006 at 03:50:20PM +0200, Andi Kleen wrote:
>>> Handling it like you expect would require to disassemble
>>> the function in the page fault handler and it's probably not
>>> worth doing that for this weird case.
>>
>> Does it mean that the ENTER instruction should not be used to create
>> stack frames in Linux programs?
>>
>
> Basically, yes. Here is a link to a relevant discussion in the 2.2.7 era:
>
> http://groups.google.co.nz/groups?selm=7i86ni%24b7n%241%40palladium.transmeta.com
>
> And perhaps x86-64 is handled different because of the red zone (some
> memory below the stack-pointer that can be accessed legally)?
>
> Groeten,
> Bart

The enter instruction works perfectly fine. The processors were
designed to use both enter and leave. There are no prohibitions
against their use. It's just that if you play games with assembly
so you create a stack-pointer wrap situation, you can get a
bounds error.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
