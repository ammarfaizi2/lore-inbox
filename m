Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVLBUiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVLBUiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLBUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:38:15 -0500
Received: from spirit.analogic.com ([204.178.40.4]:48658 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751094AbVLBUiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:38:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
X-OriginalArrivalTime: 02 Dec 2005 20:38:11.0721 (UTC) FILETIME=[4FD5BF90:01C5F780]
Content-class: urn:content-classes:message
Subject: Re: [RFC] ip / ifconfig redesign
Date: Fri, 2 Dec 2005 15:38:11 -0500
Message-ID: <Pine.LNX.4.61.0512021527090.11277@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] ip / ifconfig redesign
Thread-Index: AcX3gE/hLEcCezUVQkOda6woLI5pVQ==
References: <200512022253.19029.a1426z@gawab.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Al Boldi" <a1426z@gawab.com>
Cc: <netdev@vger.kernel.org>, <linux-net@vger.kernel.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Dec 2005, Al Boldi wrote:

> The current ip / ifconfig configuration is arcane and inflexible.  The reason
> being, that they are based on design principles inherited from the last
> century.
>
> In a GNU/OpenSource environment, OpenMinds should not inhibit themselves
> achieving new design-goals to enable a flexible non-redundant configuration.
>
> Specifically, '#> ip addr ' exhibits this issue clearly, by requiring to
> associate the address to a link instead of the other way around.
>
> Consider this new approach for better address management:
> 1. Allow the definition of an address pool
> 2. Relate links to addresses
> 3. Implement to make things backward-compatible.
>
> The obvious benefit here, would be the transparent ability for apps to bind
> to addresses, regardless of the link existence.
>

A link needs to exist for it to have an address.

> Another benefit includes the ability to scale the link level transparently,
> regardless of the application bind state.
>

That doesn't make any sense. Multiple applications can bind to the
same address. Then can't bind to the same port because they won't
get all their data.

> And there may be many other benefits... (i.e. 100% OSI compliance)
>
What does Open Source Initiative have to do with this at all???
You are just spewing stuff out.

> --
> Al

Also, how does this involve the kernel? The interface to the kernel
for hardware configuration is via ioctl(). For logic, sockets.

If the user-level tools suck, then they should be fixed. It
really doesn't have anything to do with the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.44 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
