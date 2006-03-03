Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWCCSjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWCCSjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWCCSjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:39:45 -0500
Received: from spirit.analogic.com ([204.178.40.4]:56077 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1161021AbWCCSjn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:39:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net>
x-originalarrivaltime: 03 Mar 2006 18:39:42.0526 (UTC) FILETIME=[D603EDE0:01C63EF1]
Content-class: urn:content-classes:message
Subject: Re: Setkeycodes w/ keycode >= 0x100 ?
Date: Fri, 3 Mar 2006 13:39:42 -0500
Message-ID: <Pine.LNX.4.61.0603031322410.18198@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Setkeycodes w/ keycode >= 0x100 ?
Thread-Index: AcY+8dYLu0PU/TiORsqYP1jq7ed10Q==
References: <Pine.LNX.4.64.0603031241130.15776@light.int.webcon.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Mar 2006, Ian E. Morgan wrote:

> Since my HP notebook has some unrecognized keys, I have to use setkeycodes to
> make the kernel recognise them. However, many of the basic (<=255) KEY's from
> input.h are not suitable, but newer ones (>=0x100) woule be perfect.
>
> Any idea how to map scancodes to keycodes >=0x100 when setkeycodes won't
> accept hex input nor anything greater than 255?
>
> Regards,
> Ian Morgan

The keyboard controller generates scan-codes from 0 to 255.
It reads the scan-code information from a byte-wide port
(so-called PORT_A in the PC/AT), so it can't be any larger
than a byte. The controller provides a code when the key
is pressed and another code when the key is released. The
only difference between these codes is a single bit.
This limits the number of possible different scan codes
to 127.

The scan-codes are translated, based upon the Caps Lock, the
Ctrl key, the Alt key, and the Shift key so, in principle,
you could have almost 4 times as many keyboard symbols as
scan-codes. However, you would have to rewrite a lot of
keyboard code to take advantage of this.

>
> --
> -------------------------------------------------------------------
> Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
> imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
>    *  Customized Linux Network Solutions for your Business  *
> -------------------------------------------------------------------

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
