Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWDJUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWDJUHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWDJUHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 16:07:53 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:35851 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932105AbWDJUHw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 16:07:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <m3k69xkygp.fsf@defiant.localdomain>
x-originalarrivaltime: 10 Apr 2006 20:07:49.0435 (UTC) FILETIME=[70F4B8B0:01C65CDA]
Content-class: urn:content-classes:message
Subject: Re: Black box flight recorder for Linux
Date: Mon, 10 Apr 2006 16:07:49 -0400
Message-ID: <Pine.LNX.4.61.0604101559170.26720@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Black box flight recorder for Linux
Thread-Index: AcZc2nD8sqwezH0ERQ6IJSWsnVEUPg==
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it><4437C335.30107@shaw.ca> <200604080917.39562.ak@suse.de><Pine.LNX.4.61.0604100754340.25546@chaos.analogic.com> <m3k69xkygp.fsf@defiant.localdomain>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: "Andi Kleen" <ak@suse.de>, "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Apr 2006, Krzysztof Halasa wrote:

> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
>
>> Further, in a boot where the BIOS needs to initialize hardware,
>> It will write all RAM before enabling NMI. This makes sure that
>> the parity bit(s) are set properly. Most BIOS will attempt to
>> preserve RAM on a 'warm' boot as a throw-back to the '286 days
>> with their above-1MB-memory-manager paged RAM because the
>> only way to get back from protected mode to 16-bit real mode
>> was a hardware reset.
>
> I think there is no distinction WRT RAM test between cold and warm
> boot anymore. If the BIOS clears the RAM is, I think, determined by
> the "fast POST" option in BIOS setup (it always checks the size
> so some bytes will be changed anyway).
>
>> When using a memory-manager like DOS's
>> HIMEM.SYS, you might actually be rebooting the machine hundreds
>> of times per second!
>
> Yes but it uses (or, rather, used) a CMOS flag to skip POST (not only
> the RAM test) and to go directly to the entry point in real mode.
>
> IIRC (I may be wrong, that was 15+ years ago) only 286 required
> KBC reset to return to real mode (did LOADALL matter?), 386s have
> no such problem.
>
>
> BTW I understand the idea have nothing to do with actual aircraft,
> so it would be the admin rather than NTSB looking at the data(?).
> --
> Krzysztof Halasa

Yes. After I responded and after reading other responses I noted that
the idea was to review the reason for a PC crash. There are no
good places to store things that can be counted upon to remain after
a crash. Even though CMOS RAM goes to 0x7f and not all of it is
needed for BIOS setup, many/(maybe all) BIOS checksum the whole
thing with some hair-brained checksum routines so it's not a good
place to store things. Many BIOS use 128k or more, which can
be re-written in 64k pages. Certainly there is space available
...but... the BIOS would be trashed if a power-failure occurred
during the write, so that's not a good place either. I did, at
one time, use a "spare" page of screen memory (one that wasn't
displayed) during the boot process (buffering for a bootable NVRAM
disk). This is "available" RAM, but it isn't going to survive
even as screen-card reset!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
