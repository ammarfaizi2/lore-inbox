Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWDTU5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWDTU5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWDTU5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:57:05 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:38161 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751313AbWDTU5D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:57:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <200604202237.34134@zmi.at>
x-originalarrivaltime: 20 Apr 2006 20:57:01.0736 (UTC) FILETIME=[F8CB9A80:01C664BC]
Content-class: urn:content-classes:message
Subject: Re: rtc: lost some interrupts at 256Hz
Date: Thu, 20 Apr 2006 16:57:01 -0400
Message-ID: <Pine.LNX.4.61.0604201649460.6634@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rtc: lost some interrupts at 256Hz
Thread-Index: AcZkvPjo5/kic7PCQ9qm0lQFDx20QQ==
References: <200604202237.34134@zmi.at>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michael Monnerie" <michael.monnerie@it-management.at>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2006, Michael Monnerie wrote:

> When you google for such messages, you can find a lot of people asking,
> but nobody seems to have an answer. That's why I ask this list, where
> the Godfathers Of Linux reside, and maybe someone hears my prayer and
> could explain us sheep what you should do in such a case. Increase the
> HZ from 250 to 1000, or decrease to 100? Or maybe setting the
> preemption model from server to voluntary or preemptible? Or is that
> whining to be ignored, and if yes, what is this message for at all?
>
> Please give us wisdom, and we will spread your word. Amen.
>
> Answers please per PM, I'm not on this list.
>

If you are losing interrupts at 256 Hz, you have either/or:
(1) Some very BAD driver that is disabling interrupts for way too long.
(2) Some very slow CPU (like 40 Mhz) that is being overwhelmed by a lot of
network interrupt activity.

The last time I measured, with a 400 MHz, '486 machine, Linux could
handle 50,000 interrupts per second off the printer port, with the
lowest priority interrupt (IRQ7). The work, within the interrupt was
to toggle a bit in memory and write it back to the printer data port.

This was used to show latency (with a scope) and log any missed
interrupts of which there were none.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
