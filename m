Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWH1MhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWH1MhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWH1MhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:37:00 -0400
Received: from spirit.analogic.com ([204.178.40.4]:58378 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750702AbWH1Mg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:36:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
x-originalarrivaltime: 28 Aug 2006 12:35:41.0720 (UTC) FILETIME=[7968E980:01C6CA9E]
Content-class: urn:content-classes:message
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Mon, 28 Aug 2006 08:35:32 -0400
Message-ID: <Pine.LNX.4.61.0608280825450.32602@chaos.analogic.com>
In-Reply-To: <20060828051409.GA17891@tuatara.stupidest.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why Semaphore Hardware-Dependent?
Thread-Index: AcbKnnlyiBVh5fh/Tz+qL+ytDTyFcg==
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <17650.13915.413019.784343@cargo.ozlabs.ibm.com> <20060828051409.GA17891@tuatara.stupidest.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chris Wedgwood" <cw@f00f.org>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Dong Feng" <middle.fengdong@gmail.com>, <ak@suse.de>,
       "Christoph Lameter" <clameter@sgi.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2006, Chris Wedgwood wrote:

> On Mon, Aug 28, 2006 at 10:18:35AM +1000, Paul Mackerras wrote:
>
>> I believe the reason for not doing something like this on x86 was
>> the fact that we still support i386 processors, which don't have the
>> cmpxchg instruction.  That's fair enough, but I would be opposed to
>> making semaphores bigger and slower on PowerPC because of that.
>> Hence the two different styles of implementation.
>
> The i386 is older than some of the kernel hackers, and given that a
> modern kernel is pretty painful with less than say 16MB or RAM in
> practice, I don't see that it would be all that terrible to drop
> support for ancient CPUs at some point (yes, I know some newer
> embedded (and similar) CPUs might be affected here too, but surely not
> that many that people really use --- and they could just use 2.4.x).

I don't think it's a matter of favoring any old PCs. Instead, it's
a matter of CPU designers creating special optimized operations for
use in semaphores. We should continue to use those if at all possible
because that's what they were designed for, even if semaphores could
be implemented with "standard" operations. Quoting myself from some
discussion years ago; "The fact that one can use an axe as a hammer
does not make an axe a hammer." We should continue to use the right
things even though CPUs are so fast nowadays that performance
advantages may seem to be lost in the noise. It's these little
performance detractors that tend to creep in and reduce the
performance of large systems.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
