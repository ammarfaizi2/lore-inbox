Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVHAOX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVHAOX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVHAOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:23:25 -0400
Received: from spirit.analogic.com ([208.224.221.4]:35341 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S261627AbVHAOXY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:23:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050801130902.GA23949@ucw.cz>
References: <1122861215.11148.26.camel@localhost.localdomain> <1122872189.5299.1.camel@localhost.localdomain> <1122873057.15825.26.camel@mindpipe> <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr> <42EE1324.10304@grupopie.com> <Pine.LNX.4.61.0508010836020.30161@chaos.analogic.com> <20050801130902.GA23949@ucw.cz>
X-OriginalArrivalTime: 01 Aug 2005 14:23:21.0595 (UTC) FILETIME=[91DD9CB0:01C596A4]
Content-class: urn:content-classes:message
Subject: Re: IBM HDAPS, I need a tip.
Date: Mon, 1 Aug 2005 10:22:57 -0400
Message-ID: <Pine.LNX.4.61.0508011002070.30306@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IBM HDAPS, I need a tip.
thread-index: AcWWpJHn23dY93FzQ/eIkVRVcczBUQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "Paulo Marques" <pmarques@grupopie.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Lee Revell" <rlrevell@joe-job.com>, <abonilla@linuxwireless.org>,
       <linux-kernel@vger.kernel.org>,
       "hdaps devel" <hdaps-devel@lists.sourceforge.net>,
       "Yani Ioannou" <yani.ioannou@gmail.com>, "Dave Hansen" <dave@sr71.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Aug 2005, Vojtech Pavlik wrote:

> On Mon, Aug 01, 2005 at 08:55:53AM -0400, linux-os (Dick Johnson) wrote:
>
>>> Jan Engelhardt wrote:
>>>>> So in order to calibrate it you need a readily available source of
>>>>> constant acceleration, preferably with a known value.
>>>>>
>>>>> Hint: -9.8 m/sec^2.
>>>>
>>>> Drop it out of the window? :)
>>>
>>> No, no. Constant gravity (like having the laptop sitting on the desk)
>>> "feels like" constant acceleration.
>>>
>>> Dropping it out of the window should measure 0 m/sec^2, because the
>>> accelerometer is not working on an inertial referential (I hope this is
>>> the correct term in english...). For the accelerometer, this is just
>>> like the feeling of free falling inside an elevator: no gravity :)
>>>
>>> --
>>> Paulo Marques - www.grupopie.com
>>
>> You need a centrifuge or something that works like one. You can
>> make one and you can calibrate it using simple techniques.
>
> Not at all. It's enough to let the laptop lie on the table for [0,0]G
> calibration, then put sequentially it on all the four sides for [-1,0]G,
> [1,0]G, [0,1]G, [0,-1]G calibration.
>

Huh?  A laptop on the table is subjected to 1G on earth. If turned over,
is still subjected to 1G, although the sensor may show -1G. Unless
the correct k (calibration factor) is known, for each load direction,
it cannot be derived from +/- 1, the only readings you have, because
of the 1G bias of the load-cell itself.
A pair of load-cells mounted orthagonally, will show the accelleration
in 4 axis. However, you can't assume that if you held the mass at
a 45 degree angle, for instance, that both sensors would read
0.707 (cos 45) or that if at 90, one pair would read 0.0

You need to calibrate using real values. With a sping-scale, and
some room to swing the device, you can readily obtain some accurate
load values.

>> From these five measurements you have both the zero point and the
> slopes, including a good error estimate.
>
> I've done that before when toying with IMUs.
>
> --
> Vojtech Pavlik
> SuSE Labs, SuSE CR
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
