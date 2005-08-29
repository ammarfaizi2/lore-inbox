Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVH2Lrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVH2Lrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 07:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVH2Lrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 07:47:33 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35858 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751128AbVH2Lrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 07:47:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <6b5347dc050827085727df49c8@mail.gmail.com>
References: <6b5347dc05082609206ff7a305@mail.gmail.com> <430F45F8.8020505@nortel.com> <6b5347dc050827085727df49c8@mail.gmail.com>
X-OriginalArrivalTime: 29 Aug 2005 11:47:31.0247 (UTC) FILETIME=[7030BBF0:01C5AC8F]
Content-class: urn:content-classes:message
Subject: Re: when or where can the case occur in "linux kernel development " about "kernel preemption"?
Date: Mon, 29 Aug 2005 07:46:34 -0400
Message-ID: <Pine.LNX.4.61.0508290742540.27714@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: when or where can the case occur in "linux kernel development " about "kernel preemption"?
Thread-Index: AcWsj3A6l0ZE2BA3TtCgb7Vn89TiSg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Sat." <walking.to.remember@gmail.com>
Cc: "Christopher Friesen" <cfriesen@nortel.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Aug 2005, Sat. wrote:

> 2005/8/27, Christopher Friesen <cfriesen@nortel.com>:
>> Sat. wrote:
>>> the case about kernel preemption as follow :
>>>
>>> the book said "when a process that has a higher priority than the
>>> currenty running process is awakened ".
>>>
>>> but I can think about when such case can occur , could you give me an example ?
>>
>> There may be others, but one common case is when a hardware interrupt
>> causes the higher priority process to become runnable.  Some examples of
>> this would be a network packet arriving, or the expiry of a hardware timer.
>>
>> Chris
>>
>
> unfortunately, I cannot agree with you , normally ,when the kernel
> runs in interrupt context , the schedule() should not be invoked
> ------my views .
>
> then,could anyone  give me a definite example about network like above
> or anything else to eluminate  this , ok?
>
> thanks !
>
> --
> Sat.

Schedule is never executed from an interrupt, BUT, there may be
kernel threads or even user tasks that are sleeping, waiting
to be awakened when some preliminary interrupt processing has
occurred. The interrupt code may execute one of the wake-up calls
which will cause the target to be put into the run queue as soon
as possible.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
