Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVL3OpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVL3OpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVL3OpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:45:21 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:51460 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932174AbVL3OpU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:45:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200512281716.43089.vda@ilport.com.ua>
X-OriginalArrivalTime: 30 Dec 2005 14:45:17.0523 (UTC) FILETIME=[A6988A30:01C60D4F]
Content-class: urn:content-classes:message
Subject: Re: 4k stacks
Date: Fri, 30 Dec 2005 09:45:01 -0500
Message-ID: <Pine.LNX.4.61.0512300943120.32191@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 4k stacks
Thread-Index: AcYNT6a8tt2+i4GOSJuppqohL532MQ==
References: <Pine.LNX.4.61.0512221640490.8179@chaos.analogic.com> <200512241403.38482.vda@ilport.com.ua> <Pine.LNX.4.61.0512280808290.25369@chaos.analogic.com> <200512281716.43089.vda@ilport.com.ua>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Dec 2005, Denis Vlasenko wrote:

> On Wednesday 28 December 2005 15:14, linux-os (Dick Johnson) wrote:
>>>> Anyway, getting down to 20 bytes of stack-space available
>>>> seems to be pretty scary.
>>>
>>> +       movl    %esp, %edi
>>> +       movl    %edi, %ecx
>>> +       andl    $~0x1000, %edi
>>> +       subl    %edi, %ecx
>>>
>>> ecx will be equal to ?
>>
>> Whatever the stack was minus that value ANDed with NOT 0x1000,
>> i.e. 0x1000 minus the stack already in use. The code assumes
>> that the stack starts and ends on a 0x1000 (page) boundary.
>> If that's not true, then all bets are off.
>
> Hmm. I must be thick today. (esp - (esp & 0xffffefff))
> is always equal to (esp & 0x00001000). Which is either 0 or 0x1000.
> --
>

Yes it's supposed to be ~0xfff.

  vda
>


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5591.11 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
