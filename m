Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945964AbWBOPLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWBOPLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945969AbWBOPLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:11:49 -0500
Received: from spirit.analogic.com ([204.178.40.4]:34318 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1945964AbWBOPLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:11:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060215142809.GA17842@tau.solarneutrino.net>
X-OriginalArrivalTime: 15 Feb 2006 15:11:46.0136 (UTC) FILETIME=[22E5E580:01C63242]
Content-class: urn:content-classes:message
Subject: Re: Random reboots
Date: Wed, 15 Feb 2006 10:11:45 -0500
Message-ID: <Pine.LNX.4.61.0602151003480.4854@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Random reboots
thread-index: AcYyQiLtpokmb8EASaWfFGCE5VbNfQ==
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net> <20060214132904.GI16566@tau.solarneutrino.net> <20060214232222.5d4384a8.khali@linux-fr.org> <20060215142809.GA17842@tau.solarneutrino.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ryan Richter" <ryan@tau.solarneutrino.net>
Cc: "Jean Delvare" <khali@linux-fr.org>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Nick Warne" <nick@linicks.net>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2006, Ryan Richter wrote:

> On Tue, Feb 14, 2006 at 11:22:22PM +0100, Jean Delvare wrote:
>> You seem to have hardware monitoring drivers loaded on the system, so
>> I'd suggest that you watch the returned values over time. If the
>> hardware is going wrong it might show there. Your system could be
>> overheating for some reason (stuck fan...)
>>
>> The fact that older kernels were seemingly working better doesn't prove
>> much. You were running these kernels before, not now, and hardware
>> *does* age, contrary to what people seem to think. If you want to make
>> certain that older kernels were indeed working better for purely
>> software reasons, you should switch back to such an old kernel and see
>> if things actually improve or not.
>>
>> Note that the first case ("a kernel came out that fixed the problem")
>> doesn't mean that the hardware was not at fault. There are quite a few
>> quirks in the Linux kernel code which are just there to workaround
>> known hardware or BIOS bugs.
>
> No, the old kernels still have all the bugs they ever did (of course).
> I tested it during the st-iommu-doublefree debugging.  I do not plan on
> running the old kernel again, mainly because it has so many irritating
> bugs (df doesn't work, the serial console stalls on boot, so it won't
> boot without handholding, etc. etc.).  I'd have to run it for at least a
> month to verify, and the old kernel has security vulnerabilities and so
> on.
>
> The sensors report a bunch of obvious nonsesne as always...  I keep them
                                ^^^^^^^^^^^^^^^^^^^_________ Hint?

I have a "new" machine with a "Thunder" board. It started to re-boot
for no good reason at all. It turns out that the plastic catch in
the fan/heatsink hold-down mechanism broke so the heatsink was
not tight against the CPU. I "fixed" it by tying it down with
some wire. The reboot problems, and some other "strange" problems
went away. One of the strange problems was that my 'C' runtime
library got corrupted, as well as some other read-only files,
even though e3fsck never found any problems.

> configured in with the hope that one day they'll report useful
> information, but that day hasn't come yet.  I just checked, and all the
> fans are still fine.  It's in a huge case with lots of fans and it's
> hardly warmer than room temp.  The opteron 240s don't put out much heat.
>

It's the CPU that counts, not the air temperature. Check its hardware.

> I'm still thououghly convinced it's a kernel bug.
>
> -ryan
> -

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
