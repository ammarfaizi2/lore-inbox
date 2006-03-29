Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWC2SPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWC2SPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 13:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWC2SPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 13:15:51 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:29963 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750909AbWC2SPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 13:15:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <442ACAD6.6@nortel.com>
x-originalarrivaltime: 29 Mar 2006 18:15:48.0766 (UTC) FILETIME=[CE2B03E0:01C6535C]
Content-class: urn:content-classes:message
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
Date: Wed, 29 Mar 2006 13:15:48 -0500
Message-ID: <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CONFIG_FRAME_POINTER and module vermagic
Thread-Index: AcZTXM5Oue3Wntq/SfahFLPSIJ+c6A==
References: <442ACAD6.6@nortel.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2006, Christopher Friesen wrote:

>
> I've had a case reported to me of someone loading a module without frame
> pointers into kernel compiled with frame pointers enabled.
>
> 1) Is this allowed?  I didn't think so, but I wanted to double check.
> 2) If not, would it make sense to include this in the module vermagic?
>
> Thanks,
>
> Chris

Frame-pointers don't affect calling conventions, only the manner
at which passed parameters are retrieved from the stack by the
called procedures. Plus, the register ebp (BP), the frame-pointer
register, is "precious" and is preserved across calls in GCC 'C'.
So, you can intermix -fno-frame-pointer code at will. It is possible
that a kernel-mode debugger may improperly display local variables,
but normally these things are not used in kernel development anyway.

So yes you can intermix such code. There is no need to flag it
in vermagic.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
