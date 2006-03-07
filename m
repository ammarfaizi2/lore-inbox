Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWCGMHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWCGMHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbWCGMHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:07:54 -0500
Received: from spirit.analogic.com ([204.178.40.4]:10760 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750842AbWCGMHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:07:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <440CCD9A.3070907@shaw.ca>
x-originalarrivaltime: 07 Mar 2006 12:07:46.0937 (UTC) FILETIME=[BF48CE90:01C641DF]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Tue, 7 Mar 2006 07:07:46 -0500
Message-ID: <Pine.LNX.4.61.0603070705490.8536@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZB379lL8+UnjzIRNG68/4t6i+tag==
References: <5N5Ql-30C-11@gated-at.bofh.it> <5NnDE-44v-11@gated-at.bofh.it> <440CCD9A.3070907@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Mar 2006, Robert Hancock wrote:

> linux-os (Dick Johnson) wrote:
>> This started to happen in a lot of PCI drivers once it became
>> necessary to call pci_enable_device() in order to make the
>> returned IRQ values valid. This has been reported numerious
>> times and has not been fixed. Basically, in order to get
>> the correct value, one needs to disable the board in some
>> unspecified way so it is not possible for it to generate
>> an interrupt before enabling the board. With some devices
>> this may not be possible!
>
> What kind of board behaves that way? pci_enable_device just enables the
> device BARs and wakes it up if it was suspended, I should think that any
> device that starts generating interrupts from that must be quite broken..
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/

No. It would be good if that was true. Unfortunately, the IRQ
returned before the pci_enable_device() is not correct. It
gets re-written by pci_enable_device().


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
