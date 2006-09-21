Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWIUUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWIUUFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWIUUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:05:52 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:52741 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751534AbWIUUFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:05:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 21 Sep 2006 20:05:42.0131 (UTC) FILETIME=[50D2AC30:01C6DDB9]
Content-class: urn:content-classes:message
Subject: Re: "Int 6: CR2" on bootup w/ 2.6.18-rc7-mm1
Date: Thu, 21 Sep 2006 16:05:41 -0400
Message-ID: <Pine.LNX.4.61.0609211602130.30511@chaos.analogic.com>
In-Reply-To: <20060921124336.5dae2e09.akpm@osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "Int 6: CR2" on bootup w/ 2.6.18-rc7-mm1
thread-index: AcbduVD7xT2Umv+xS/2xrrPeQA0cyQ==
References: <200609211412.08561.bero@arklinux.org> <20060921124336.5dae2e09.akpm@osdl.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Bernhard Rosenkraenzer" <bero@arklinux.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Chuck Ebbert" <76306.1226@compuserve.com>, "Andi Kleen" <ak@muc.de>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2006, Andrew Morton wrote:

> On Thu, 21 Sep 2006 14:12:08 +0200
> Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
>> This happens when trying to boot 2.6.18-rc7-mm1 on a truly ancient
>> (Pentium 1)
>> box:
>>
>> Uncompressing Linux... Ok, booting the kernel.
>>
>> Int 6: CR2 00000000 err 00000000 EIP c0381719 CS 00000060 flags 00010046
>> Stack: 00000000 c036f4d1 00000000 c0100199 000001b8 0505c600 00c036cc
> 001f0fc3
>>
>> (No further details even with initcall_debug loglevel=7).
>> c0381719 appears to be in ACPI code -- but the Int 6 error happens even with
>> acpi=off.
>
> Well Chuck's new early-fault handler has gone and handled an early fault.
>
> I assume that machine runs 2.6.18 OK with the same .config?
> -

Interrupt 6 is an invalid opcode interrupt. The caller might check
the kind of CPU for which the kernel was compiled. You can't boot
a '486 with '686 opcodes. "Truly ancient" probably explains it all.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
