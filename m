Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCIMmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCIMmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCIMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:42:15 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:49166 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751181AbWCIMmO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:42:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <440F6A0D.3040704@shaw.ca>
x-originalarrivaltime: 09 Mar 2006 12:42:11.0789 (UTC) FILETIME=[E2DBB7D0:01C64376]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Thu, 9 Mar 2006 07:42:11 -0500
Message-ID: <Pine.LNX.4.61.0603090735410.17939@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZDduLjjndVV267RTGx3Yns7T5LCA==
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it> <440CCD9A.3070907@shaw.ca> <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com> <440D918D.2000502@shaw.ca> <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com> <440E1E9F.3020208@shaw.ca> <Pine.LNX.4.61.0603080658580.12681@chaos.analogic.com> <440F6A0D.3040704@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Mar 2006, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> You don't bother to read. The reported interrupt is WRONG, INVALID,
>> INCORRECT, BROKEN, until __after__ the device is enabled. That means
>> that one CANNOT put an interrupt handler in place before the
>> device is enabled.
>
> And my point is, even if you COULD put an interrupt handler into place
> before enabling the device, if the device can be in an unstable state
> such that the interrupt can't be acknowledged reliably, how can you
> handle it without causing an interrupt storm?
>

Easy. Mask off the interrupts in the device. Software should
certainly "know" if the device has been initialized to a stable
state. Until it has been initialized, the ISR will simply
clear and mask the device.

> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
