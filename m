Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVHDLRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVHDLRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVHDLRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:17:04 -0400
Received: from spirit.analogic.com ([208.224.221.4]:54793 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S262481AbVHDLQ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:16:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <92fc8b8105080318367f77fed1@mail.gmail.com>
References: <92fc8b8105080318367f77fed1@mail.gmail.com>
X-OriginalArrivalTime: 04 Aug 2005 11:16:57.0117 (UTC) FILETIME=[06A2F4D0:01C598E6]
Content-class: urn:content-classes:message
Subject: Re: 2.4.21: Sharing interrupts with serial console
Date: Thu, 4 Aug 2005 07:16:22 -0400
Message-ID: <Pine.LNX.4.61.0508040715130.15583@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.21: Sharing interrupts with serial console
thread-index: AcWY5gbJUSRErLgqRJ6X+P44p+lElg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chris Budd" <budorola@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>,
       <linux-serial@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Aug 2005, Chris Budd wrote:

> I have read http://www.tldp.org/HOWTO/Remote-Serial-Console-HOWTO/preparation-setport.html
> and http://www.linux-mips.org/archives/linux-mips/2004-04/msg00134.html
> and other items, but I still have not found the answers to the
> following questions:
>
> 1.  The rs_init function in ./linux-2.4.21/drivers/char/serial.c
> explicitly states "The interrupt of the serial console port can't be
> shared."  Does this include *ALL* interrupts?  The code checks for
> sharing only with other serial devices, not *ALL* types of devices
> like I2C, RTC, etc.
>
> 2.  While the presence of the comment about not sharing was nice, it
> does not explain "why?"  Why can't we share the serial console
> interrupt?  The serial console seems to work when I alter serial.c to
> skip this check for the sharing of interrupts with the serial console.
>
> 3.  Does the hardware platform matter?  We are running Linux 2.4.21 on
> an embedded XScale(ARM)-based board.
>
> Thanks,
> Chris.
> -

Only LEVEL interrupts can be shared, and all the drivers that
share that one interrupt need to be designed for sharing.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
