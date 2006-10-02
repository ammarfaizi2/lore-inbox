Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWJBLjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWJBLjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWJBLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:39:20 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:5906 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750885AbWJBLjT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:39:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 02 Oct 2006 11:39:07.0935 (UTC) FILETIME=[5F03AAF0:01C6E617]
Content-class: urn:content-classes:message
Subject: Re: Announce: gcc bogus warning repository
Date: Mon, 2 Oct 2006 07:39:02 -0400
Message-ID: <Pine.LNX.4.61.0610020735550.16599@chaos.analogic.com>
In-Reply-To: <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Announce: gcc bogus warning repository
thread-index: AcbmF18slCEKMMdDToanIemSe3SYvQ==
References: <451FC657.6090603@garzik.org> <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Oct 2006, Daniel Walker wrote:

> On Sun, 2006-10-01 at 09:44 -0400, Jeff Garzik wrote:
>> The level of warnings in a kernel build has lately increased to the
>> point where it is hiding bugs and otherwise making life difficult.
>>
>> In particular, recent gcc versions throw warnings when it thinks a
>> variable "MAY be used uninitialized", which is not terribly helpful due
>> to the fact that most of these warnings are bogus.
>>
>> For those that may find this valuable, I have started a git repo that
>> silences these bogus warnings, after careful auditing of code paths to
>> ensure that the warning truly is bogus.
>>
>> The results may be found in the "gccbug" branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
>>
>
> Steven Rostedt an I worked on this problem in May. Steven came up with,
> a nice way to handle these warnings, which doesn't increase code size.
> Here's the post if your interested.
>
> http://lkml.org/lkml/2006/5/11/50
>
> Daniel

I wouldn't hide this in a macro, though. This could cause future
maintainers a lot of problems after code is revised. If you are
going to assign a variable's value to itself to eliminate compiler
warnings, please do it openly, preferably with a comment.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
