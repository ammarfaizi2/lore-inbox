Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbVH0Axj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbVH0Axj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVH0Axj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:53:39 -0400
Received: from fmr16.intel.com ([192.55.52.70]:20905 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S965185AbVH0Axi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:53:38 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: HPET drift question
Date: Fri, 26 Aug 2005 17:53:35 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60058CAF33@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HPET drift question
Thread-Index: AcWpiA2vitGF38RYRgmF5vvBEzVVrABGTgiw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>
Cc: <robert.picco@hp.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Aug 2005 00:53:36.0638 (UTC) FILETIME=[C1B701E0:01C5AAA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes. Looks like "ti->drift = HPET_DRIFT;" is right here. However, I
would 
like to double check this with Bob.

Thanks,
Venki

>-----Original Message-----
>From: Alex Williamson [mailto:alex.williamson@hp.com] 
>Sent: Thursday, August 25, 2005 8:17 AM
>To: Pallipadi, Venkatesh
>Cc: robert.picco@hp.com; linux-kernel@vger.kernel.org
>Subject: HPET drift question
>
>Hi Venki,
>
>   I'm confused by the calculation of the drift value in the hpet
>driver.  The specs defines the recommended minimum hardware
>implementation is a frequency drift of 0.05% or 500ppm.  However, the
>drift passed in when registering with the time interpolator is:
>
>ti->drift = ti->frequency * HPET_DRIFT / 1000000;
>
>Isn't that absolute number of ticks per second drift?  The time
>interpolator defines the drift in parts per million.  Shouldn't this
>simply be:
>
>ti->drift = HPET_DRIFT;
>
>The current code seems to greatly penalize any hpet timer with greater
>than a 1MHz frequency.  Thanks,
>
>	Alex
>
>-- 
>Alex Williamson                             HP Linux & Open Source Lab
>
>
