Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWEPLpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWEPLpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWEPLpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:45:14 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:13514 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S1751794AbWEPLpM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:45:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: ASUS A8V Deluxe, x86_64
Date: Tue, 16 May 2006 07:45:09 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ASUS A8V Deluxe, x86_64
Thread-Index: AcZ4V6DzMKFWMqwWTmO6SVx90qrDbAAgm7MA
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "Andi Kleen" <ak@suse.de>, "Marko Macek" <Marko.Macek@gmx.net>,
       "Jeff Garzik" <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2006 11:45:10.0011 (UTC) FILETIME=[2F68D4B0:01C678DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now I'm having an ASUS A8V Deluxe.... and sadly a lot of problems:
> > 
> > - My SATA Controller make my Linux crash when connecting a 
> > Plextor 716SA CD-DVD-R 
> > (http://bugzilla.kernel.org/show_bug.cgi?id=5533)

> Patch:
>
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-
git2-libata1.patch.bz2
> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
2.6.17-rcX[-gitY] kernels)

I gave a try at the latest ata patches announced yesterday by Jeff and
it completelly solved my SATA ATAPI bug.. I even been able to burn my
first DVD using my Plextor 716SA on my Linux!!!  Really nice and much
anticipated work!  Thnx a lot!

I have already marked bug 5533 as resolved and I'll wait until inclusion
into 2.6.18 to close it.  I've also marked bug 6317 has closed since
that did not occur since around rc2 or rc3 of 2.6.17.

I also ran a memtest86+ all night to make sure there where no problems
with my memory... And everything is fine so no problems there.

> "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA> writes:
> - My onboard network card either stops responding (using 
> sk98lin) or make my PC freeze (using skge)
> - My USB mouse goes crazy from times to times (at least every 
> few hours) until I remove ehci_hcd and uhci_hcd and readd uhci_hcd
> - My PC partially wakes up and freeze after a few hours of no usage

> On Monday 15 May 2006 21:23, Marko Macek wrote:
> > Andi Kleen wrote:
> > > "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA> writes:
> > >>> I also have A8V Deluxe.
> > >>> No real problems with single core A64 3000.
> > >>> But now with and X2 dual core CPU, I needed to disable
irqbalance 
> > >>> to get any stability.
> > See for example:
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182618

Wow.. This exactly resume all my other BUGS I have... And they where
quite hard to find actually... Thnx for the info.  I'll disable
irqbalance tonight for sure until there is a final fix into the kernel.
 
> Ok, that's new. We knew that SIS didn't like setting 
> interrupt affinity on IRQ 0. Maybe VIA forgot to validate one 
> of these cases too.
> we should probably do a kernel side fix. I'll put it on my todo list.

Thnx.. Would be really appreciated... And just ask if you need a tester!

Thanks to all of you!

- vin
