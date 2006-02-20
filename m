Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWBTSdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWBTSdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWBTSdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:33:14 -0500
Received: from smtp.enter.net ([216.193.128.24]:40461 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161113AbWBTSdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:33:13 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 20 Feb 2006 13:33:33 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602171545.21867.dhazelton@enter.net> <43F9D95C.nail4AL61JSZG@burner>
In-Reply-To: <43F9D95C.nail4AL61JSZG@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201333.34109.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 09:59, Joerg Schilling wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
> > > The namne space split is a Linux kernel bug
> >
> > Then why have I been talking about a unification with you?
> >
> > I would quote your comments on it, but since that was a private mail I
> > will not do so.
>
> ????
>
> I did not get any proposal for working on making ide-scsi work nor did
> I get a useful proposal that would explain how it might be done without
> ide-scsi.

Don't even start. In a private exchange you stated that you had been thinking 
of mapping ATA/ATAPI devices into a "middle" bus slot to remove the need for 
the "ATA" and "ATAPI" host identifiers and to allow libscg to scan the 
ATA/ATAPI bus at the same time it scans the SCSI bus on Linux systems.

I asked about using the numbers provided by Linux - ie. /dev/hda = 6,3,0 - and 
you said it was wrong and not useful. I've since asked you in another private 
mail if you have another solution I could code into the patch and don't 
expect a reply until tomorrow.

For the record, I am trying to work with you to resolve these problems, but at 
the moment the problem of unifying the scannign of the SCSI and ATA/ATAPI 
busses inside libscg in order to workaround the Kernel not providing access 
to ATA/ATAPI devices via /dev/sg* is stopped because of the problem of how to 
uniquely identify said devices and the problem with the kernel munging SCSI 
CDB's for certain devices is stopped because I don't have access to the 
hardware to see exactly what gets munged.

And since you've stated that the machine on which you could reproduce the 
problem died 3 years ago, I have to assume that the problem may have been 
fixed in the ensuing time period.

> > > > Bogus warnings about Linux are unfixed in said version.
> > >
> > > Warnings related to Linux kernel bugs
> >
> > From what I can tell a lot of the warnings are bogus. You even go to
> > great lengths to "scare" people into only using "official" versions of
> > cdrtools.
>
> They are related to serious problems.

Really? From what I've seen you mark sections "You cannot change this" to stop 
people from removing those warnings. In fact, there is code in cdrecord that 
relates to "bugs" in distribution patched versions that most likely do not 
exist anymore. "Serious problems", though? Seems you just love SCSI, fell in 
love with ide-scsi and can't let it go. I've been using cdrecord for more 
than six years now, the last two on a system without _ide-scsi_ and have yet 
to have a problem - so either the problems you call serious are not serious 
enough or I was lucky to build a system from spare parts that managed to 
dodge all those problems. By applying Occams razor, I find that the first is 
likely true.

DRH
