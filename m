Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965306AbVKGSRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbVKGSRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965359AbVKGSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:17:15 -0500
Received: from spirit.analogic.com ([204.178.40.4]:58641 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S965306AbVKGSRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:17:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <436F8FAE.90805@vmware.com>
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl> <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl> <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de> <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl> <436F7673.5040309@vmware.com> <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl> <436F8601.4070201@vmware.com> <Pine.LNX.4.61.0511071157590.27658@chaos.analogic.com> <436F8FAE.90805@vmware.com>
X-OriginalArrivalTime: 07 Nov 2005 18:17:10.0220 (UTC) FILETIME=[780F68C0:01C5E3C7]
Content-class: urn:content-classes:message
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
Date: Mon, 7 Nov 2005 13:17:04 -0500
Message-ID: <Pine.LNX.4.61.0511071313330.27911@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
Thread-Index: AcXjx3gZ6uAZVfqYS2CocmPfOvHgLg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Zachary Amsden" <zach@vmware.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Nov 2005, Zachary Amsden wrote:

> linux-os (Dick Johnson) wrote:
>
>> On Mon, 7 Nov 2005, Zachary Amsden wrote:
>>
>>
>>
>>> Maciej W. Rozycki wrote:
>>>
>>>> On Mon, 7 Nov 2005, Zachary Amsden wrote:
>>>>
>>>>
>>>>> While this is at least no worse in the nested fault case than earlier
>>>>> kernels, I really wish I had one of those weird 486s so I could test the
>>>>> faulting mechanism.  It seems the trap handling code has gotten quite
>>>>>
>>>> What's so weird about 486s?  Besides, for testing it doesn't have to be
>>>> one -- you will get away with a 386, too.  I have neither anymore, but
>>>> there are people around still using them.
>>>>
>>>>
>>> Because I hold in my hand "i486 Microprocessor Programmer's Reference
>>> Manual, c 1990", and it has no mention whatsoever of CR4, and all
>>> documentation I had until Friday had either no mention of CR4, or
>>> something to the effect of "new on Pentium, the CR4 register ..."  So
>>> I've had to re-adjust my definition of 486, which was weird.
>>>
>>> Zach
>>> -
>> Yes, and undocumented opcodes might not fault. They might do nothing
>> or something strange. It's not a good idea to use an undocumented
>> opcode in kernel space. The read-from-CR4 in kernel space, hoping
>> that an immoral-opcode trap will save you is not good practice.
>>
>> You might reset the processor.
>>
>>
>
> No, you won't.  #UD and #GP will not (I hesitate to say never, but other
> than a processor bug, I believe that is correct) reset the processor.
> And CR4 is not "undocumented", even on 486.
>

Yes it is. The i486 Programmer's reference manual documents only
to CR3.

> What is immoral about opcode trapping?
>
> Zach
>

Unfortunately Intel and others call bad opcodes "illegal opcodes".
They are not, because as powerful as they are, Intel doesn't make
law. Instead, they are "invalid opcodes" (or just immoral) as I
stated as a play on words.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
