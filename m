Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVLPOkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVLPOkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVLPOkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:40:16 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:46601 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932310AbVLPOkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:40:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1134689197.12086.176.camel@mindpipe>
X-OriginalArrivalTime: 16 Dec 2005 14:40:13.0678 (UTC) FILETIME=[9FB4F8E0:01C6024E]
Content-class: urn:content-classes:message
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 09:39:56 -0500
Message-ID: <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] i386: always use 4k stacks
Thread-Index: AcYCTp+8qiXw+T9OR/Cs6b2AEywzvw==
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <43A1DB18.4030307@wolfmountaingroup.com> <1134688488.12086.172.camel@mindpipe> <43A1E451.2090703@wolfmountaingroup.com> <1134689197.12086.176.camel@mindpipe>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <arjan@infradead.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Dec 2005, Lee Revell wrote:

> On Thu, 2005-12-15 at 14:46 -0700, Jeff V. Merkey wrote:
>> Lee Revell wrote:
>>
>>> On Thu, 2005-12-15 at 14:07 -0700, Jeff V. Merkey wrote:
>>>
>>>
>>>> When you are on the phone with an irrate customer at 2:00 am in the
>>>> morning, and just turning off your broken 4K stack fix
>>>> and getting the customer running matters.
>>>>
>>>>
>>>
>>> Bugzilla link please.  Otherwise STFU.
>>>
>>>
>>
>> ??????
>>
>> Jeff
>
> You imply that your customer's problem was due to a kernel bug triggered
> by CONFIG_4KSTACKS.  I am asking you to provide a link to the bug report
> or get lost.
>
> Lee

Throughout the past two years of 4k stack-wars, I never heard why
such a small stack was needed (not wanted, needed). It seems that
everybody "knows" that smaller is better and most everybody thinks
that one page in ix86 land is "optimum". However I don't think
anybody ever even tried to analyze what was better from a technical
perspective. Instead it's been analyzed as religious dogma, i.e.,
keep the stack small, it will prevent idiots from doing bad things.

I'm fairly sure that if you started from scratch and decided to
write a new operating system, your choice of a stack-size would
probably be something like 64k. I have no clue why somebody
decided to use a 4k stack and force their choice upon others.
And, yes, I am well aware that each system-call requires a
seperate stack upon entry and it even needs to keep that stack
while sleeping.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
