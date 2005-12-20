Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVLTS7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVLTS7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLTS7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:59:42 -0500
Received: from spirit.analogic.com ([204.178.40.4]:39948 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750779AbVLTS7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:59:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1135104210.2952.26.camel@laptopd505.fenrus.org>
X-OriginalArrivalTime: 20 Dec 2005 18:59:40.0732 (UTC) FILETIME=[880BE7C0:01C60597]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Tue, 20 Dec 2005 13:59:40 -0500
Message-ID: <Pine.LNX.4.61.0512201354220.27983@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYFl4gVCFEu6v6hRFyZZg8TZL+sfA==
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <46578.10.10.10.28.1135094132.squirrel@linux1> <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com> <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse> <Pine.LNX.4.61.0512201316350.27879@chaos.analogic.com> <1135104210.2952.26.camel@laptopd505.fenrus.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Arjan van de Ven wrote:

>
>> A kernel stack is simply an implimentation detail. Somebody made
>> an early decision to use non-paged memory for stacks. From that
>> point one, we have to either live with it or change it. The
>> change doesn't involve size. It involves kind.
>
> it involves a whole lot, like banning dma from the stack, and to make it
> swapable or kmapped you'd even need to fix all the places that put
> things like wait queues on the stack, as well as many other similar data
> structures. Staying at 4Kb is a lot easier than that ;)
>
Yes. No question about it. Once that decision was made, it defined a
lot of kernel internals. It just might be why Linux is such a good
performer, too. There are a lot of good things that might be caused
by the non-paged stack.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
