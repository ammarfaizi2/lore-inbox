Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVLNSwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVLNSwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLNSwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:52:06 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:13573 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964892AbVLNSwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:52:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <m11x0fa94c.fsf@ebiederm.dsl.xmission.com>
X-OriginalArrivalTime: 14 Dec 2005 18:51:58.0233 (UTC) FILETIME=[75E5A890:01C600DF]
Content-class: urn:content-classes:message
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Wed, 14 Dec 2005 13:51:45 -0500
Message-ID: <Pine.LNX.4.61.0512141327250.13659@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux in a binary world... a doomsday scenario
Thread-Index: AcYA33XvahLW1fDOR529r6yRPMlkVw==
References: <1133779953.9356.9.camel@laptopd505.fenrus.org><20051205121851.GC2838@holomorphy.com><20051206011844.GO28539@opteron.random><43944F42.2070207@didntduck.org> <20051206030828.GA823@opteron.random><f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com><1133869465.4836.11.camel@laptopd505.fenrus.org><4394ECA7.80808@didntduck.org><Pine.LNX.4.61.0512060855050.12611@chaos.analogic.com><m1acf3aba2.fsf@ebiederm.dsl.xmission.com><Pine.LNX.4.61.0512141200520.13496@chaos.analogic.com> <m11x0fa94c.fsf@ebiederm.dsl.xmission.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Brian Gerst" <bgerst@didntduck.org>,
       "Arjan van de Ven" <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       "Andrea Arcangeli" <andrea@suse.de>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2005, Eric W. Biederman wrote:

> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>
>> On Wed, 14 Dec 2005, Eric W. Biederman wrote:
>>
>>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>>>
>>>> When the linux-BIOS group started, few knew where to start. Then,
>>>> mysteriously, there was a complete directory tree of a well-known
>>>> BIOS that appeared on the web. That was a start.
>>>
>>> Nope it wasn't.  None of the developers even read the code.
>>> We needed to keep our hands clean.
>>>
>>> Eric
>>>
>>
>> Standard disclaimer #123
>
> And it is true.
>
> It's not like a mess of 20 year old spaghetti assembly is a useful
> starting point for anything.
>
> I sat down and I read the relevant standards documents and what
> chipset documentation there was and I manged to write code.
>
> It's not like there is anything fundamentally hard about what bootstrap
> firmware does.
>
> Not to be insulting but disbelief here sounds a lot like SCO's assertion
> that Linus couldn't written linux.

No, no. If you know that there is information available that you
could read and use as a reference, then you would certainly read
that information, wouldn't you?  There are many things about
the PC/AT architecture that could not possibly be known without
using some kind of reference because of "compatibility" issues.

For instance, how do you link the two interrupt controllers
together? You can't see it in the old PC/AT handbook schematics,
and its not in the documentation of the chips. Also, reading
a register won't give you the answer because the register values
are dynamic. So, you look to see what others have done. You
can start with the AT BIOS that's published, but it won't work
(I know because I have written two AT Class BIOS). You really
need to see what others have done in a few cases.

When we started to use the AMD SC520, we found out that the
BIOS vendor wanted to charge a large fee per "label".
So, I wrote a BIOS for it. Using all of the available
documentation for the SC520 plus the PC/AT would not result
in a few things working. So I had to peek. Just like
everybody else.

So, if you claim that you have written a PC/AT BIOS without
ever seeing how others have done it, you are in a world of
hurt, sort of beating yourself up for no good reason at all.

Also, since the basic architecture accesses things from software
interrupts, it's pretty easy to debug stuff. You just keep
substituting your code for the BIOS code. Eventually, you
have everything working except the raw initialization stuff
which can only be tested by throwing it off the cliff and
seeing if it will fly! That's when you find that the cascaded
interrupt controller doesn't work, BYW.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
