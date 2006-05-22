Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWEVNaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWEVNaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWEVNaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:30:04 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30215 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750824AbWEVNaB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:30:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 22 May 2006 13:29:59.0213 (UTC) FILETIME=[D28B65D0:01C67DA3]
Content-class: urn:content-classes:message
Subject: Re: [IDEA] Poor man's UPS
Date: Mon, 22 May 2006 09:29:58 -0400
Message-ID: <Pine.LNX.4.61.0605220908580.26879@chaos.analogic.com>
In-Reply-To: <200605221604.16043.jk-lkml@sci.fi>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [IDEA] Poor man's UPS
Thread-Index: AcZ9o9KViYVM+pfbTuaMNGKIv4TjWA==
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jan Knutar" <jk-lkml@sci.fi>
Cc: "Christian Trefzer" <ctrefzer@gmx.de>,
       "Pau Garcia i Quiles" <pgquiles@elpauer.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 May 2006, Jan Knutar wrote:

> On Monday 22 May 2006 01:40, Christian Trefzer wrote:
>>
>> I think it would be cheaper ("costs" for your solutin in terms of
>> required I/O power and hard disk space) to use two or more lead
>> batteries which are charged and discharged in a round-robin fashion,
>> controlled by some smart home-brew circuitry, and connect the beast to
>> some control/monitoring software via RS-232 ; )
>>
>> The logic should at least completely drain the battery before
>> recharging,
>
> I thought deep discharge cycles were unhealthy for lead batteries?

Yes. It's some of the more modern chemistries that need deep discharges
because they tend to "remember". Lead acid batteries, both wet cells
and gel cells should be taken down to about 66 percent capacity and
that's 66 percent capacity, not some arbitrary voltage. For instance,
a 24 ampere-hour battery, fully charged at 25 degC, has a terminal
voltage of 13.2 volts after the load is applied. Presumably it
contains 13.2 * 24 * 3600 = 1,140,480 joules (watt-seconds) of
energy. You get to use 66 percent of this, i.e., 752,717 joules
before it needs charging. You can't detect the charge state by
looking at the terminal voltage! You need to actually measure
the voltage and current during charge and discharge to maintain
battery health. Otherwise, you just throw them away every year or
so. The telephone company has lead-acid batteries that have been
running for 50 years and they will be good "forever" because they
carefully (automatically) maintain them.

NICAD batteries used in aircraft will wear out in a short time
no matter what you do with them. They are used only because they
have a high power density (are lighter than lead acid). They will
"remember" shallow discharge cycles and fail unless they are
subjected to deep discharge cycles. If they are discharged too
deeply, they will fail to charge. Portable power drills and such
use this chemistry and it sucks. If you leave your battery pack
on the charger, the battery will fail. If you charge it once a
week it will fail as well. Only people who use these tools daily
will find that they work when they need them! Same thing for
airplanes. If your Lear spends too much time sitting in the
hanger, the batteries fail. Doesn't everybody have a Lear?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
