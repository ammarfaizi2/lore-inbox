Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVIPTUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVIPTUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVIPTUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:20:21 -0400
Received: from spirit.analogic.com ([208.224.221.4]:45584 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750726AbVIPTUT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:20:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <5162CC44-37D0-4FEB-ADC6-887F6FC3C3BA@mac.com>
References: <a5986103050915004846d05841@mail.gmail.com> <1e62d137050915010361d10139@mail.gmail.com> <a598610305091505184a8aa8fd@mail.gmail.com> <1e62d13705091508391832f897@mail.gmail.com> <87mzmduq1h.fsf@amaterasu.srvr.nix> <1126879660.3103.6.camel@localhost.localdomain> <87irx1ujc0.fsf@amaterasu.srvr.nix> <Pine.LNX.4.61.0509161133410.2041@chaos.analogic.com> <5162CC44-37D0-4FEB-ADC6-887F6FC3C3BA@mac.com>
X-OriginalArrivalTime: 16 Sep 2005 19:20:17.0072 (UTC) FILETIME=[ABB82B00:01C5BAF3]
Content-class: urn:content-classes:message
Subject: Re: best way to access device driver functions
Date: Fri, 16 Sep 2005 15:20:12 -0400
Message-ID: <Pine.LNX.4.61.0509161512350.5140@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: best way to access device driver functions
Thread-Index: AcW686vBGe0p/gpcRcaWhkXsaoKuOw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Cc: "Nix" <nix@esperi.org.uk>, <arjanv@redhat.com>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       <ivan.korzakow@gmail.com>, <fawadlateef@gmail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Sep 2005, Kyle Moffett wrote:

> On Sep 16, 2005, at 12:02:59, linux-os (Dick Johnson) wrote:
>> Somebody reported to me that there was some special "optimization"
>> in Linux that interpreted ioctl() function calls without regard to
>> the specific device that was open (gawd I hope not), and that if
>> you used "already-used" function numbers for your device-specific
>> ioctl(), then strange things would occur.
>
> IIRC, that used to be the case, but isn't anymore.
>
>> However, the kernel is now LOCKED during an ioctl() call. Older
>> Linux versions didn't lock the kernel. The upshotof this is that if
>> you have some ioctl() function that takes some time, like testing
>> the memory in your board, you will find the system unresponsive
>> during that test! You can unlock the kernel in your ioctl() if this
>> is a problem.
>
> This is *completely* wrong.  The kernel used to lock_kernel() for
> *every* ioctl.  Recent changes added locked and unlocked ioctls, such
> that ioctls that do not need the BKL can ignore it completely.  You
> claimed to have read the code, given this typical Wrongbot statement,
> I guess I can say for sure that you didn't.
>

If you are really interested, put a 'if(kernel_locked())' in your
favorite ioctl(), and then respond with an apology.

> Cheers,
> Kyle Moffett
>
> --
> Premature optimization is the root of all evil in programming
>   -- C.A.R. Hoare
>
> PS:  Use a different email service!  Your "I tried to kill it with
> the above dot" and bullshit apology is worth zilch.  A quick
> calculation shows that over the last month and a half, you have
> sent 76 or so emails to the list, all of which have contained your
> useless 663-byte corporate message, meaning you have sent 50K of spam
> to the list over that time period, which has been distributed to
> several thousand accounts by vger, resulting in probably over 100MB
> of spam over that time period.  Fix it or use a different email account!
>

There is no other email service available to many people. They
have to use whatever their company provides. I can't even access yahoo
from inside the company. If the list keeper followed the recommended
email procedure of ignoring everything after a "." in the first
column, something that is as old as email itself, then there would
not be any of the crap that a lot of emailers append.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
