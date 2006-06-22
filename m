Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161353AbWFVWOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWFVWOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161361AbWFVWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:14:13 -0400
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:47321
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S1161353AbWFVWOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:14:11 -0400
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Mike Snitzer'" <snitzer@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driverfor PDC202XX
Date: Thu, 22 Jun 2006 18:14:11 -0400
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAFNOcfb+kkVMpHsOPV+l1GoBAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcaVOdN12k1vvUnrQj2TP3+RiLMuvQBDuZQw
In-Reply-To: <1150898829.15275.69.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Success!

I have to admit that without the hint from Mike Snitzer, I wouldn't have put
it all together.  The key piece of information that he provided was:

> From: Mike Snitzer [mailto:snitzer@gmail.com] 
> Sent: Thursday, June 22, 2006 12:40 AM
> To: Erik@echohome.org
> Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A 
> functional Driverfor PDC202XX
> 
> Alan's initial response to you was:

<snip>

> But looking closer it is clear that the 
> drivers/scsi/pata_pdc2027x.c source file provides support for 
> your 20268 card.  But the Kconfig and makefile changes to 
> expose this driver in an official way weren't included in 
> Alan's patch.  So you just need to add something like the 
> following to drivers/scsi/Makefile:
> 
> obj-$(CONFIG_SCSI_PATA_PDC)     += libata.o pata_pdc2027x.o
> 
> Similarly you need a new entry in drivers/scsi/Kconfig that 
> resembles something like:
> 
> config SCSI_PATA_PDC
>        tristate "Newer Promise PATA controller support 
> (Raving Lunatic)"
>        depends on SCSI_SATA && PCI && EXPERIMENTAL
>        help
>          This option enables support for the Promise 20268 through
> 20277 adapters.
> 
>          If unsure, say N.
> 
> Once you modify those 2 files and select the "Newer Promise ..."
> option with make menuconfig; then rebuild with 'make' you 
> should see something like:
> 
> > make

Many thanks Mike!

