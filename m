Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVLTShj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVLTShj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbVLTShj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:37:39 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:22282 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750938AbVLTShi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:37:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse>
X-OriginalArrivalTime: 20 Dec 2005 18:36:55.0392 (UTC) FILETIME=[5A3D8E00:01C60594]
Content-class: urn:content-classes:message
Subject: Re: About 4k kernel stack size....
Date: Tue, 20 Dec 2005 13:36:20 -0500
Message-ID: <Pine.LNX.4.61.0512201316350.27879@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: About 4k kernel stack size....
Thread-Index: AcYFlFpHKTVP5LhJQJGtj1SWsq3tCw==
References: <20051218231401.6ded8de2@werewolf.auna.net>     <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>    <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <46578.10.10.10.28.1135094132.squirrel@linux1> <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com> <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chase Venters" <chase.venters@clientec.com>
Cc: "Sean" <seanlkml@sympatico.ca>, "Mike Snitzer" <snitzer@gmail.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Mark Lord" <lkml@rtr.ca>,
       "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, <nel@vger.kernel.org>,
       <mpm@selenic.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Chase Venters wrote:

> On Tue, 20 Dec 2005, linux-os \(Dick Johnson\) wrote:
>> See, isn't rule-making fun? This whole 4k stack-
>> thing is really dumb. Other operating systems
>> use paged virtual memory for stacks, except
>> for the interrupt stack. If Linux used paged
>> virtual memory for stacks, the pages would not
>> have to be contiguous so dynamic stack allocation
>> would practically never fail. But Linux doesn't
>> use paged virtual memory for stacks. So, there
>> needs to be some rule to control the amount
>> of kernel stack allocated to each task when it
>> executes a system call.
>
> Pardon, but why should "Other operating systems use paged virtual memory
> for stacks" have anything to do with the design of Linux? Other operating
> systems also look for a file called AUTORUN.INF whenever you insert a CD,
> and they'll happily run arbitrary code...

Sorry, you must be talking about M$ stuff. I wasn't. There are
real operating systems that work. They solved a lot of problems
by doing things correctly, learning from the mistakes of others.



  which is great when you're a
> motherboard manufacturer providing crappy drivers on a crappy CD with
> crappy artwork and you want to play a jingle before slapping a hideous GUI
> up in front of your unsuspecting user; or perhaps you're Sony and you want
> to hook people's kernel such that you become a sort of media hypervisor.
> And this is the most deployed OS in the game...
>

Also, the M$ __kernel__ doesn't look for any files of any kind except
for its page file which is locates without the file-system, BTW.
If you have the misfortune of using some contraption that uses M$,
just bring up the "Task Manager". Look at the "processes". One
of them there, looks for new disks/mounts/etc at 1-second intervals.
Can you guess which one? Hint. You can't figure it out from its name!

> Linux is a kernel - not a perl script. Programmer laziness is about the
> only excuse I've been able to spot in this discussion that has been raised
> in support of big stacks. (Perhaps all the arguments against aren't worded
> as such; but as far as I've seen they all reduce to it).
>

A kernel stack is simply an implimentation detail. Somebody made
an early decision to use non-paged memory for stacks. From that
point one, we have to either live with it or change it. The
change doesn't involve size. It involves kind.

> If Linux used 4k stacks, we wouldn't have to worry about virtual
> memory *or* contiguous allocations.
>
> - Chase
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
