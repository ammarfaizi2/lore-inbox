Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWBWTEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWBWTEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWBWTEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:04:12 -0500
Received: from spirit.analogic.com ([204.178.40.4]:57861 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751373AbWBWTEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:04:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
x-originalarrivaltime: 23 Feb 2006 19:03:54.0433 (UTC) FILETIME=[E41D5B10:01C638AB]
Content-class: urn:content-classes:message
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 14:03:43 -0500
Message-ID: <Pine.LNX.4.61.0602231400430.4226@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Patch to reorder functions in the vmlinux to a defined order
Thread-Index: AcY4q+QmNCT+K/fEQWGXOltD1h26pg==
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <mingo@elte.hu>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Feb 2006, Linus Torvalds wrote:

>
>
> On Thu, 23 Feb 2006, Arjan van de Ven wrote:
>>>
>>> I think you would first need to move the code first for that. Currently it starts
>>> at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
>>>
>>> I wouldn't have a problem with moving the 64bit kernel to 2MB though.
>>
>> that was easy since it's a Config entry already ;)
>
> Btw, the "low TLB entry" for the direct-mapped case can't be used as a
> hugetlb page anyway, due to the MMU splitting it up due to the special
> MTRR regions, if I recall correctly.
>
> So this is probably a bigger performance win than just the difference
> between using one or two TLB entries.
>
> The same should be true on x86, btw. Where we should use a physical start
> address of 4MB for best performance.
>
> Does anybody want to run benchmarks? (Totally untested, may not boot,
> might physically accost your pets for all I know).
>
> 		Linus

I just reconfigured and rebuilt linux-2.6.15.4 to put PHYSICAL_START
at 0x00400000, unconditionally and it booted fine and is working so
a 'boot' shouldn't be a problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
