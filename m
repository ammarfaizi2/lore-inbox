Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWDSM7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWDSM7P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWDSM7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:59:15 -0400
Received: from spirit.analogic.com ([204.178.40.4]:2319 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750742AbWDSM7O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:59:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net>
x-originalarrivaltime: 19 Apr 2006 12:59:13.0750 (UTC) FILETIME=[0EEE5760:01C663B1]
Content-class: urn:content-classes:message
Subject: Re: searching exported symbols from modules
Date: Wed, 19 Apr 2006 08:59:13 -0400
Message-ID: <Pine.LNX.4.61.0604190846280.27438@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjsQ73+MAmhsxjT/CqSBg95Y/ULQ==
References: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Antti Halonen" <antti.halonen@secgo.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2006, Antti Halonen wrote:

>
> Hi,
>
> Apologies if I posted this question to wrong place.
>
> Here's the thing: when loading my module 'a', I want to search modules
> list to check if module 'b' is presents, and if it is, initialize my
> function pointers to the functions module b has exported. Or at least
> search symbols from module b, whatever. The main question is; how to
> locate modules by name from my module a?
>

`insmod` (or modprobe) does all this automatically. Anything that's
'extern' will get resolved. You don't do anything special. You can
also use `depmod` to verify that you won't have any problems loading.
`man depmod`.

> Is this doable? Can anyone give me pointers?
>
> Sorry for posting such a stupid question, but I didn't run into
> satisfactory when searching the archive & many of the functions which
> would have resolved this are apparently not exported anymore.
>

If you are accessing functions or other objects that are not exported
anymore, how do you know that they even exist? You can search through
System.map to see if they are still global, but they might not be
the same size or type as before, or functions might take different
parameters.

You need to have built your modules using the current kernel headers
of the target OS version, using the current procedures (yes there are
some cheats that can be used), so that the current tools (like insmod
and modprobe) can properly handle your module.

> Any comments are really appreciated!
>
> Thanking in advance,
> antti
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
