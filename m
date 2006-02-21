Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBUVzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBUVzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWBUVzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:55:08 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:6921 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932122AbWBUVzG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:55:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <9a8748490602211351v29c7804ew3a1305326941ea84@mail.gmail.com>
x-originalarrivaltime: 21 Feb 2006 21:54:53.0580 (UTC) FILETIME=[723774C0:01C63731]
Content-class: urn:content-classes:message
Subject: Re: make -j with j <= 4 seems to only load a single CPU core
Date: Tue, 21 Feb 2006 16:54:53 -0500
Message-ID: <Pine.LNX.4.61.0602211653070.6016@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: make -j with j <= 4 seems to only load a single CPU core
Thread-Index: AcY3MXJBxhjsjIYoQ76xEVpLy8ZfnQ==
References: <9a8748490602211302j61c0088fp8b555860e928028e@mail.gmail.com> <9a8748490602211310j344db10evd685149a3c60b1e7@mail.gmail.com> <1140558161.9838.8.camel@amdx2.microgate.com> <9a8748490602211351v29c7804ew3a1305326941ea84@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Paul Fulghum" <paulkf@microgate.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Sam Ravnborg" <sam@ravnborg.org>, "Andrew Morton" <akpm@osdl.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2006, Jesper Juhl wrote:

> On 2/21/06, Paul Fulghum <paulkf@microgate.com> wrote:
>> On Tue, 2006-02-21 at 22:10 +0100, Jesper Juhl wrote:
>>
>>> I should probably mention that the kernel I'm currently running and
>>> observing this behaviour with is 2.6.16-rc4-mm1.
>> ...
>>>> I find this quite strange since anything from 'make -j 2' and up
>>>> should be able to keep both cores resonably busy, but there seems to
>>>> be a huge difference between j <= 4 and j > 4.
>>
>> I've seen the same thing (on Athlon 64x2 64 bit)
>> but was not sure if it was a problem.
>>
>> The break point for me seems to be between -j 2 and -j 3
>> -j 2 = serialized (or the appearance of)
>> -j 3 = both cores mostly busy
>>
>> I'm pretty sure with an earlier 2.6 kernel source (but same environment)
>> I did not see this. I'll start back tracking to earlier kernels
>> to see if I can identify when this started.
>>
>
> I know positively that I've seen this with previous 2.6.16-<something>
> kernels, but not sure which ones exactely. I just dismissed it as
> something that would probably be fixed soon and then today when I
> build a few test kernels I noticed it again and thought "ohh, so it
> didn't get fixed, better report it".
>
> I don't recall seeing it with 2.6.15 and earlier kernels, but I'm not
> at all sure - especially since I only got this Athlon X2 box recently
> and the first kernels I ever ran on it were 2.6.15-<something>.
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html

Could it be, simply, that you are now I/O bound with nothing
for these CPUs to do in user-space, being busy handling the
kernel I/O?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.49 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
