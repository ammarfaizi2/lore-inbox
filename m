Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSHCVyw>; Sat, 3 Aug 2002 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317911AbSHCVyw>; Sat, 3 Aug 2002 17:54:52 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38889 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317904AbSHCVyu>; Sat, 3 Aug 2002 17:54:50 -0400
Date: Sat, 3 Aug 2002 23:58:03 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pawel Kot <pkot@linuxnews.pl>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No Subject
In-Reply-To: <1028411118.1760.30.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0208032341220.24539-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Aug 2002, Alan Cox wrote:

> On Sat, 2002-08-03 at 20:26, Pawel Kot wrote:
> > What helped me was using fixup_device_piix() from -ac in
> > ide_scan_pcidev(). My controler's ID is DEVID_ICH3M.
> > It is used in a different, more generic way in -ac, so I don't post the
> > patch.
> >
> > Alan, Marcelo: is there any chance that this change will be ported from
> > -ac in 2.4.20?
>
> I plan to send Marcelo all the IDE updates. Note btw the checking of the
> return value on pci_enable_device is critical - some old kernels hang on
> boot with crappy bioses through not checking.

Of course it is critical :-).

> What I begin to the think the right answer is, is to relax the IDE fixup
> block in the i386 kernel boot up. Right now we avoid assigning
> unassigned resources for IDE controllers. Clearly we should be doing so.

I think so.
Andre what do you think?

And one more thing in ide-pci.c:ide_setup_pci_device() after explicitly
enabling device's IOs we may need to update dev->resource and we don't
do this (we place chipset in native mode so i.e. on VIA base addresses
are just showing up). How to update them?

Regards
--
Bartlomiej

