Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWBBPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWBBPYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWBBPYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:24:22 -0500
Received: from spirit.analogic.com ([204.178.40.4]:53774 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932066AbWBBPYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:24:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1138891408.9861.12.camel@localhost.localdomain>
X-OriginalArrivalTime: 02 Feb 2006 15:24:20.0240 (UTC) FILETIME=[BD024900:01C6280C]
Content-class: urn:content-classes:message
Subject: Re: calling bios interrupt
Date: Thu, 2 Feb 2006 10:24:19 -0500
Message-ID: <Pine.LNX.4.61.0602021018400.20650@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: calling bios interrupt
Thread-Index: AcYoDL0hvxree4TQTxC+aig4hbJ9+A==
References: <43E1B93A.5000603@slovanet.net> <1138891408.9861.12.camel@localhost.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Jozef Kutej" <jozef.kutej@slovanet.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Feb 2006, Alan Cox wrote:

> On Iau, 2006-02-02 at 08:48 +0100, Jozef Kutej wrote:
>> Hello.
>>
>> Can someone help me solve my problem with on board watch dog timer that
>> need to call bios interrupt? Here's how to update watch dog timer.
>>
>> mov ax,6f02h
>> mov bl, 30	;number of seconds
>> int 15h
>>
>> How can i do this in kernel so that i can write wdt driver?
>
> You need to drive the hardware directly. Ask the vendor for the hardware
> info, or alternatively you might want to try using a library like lrmi
> in user space to call it and log the I/O instructions it tries to
> execute.
>

Also, if the machine has a floppy, boot DOS. Write the above snippit
of code using DOS debug. Step through it. Watch what register(s) get
written...

A>debug
- a100
- mov ax,6f02
- mov bl, ff
- int 15
- int 3

rip 100
- t ; trace the steps.

Once the timer gets written, the machine will reboot when it
times-out. Therefore use a large timeout value as above 0xff.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
To unsubscribe


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
