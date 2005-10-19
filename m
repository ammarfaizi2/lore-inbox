Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVJSPIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJSPIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVJSPIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:08:11 -0400
Received: from fmr24.intel.com ([143.183.121.16]:34248 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751072AbVJSPIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:08:09 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 0/7] more HPET fixes and enhancements
Date: Wed, 19 Oct 2005 08:08:02 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60060C331C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/7] more HPET fixes and enhancements
Thread-Index: AcXUtASUVOppZm6tQFWR0ipqdXoyZgACtwAg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Clemens Ladisch" <clemens@ladisch.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Oct 2005 15:08:03.0560 (UTC) FILETIME=[E7133E80:01C5D4BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Clemens Ladisch
>Sent: Wednesday, October 19, 2005 6:49 AM
>To: Randy.Dunlap
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
>
>I wrote:
>> This means that hpet.c must initialize the interrupt routing register
>> in this case.  I'll write a patch for this.
>
>Okay, this is a quick hack, untested.  It just tries to set the first
>interrupt that the timer could use.
>


You will need more changes to make interrupt work. Especially if the
particular IRQ that you are using here is not used by any other PCI
device in the system. Then BIOS won't report anything on that IRQ and
all the things done in setup_IO_APIC_irqs() should be done for this
particular IRQ. And it will depend on whether IOAPIC/PIC is ised for
interrupts and such things as well. Atleast that what I remember from
last time I got HPET to work with IRQs other than IRQ0 and IRQ8.

Thanks,
Venki

