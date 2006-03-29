Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWC2PCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWC2PCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC2PCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:02:45 -0500
Received: from spirit.analogic.com ([204.178.40.4]:38417 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750775AbWC2PCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:02:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
x-originalarrivaltime: 29 Mar 2006 15:02:42.0247 (UTC) FILETIME=[D4108570:01C65341]
Content-class: urn:content-classes:message
Subject: Re: Float numbers in module programming
Date: Wed, 29 Mar 2006 10:02:41 -0500
Message-ID: <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Float numbers in module programming
Thread-Index: AcZTQdQ0v7Ox7fzIRt6d8UNlXESbXw==
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "beware" <wimille@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Mar 2006, beware wrote:

> Hi
>
> i wonder if it is available to use float numbers in a module programming.
> Because, when I'm look for the param_get functions, i find them only
> for integers (long, short, and others) but none for the float numbers.
>
> Thanks for yours answer.
>
> bye
> -

This used to be a FAQ. The floating-point coprocessor in ix86
machines is a shared resource. There is only one. Therefore,
the state of the floating-point unit needs to be saved and
restored across all context switches. Because this is expensive
in terms of CPU time used, it is not saved and restored during
system calls. This means that if you use the coprocessor in
the kernel, you may screw up somebody's mathematics, causing
the airplane to go off course and crash into the Getchey-
Goomy swamp. If this is okay, then fine. Otherwise, don't
use the coprocessor inside kernel code.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
