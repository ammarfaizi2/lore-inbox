Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWEVPy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEVPy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:54:58 -0400
Received: from spirit.analogic.com ([204.178.40.4]:21508 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750712AbWEVPy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:54:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 22 May 2006 15:54:56.0664 (UTC) FILETIME=[12A11980:01C67DB8]
Content-class: urn:content-classes:message
Subject: Re: [IDEA] Poor man's UPS
Date: Mon, 22 May 2006 11:54:56 -0400
Message-ID: <Pine.LNX.4.61.0605221139040.27175@chaos.analogic.com>
In-Reply-To: <20060522152531.GB4538@hermes.uziel.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [IDEA] Poor man's UPS
Thread-Index: AcZ9uBKqEGgHy8lQQlm86hOf4XAk/A==
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <Pine.LNX.4.61.0605220908580.26879@chaos.analogic.com> <20060522152531.GB4538@hermes.uziel.local>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Christian Trefzer" <ctrefzer@gmx.de>
Cc: "Jan Knutar" <jk-lkml@sci.fi>,
       "Pau Garcia i Quiles" <pgquiles@elpauer.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2006, Christian Trefzer wrote:

> On Mon, May 22, 2006 at 09:29:58AM -0400, linux-os (Dick Johnson) wrote:
>> On Mon, 22 May 2006, Jan Knutar wrote:
>>> I thought deep discharge cycles were unhealthy for lead batteries?
>>
>> Yes. It's some of the more modern chemistries that need deep discharges
>> because they tend to "remember".
>
> And if you truly deep discharge them, they drop dead and won't remember
> they've been charged. Topping off won't do any good either. So there's
> some security margin your daily e.g.  LiIon appliance in your cellphone
> will force upon you, in order to keep the battery alive. You can turn
> the thing on over and over, but it will shut down on you after seconds.
> It just won't suck the thing dry. And the charging process will be
> stopped slightly before the battery is entirely full, to avoid
> overcharge.
>
>> Lead acid batteries, both wet cells and gel cells should be taken down
>> to about 66 percent capacity and that's 66 percent capacity, not some
>> arbitrary voltage. For instance, a 24 ampere-hour battery, fully
>> charged at 25 degC, has a terminal voltage of 13.2 volts after the
>> load is applied. Presumably it contains 13.2 * 24 * 3600 = 1,140,480
>> joules (watt-seconds) of energy. You get to use 66 percent of this,
>> i.e., 752,717 joules before it needs charging. You can't detect the
>> charge state by looking at the terminal voltage! You need to actually
>> measure the voltage and current during charge and discharge to
>> maintain battery health. Otherwise, you just throw them away every
>> year or so. The telephone company has lead-acid batteries that have
>> been running for 50 years and they will be good "forever" because they
>> carefully (automatically) maintain them.
>
> Except for the slow and irreversible chemical transformations at the
> poles, I guess. Acid is corrosive, after all. So with careful handling,
> those things last a long time, but not forever, unfortunately. But the
> approximation is good enough, anyway.
>
> So it appears to me that those lead acid beasts make up a rather
> constant source of DC - with other solutions the state can be measured
> by means of voltage alone. But the circuitry might be a bit more
> complicated for this exact reason. Do you by any chance know where I
> might look for schematics of such circuitry? Any hint greatly
> appreciated : )
>
> Kind regards,
> Chris
>

Telco used watt-meters and clocks to directly monitor the batteries.
In the event that the batteries had been floating for a month (not used
and trickle-charging), the timer would send them an equalizing charge
of about 10 amperes for 10 minutes. That would blast away any surface
corruption and bring the individual cells up to an equal terminal
voltage.

Modern chargers just don't bother unless the batteries are used for
medical equipment. In our portable CAT Scanners, we monitor current,
voltage, and time using a uP. This guarantees that once you start
a scan, the scan will complete (as required by regulatory agencies).

We also charge at a constant current until getting to the correct
terminal voltage. In other words, the charger is current-limited
until the voltage is correct, then it becomes voltage regulated.
The regulated voltage depends upon temperature and you can get
the numbers off from battery vendor's specifications. We don't
set an "equalizing charge" as telco did. We found with our specific
batteries it wasn't necessary.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
