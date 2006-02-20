Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWBTVM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWBTVM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWBTVM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:12:28 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:27660 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932166AbWBTVM1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:12:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200602202051.51882.nick@linicks.net>
x-originalarrivaltime: 20 Feb 2006 21:12:23.0109 (UTC) FILETIME=[579AB750:01C63662]
Content-class: urn:content-classes:message
Subject: Re: i386 AT keyboard LED question.
Date: Mon, 20 Feb 2006 16:12:22 -0500
Message-ID: <Pine.LNX.4.61.0602201608420.1577@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: i386 AT keyboard LED question.
Thread-Index: AcY2Yle1arKERcb4SryTDzqo5McSeA==
References: <200602202003.26642.nick@linicks.net> <20060220202441.GB31272@suse.cz> <200602202051.51882.nick@linicks.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nick Warne" <nick@linicks.net>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Nick Warne wrote:

> On Monday 20 February 2006 20:24, Vojtech Pavlik wrote:
>> On Mon, Feb 20, 2006 at 08:03:26PM +0000, Nick Warne wrote:
>>> Hi Vojtech,
>>>
>>> I wondered why numlock LED goes off during boot process, even though I
>>> ask BIOS to turn on;
>
> ~snip~
>
>> Some old notebooks forget them on, which makes the keyboard unusable -
>> you get '4' instead of 'u', etc.
>
> Understand.  I never thought of that!
>
>>
>> We can't read the LED state anyway (except for going to the BIOS data
>> structures, which isn't reasonable from the atkbd driver), and we need
>> to initialize it, so off is the safer default.
>>
>> Further, this has been the behavior of Linux since it was first
>> implemented, and thus, in my rewrite of the keyboard handling, I didn't
>> change it.
>
> Thanks for detailed reply - I see now, and didn't know any of this.
>
>> It's trivial to change the default lock state in init scripts / xdm
>> config / X config, too.
>
> I boot into init 3, so as I don't reboot much, I always forget to turn numlock
> back on when logging in [failed] - hence the question.
>
> I will look at a local fix rather than a patch for kernel.
>
> Thanks again,
>
> Nick

In .. /etc/rc.d/rc.local
 	/usr/bin/setleds -num /dev/tty0 (or whatever)



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.49 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
