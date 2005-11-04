Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVKDWH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVKDWH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVKDWH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:07:58 -0500
Received: from spirit.analogic.com ([204.178.40.4]:42501 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750999AbVKDWH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:07:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <436BC42B.1050804@gmail.com>
References: <436BC42B.1050804@gmail.com>
X-OriginalArrivalTime: 04 Nov 2005 22:07:56.0292 (UTC) FILETIME=[35B91440:01C5E18C]
Content-class: urn:content-classes:message
Subject: Re: negative timeout can be set up by setsockopt system call
Date: Fri, 4 Nov 2005 17:07:55 -0500
Message-ID: <Pine.LNX.4.61.0511041658240.13855@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: negative timeout can be set up by setsockopt system call
Thread-Index: AcXhjDXcWBjPfYrHRfOOSpTTPUvRnA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ram Gupta" <ram.gupta5@gmail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Nov 2005, Ram Gupta wrote:

> I observed that the the setsockopt system call can  setup negative
> timeout. As a matter of fact the function sock_set_timeout checks for
> zero timeout but does not check for negative timeouts. I tested this
> against 2.6.14  kernel but it is so in all previous release also. So I
> am wondering if it is a bug or there is some reason for keeping it that
> way which I am missing.
>
> Regards
> Ram gupta

As a parameter it takes a void pointer to the value plus a
length of the object to which the value points. Given this,
I don't understand "negative". The pointer can point to
anything of a specified size so it doesn't have a sense
of +/-.

If the socket call itself checked for sign it would
severly limit what options could be adjusted. Perhaps
the SO_SNDTIMEO/SO_RCVTIMEO might do some checking, but
I think it's valid to set the timeout to -1, meaning it
never times-out.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
