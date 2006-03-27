Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWC0WA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWC0WA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWC0WA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:00:56 -0500
Received: from anubis.pendulus.net ([38.119.36.60]:14468 "EHLO
	anubis.pendulus.net") by vger.kernel.org with ESMTP
	id S1751494AbWC0WAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:00:55 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Bill Rugolsky Jr." <bill@rugolsky.com>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Date: Mon, 27 Mar 2006 17:00:53 -0500
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <20060327160845.GG9411@ti64.telemetry-investments.com> <200603271646.55317.lkml@lpbproductions.com>
In-Reply-To: <200603271646.55317.lkml@lpbproductions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271700.53641.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to include this.. but here's my bios version 

        Vendor: Phoenix Technologies, LTD
        Version: 6.00 PG
        Release Date: 06/23/2005

On Monday 27 March 2006 4:46 pm, Matt Heler wrote:
> Hey Bill,
>
> I spoke abit to soon though regarding that stability.. After booting up X
> and running Azerues and kde, my system stalled and locked. However it
> lasted much longer then Jeff's version.
>
> I'm running the DFI Lanparty with an Athlon 4400. I also have the following
> setup
>
> 2x300gb seagate drives 7200.8 in a raid0 format with ext3
> 2x400gb seagate drives 7200.9 again in a raid0 format with ext3
>
> and lspci gives me the following ::
>
> 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
> 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev
> a3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> (rev a3)
>
> On Monday 27 March 2006 11:08 am, Bill Rugolsky Jr. wrote:
> > On Sun, Mar 26, 2006 at 08:14:35PM -0500, Matt Heler wrote:
> > > Using Bill's original patch I was able to boot up perfectly with adma
> > > support enabled on my workstation. Even after several stress tests (
> > > tar -cf /dev/null . , and dd if=/dev/sda of=/dev/null ), everything
> > > seems to be a-ok. However when I tried the sata_nv.c file that you sent
> > > to Bill, I kept on getting hardlocks, and thus was unable to stress
> > > test your version.
> > >
> > > Also for note, I heve not received any of the timeout problems reported
> > > by Bill. Nor have I had any latency problems with adma enabled.
> >
> > Matt,
> >
> > Nice to see some value falling out of this sata_nv thread.  Did you see
> > latency problems before enabling ADMA?
> >
> > Would you provide some specifics on your setup?
> >
> > Which motherboard, #CPUs, BIOS revision, kernel, MD/LVM2/fs?
> >
> > On two of my Tyan S2895 machines, including the one that I'm using for
> > testing, lspci says:
> >
> > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
> > 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> > (rev f3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
> > Controller (rev f3)
> >
> > and dmidecode says:
> >
> > BIOS Information
> >         Vendor: Phoenix Technologies Ltd.
> >         Version: 2004Q3
> >         Release Date: 10/12/2005
> >
> > The other, where I first had lost tick problems, says:
> >
> > 00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
> > 00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller
> > (rev a3) 00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
> > Controller (rev a3)
> >
> > BIOS Information
> > 	Vendor: Phoenix Technologies Ltd.
> > 	Version: 2004Q3
> > 	Release Date: 06/07/2005
> >
> >
> > Thanks,
> >
> > 	Bill
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
