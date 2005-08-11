Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVHKSWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVHKSWN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVHKSWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:22:13 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:21519 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932273AbVHKSWN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:22:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1123783862.17269.89.camel@localhost.localdomain>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> <1123770661.17269.59.camel@localhost.localdomain> <2cd57c90050811081374d7c4ef@mail.gmail.com> <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> <1123775508.17269.64.camel@localhost.localdomain> <1123777184.17269.67.camel@localhost.localdomain> <2cd57c90050811093112a57982@mail.gmail.com> <2cd57c9005081109597b18cc54@mail.gmail.com> <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com> <1123781187.17269.77.camel@localhost.localdomain> <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com> <1123783862.17269.89.camel@localhost.localdomain>
X-OriginalArrivalTime: 11 Aug 2005 18:22:10.0677 (UTC) FILETIME=[96CB8250:01C59EA1]
Content-class: urn:content-classes:message
Subject: Re: Need help in understanding x86 syscall
Date: Thu, 11 Aug 2005 14:21:55 -0400
Message-ID: <Pine.LNX.4.61.0508111412320.15505@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in understanding x86 syscall
Thread-Index: AcWeoZbXzbL2r4wGTbmUZTqda0v/Cg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: "Coywolf Qi Hunt" <coywolf@gmail.com>, <7eggert@gmx.de>,
       "Ukil a" <ukil_a@yahoo.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Aug 2005, Steven Rostedt wrote:

> On Thu, 2005-08-11 at 13:46 -0400, linux-os (Dick Johnson) wrote:
>
>>
>> I was talking about the one who had the glibc support to use
>> the newer system-call entry (who's name can confuse).
>>
>> You are looking at code that uses int 0x80. It's an interrupt,
>> therefore, in the kernel, once the stack is set up, interrupts
>> need to be (re)enabled.
>
> int is a call to either an interrupt or exception procedure. 0x80 is
> setup in Linux to be a trap and not an interrupt vector. So it does
> _not_ turn off interrupts.
>

I'm not sure you can stop the CPU from clearing the interrupt
bit in EFLAGS if you execute an interrupt. The interrupt handler
may be supported by a trap-gate, but the event has already
occurred. The documentation I have isn't clear on this at all.

> I'm looking at the sysenter code which is suppose to be the fast entry
> into the system, and it looks like it is suppose to call the
> sysenter_entry when used.  I'm trying to write something to test this
> out, since I still have the ud2 op in my sysentry code. So if I do get
> this to work, I can cause a bug.
>
> -- Steve
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
