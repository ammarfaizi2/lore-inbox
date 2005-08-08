Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVHHLU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVHHLU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVHHLU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:20:28 -0400
Received: from spirit.analogic.com ([208.224.221.4]:18444 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750822AbVHHLU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:20:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050805214954.GA25533@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan> <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com> <20050805214954.GA25533@minerva.local.lan>
X-OriginalArrivalTime: 08 Aug 2005 11:20:26.0040 (UTC) FILETIME=[2CD11380:01C59C0B]
Content-class: urn:content-classes:message
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Date: Mon, 8 Aug 2005 07:19:34 -0400
Message-ID: <Pine.LNX.4.61.0508080715200.18119@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: local DDOS? Kernel panic when accessing /proc/ioports
thread-index: AcWcCyzYOg6XeX7tQDCqXHPWYe8pMw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Martin Loschwitz" <madkiss@madkiss.org>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Martin Loschwitz wrote:

> On Fri, Aug 05, 2005 at 03:40:26PM -0400, linux-os (Dick Johnson) wrote:
>>
>> On Fri, 5 Aug 2005, Martin Loschwitz wrote:
>>
>>> Hi folks,
>>>
>>> I just ran into the following problem: Having updated my box to 2.6.12.3,
>>> I tried to start YaST2 and noticed a kernel panic (see below). Some quick
>>> debugging brought the result that the kernel crashes while some user (not
>>> even root ...) tries to access /proc/ioports. Is this a known problem and
>>> if so, is a fix available?
>>>
>>> Ooops and ksymoops-output is attached.
>>>
>>
>> This can happen if a module is unloaded that doesn't free its
>> resources! Been there, done that.
>>
>
> "This can happen" is not an acceptable explanation, I think. Modules should

Of course it is. You find the module that isn't freeing it's
resources, fix it, and you don't get the panic when you access
/proc/ioports. It's really that simple.

Thinking that modules shouldn't be able to kill the kernel isn't
goint to help. Everything that runs inside the kernel has the
necessary priviliges to destroy anything in the kernel.

> not be able to kill the kernel -- apart from that, I can trigger the bug in
> the very early "ash-system" that KNOPPIX provides. At that time, the modules
> listed below were the only ones loaded -- no others, and I am also sure that
> until that point, no modules were unloaded.
>
> sbp2 ohci1394 usb_storage ub ehci_hcd usbcore
>
> --
>  .''`.   Martin Loschwitz           Debian GNU/Linux developer
> : :'  :  madkiss@madkiss.org        madkiss@debian.org
> `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
>   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
