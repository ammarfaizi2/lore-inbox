Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbSKZR2C>; Tue, 26 Nov 2002 12:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbSKZR2C>; Tue, 26 Nov 2002 12:28:02 -0500
Received: from fmr05.intel.com ([134.134.136.6]:43512 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266431AbSKZR2B>; Tue, 26 Nov 2002 12:28:01 -0500
Message-ID: <002001c29572$2ce2b2e0$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <trog@wincom.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <3de395e1.2c79.0@wincom.net>
Subject: Re: A Kernel Configuration Tale of Woe
Date: Tue, 26 Nov 2002 09:35:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I started doing a little doodling, and I came up with a very rough sort of
relationship
> map. I don't present this as the ideal data model - it's a start point at
best.
>
>
> A "box" is composed of "devices" and "subcomponents"
> A "subcomponent" is composed of "chipsets"
> A "chipset" provides a set of "capabilities"
> A "device" requires a  set of "capabilities"
> A "chipset->capability::capablility<-device" pair defines an "interface"
> An "interface" has associated with it:
>    a) the kernel version where it first became availible
>    b) the kernel config switches that activate it
>
> So what is needed is some way to start at the "box" level, and given the
set
> of subcomponents and devices associated with it, spit out a list of a) and
b)
>
>
> Here's the mini-eureka I've had - that need not actually be a part of the
kernel
> config system, although the kernel config system might potentially make
use
> of it.
>
> What would suffice would be some sort of online database, published in a
highly
> visible location, and crosslinked from hell and back to make it likely to
be
> discovered in a Google-driven troubleshooting session. Provide motherboard
make
> and model (a subcomponent) any expansion cards (also subcomponents) and
the
> make and model numbers of drives et al (devices) and then query the
database
> and present the report.
>
> I'm envisioning something very much like the CDDB service. This is a
little
> more complex, but the concept is similar. And like the CDDB service, it
could
> be queried over the network by some future "make" option if somebody
decided
> to implement that.
>
> Also like the CDDB service, it makes use of network effects. No one person
has
> to populate the _entire_ database. The association of "subcomponents" to
"chipsets"
> (or "devices" to "capabilities") might be done by the manufacturer, or it
might
> be done by the developer who actually debugged the original driver
instance,
> or it might even be done by someone like myself (a sufficiently clued-in
sysadmin
> who did it the hard way and wants to help those who will follow after him)
>
> All that matters is that _somebody_ contribute one little portion of the
mapping,
> and then, given enough somebodies, the entire map assembles itself.
>

So how would you deal with somebody contributing bogus mappings?
What if somebody was just wrong, or uploading a mapping in error?


> And if Microsoft hasn't dared attempt such a thing... well, then that
would
> make it an "innovation", wouldn't it? ;)
>
> DG

