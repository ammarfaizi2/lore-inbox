Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWC3QKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWC3QKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWC3QKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:10:34 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:32264 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750798AbWC3QKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:10:34 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <442C0BA3.1050603@corky.net>
x-originalarrivaltime: 30 Mar 2006 16:10:32.0464 (UTC) FILETIME=[78841900:01C65414]
Content-class: urn:content-classes:message
Subject: Re: Crash soon after an alloc_skb failure in 2.6.16 and previous, swap disabled
Date: Thu, 30 Mar 2006 11:10:27 -0500
Message-ID: <Pine.LNX.4.61.0603301059420.738@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Crash soon after an alloc_skb failure in 2.6.16 and previous, swap disabled
Thread-Index: AcZUFHiqgLyrD5paR/K5kXm9QRxGdA==
References: <442C0BA3.1050603@corky.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Just Marc" <marc@corky.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2006, Just Marc wrote:

> Hello,
>

> I'm running a few machines with swap turned off and am experiencing
> crashes when the system is extremely low on kernel memory.   So far the
> crashes observed are always inside the recv function of the Ethernet
[SNIPPED...]

Huh? If no buffers are available, received packets get thrown on the
floor. I see the failure(s) happened in an interrupt. If so, the
problem is in the network driver and your starved memory situation
brought out a bug.

>
> The benefits of running a system without swap are arguable, but in my
> particular scenario I prefer to have connections dropped rather than
> experience the overheads and latencies of a heavily swapping system.

I read this as; "I want the advantages of swap, but I don't want
to use swap." Or, "It doesn't work as I expected so therefore it's
broken!" In any event, swap is used to handle the problems with a
finite amount of memory. Normally sleeping tasks get swapped out,
freeing their memory for your network stuff. If you don't have swap,
that memory can't be freed. Tough! You did it, so you live with
it -- but contact the maintainer of your network card. You may
have forced a bug to come to the surface.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
