Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFFXEU>; Thu, 6 Jun 2002 19:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSFFXET>; Thu, 6 Jun 2002 19:04:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10881 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312254AbSFFXET>; Thu, 6 Jun 2002 19:04:19 -0400
Date: Thu, 6 Jun 2002 17:04:15 -0600
Message-Id: <200206062304.g56N4Fg05480@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org
Subject: Re: Devfs strangeness in 2.4.18
In-Reply-To: <Pine.LNX.4.44.0206062312530.16968-100000@sharra.ivimey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook writes:
> On Thu, 6 Jun 2002, Dag Nygren wrote:
> 
> >The problems are tha the sg? links doesn't correspond to the real
> >devices shown by /proc/scsi/scsi (Which matches the real situation)
> >sg0 matches the first disk, OK
> >sg1 matches the Medium changer, OK
> >sg2 matches nothing...... There is no target 2 on host1 !!!
> >sg3 matches the DLT tape drive
> >sg4 matches the DAT tape drive
> >
> >The other problem is the st? links.
> >st0 is linked out into nothing ...
> >
> >Seems like 3 host adapters is too much for devfs......
> >Do I need an upgrade ?
> 
> In my experience, devfs doesn't create /dev/sg or /dev/st softlinks.

Indeed. It's devfsd that creates it.

> The only links it creates are from /dev/discs/... to /dev/ide/... or
> /dev/scsi/... as appropriate.
> 
> I would look into the mandrake boot sequence in detail.

Also check that you don't have bogus entries in your dev-state
area. Mandrake had some configuration problems a few months back.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
