Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVH3S1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVH3S1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVH3S1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:27:36 -0400
Received: from fmr13.intel.com ([192.55.52.67]:42128 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932255AbVH3S1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:27:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] fix hpet drift and url
Date: Tue, 30 Aug 2005 11:27:25 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005950C89@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix hpet drift and url
Thread-Index: AcWtictLMiYXD8FvSwa3mWovg292uQABoQSg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <akpm@osdl.org>
Cc: "Robert W. Picco" <bob.picco@hp.com>, <linux-kernel@vger.kernel.org>,
       "Alex Williamson" <alex.williamson@hp.com>
X-OriginalArrivalTime: 30 Aug 2005 18:27:25.0868 (UTC) FILETIME=[788316C0:01C5AD90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ack.

Andrew: Please apply.

Thanks,
Venki 

>-----Original Message-----
>From: Alex Williamson [mailto:alex.williamson@hp.com] 
>Sent: Tuesday, August 30, 2005 10:40 AM
>To: akpm@osdl.org
>Cc: Robert W. Picco; Pallipadi, Venkatesh; linux-kernel@vger.kernel.org
>Subject: [PATCH] fix hpet drift and url
>
>
>   The HPET driver is using a parts per second drift factor instead of
>the standard parts per million drift the time interpolator 
>code expects.
>This patch fixes that problem and updates the URL for the HPET spec.
>
>Signed-off-by: Alex Williamson <alex.williamson@hp.com>
>
>diff -r 38ae29531c91 drivers/char/hpet.c
>--- a/drivers/char/hpet.c	Tue Aug 30 05:51:28 2005
>+++ b/drivers/char/hpet.c	Tue Aug 30 11:21:46 2005
>@@ -44,7 +44,7 @@
> /*
>  * The High Precision Event Timer driver.
>  * This driver is closely modelled after the rtc.c driver.
>- * http://www.intel.com/labs/platcomp/hpet/hpetspec.htm
>+ * http://www.intel.com/hardwaredesign/hpetspec.htm
>  */
> #define	HPET_USER_FREQ	(64)
> #define	HPET_DRIFT	(500)
>@@ -712,7 +712,7 @@
> 	ti->shift = 10;
> 	ti->addr = &hpetp->hp_hpet->hpet_mc;
> 	ti->frequency = hpet_time_div(hpets->hp_period);
>-	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
>+	ti->drift = HPET_DRIFT;
> 	ti->mask = -1;
> 
> 	hpetp->hp_interpolator = ti;
>
>
>
