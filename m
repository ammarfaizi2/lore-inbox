Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSFGHqf>; Fri, 7 Jun 2002 03:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316801AbSFGHqe>; Fri, 7 Jun 2002 03:46:34 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:23729
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S316788AbSFGHqe>; Fri, 7 Jun 2002 03:46:34 -0400
Message-ID: <20020607074629.27617.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org,
        dag@newtech.fi
Subject: Re: Devfs strangeness in 2.4.18 
In-Reply-To: Message from Richard Gooch <rgooch@ras.ucalgary.ca> 
   of "Thu, 06 Jun 2002 17:04:15 MDT." <200206062304.g56N4Fg05480@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 10:46:29 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ruth Ivimey-Cook writes:
> > On Thu, 6 Jun 2002, Dag Nygren wrote:
> > 
> > >The problems are tha the sg? links doesn't correspond to the real
> > >devices shown by /proc/scsi/scsi (Which matches the real situation)
> > >sg0 matches the first disk, OK
> > >sg1 matches the Medium changer, OK
> > >sg2 matches nothing...... There is no target 2 on host1 !!!
> > >sg3 matches the DLT tape drive
> > >sg4 matches the DAT tape drive
> > >
> > >The other problem is the st? links.
> > >st0 is linked out into nothing ...
> > >
> > >Seems like 3 host adapters is too much for devfs......
> > >Do I need an upgrade ?
> > 
> > In my experience, devfs doesn't create /dev/sg or /dev/st softlinks.
> 
> Indeed. It's devfsd that creates it.
> 
> > The only links it creates are from /dev/discs/... to /dev/ide/... or
> > /dev/scsi/... as appropriate.
> > 
> > I would look into the mandrake boot sequence in detail.
> 
> Also check that you don't have bogus entries in your dev-state
> area. Mandrake had some configuration problems a few months back.

Yess!!!
That's what did it, removing the sg? and st? entries from /lib/dev-state
did the trick. There were some oldies ghosting there. Thanks a lot 
Richard, I didn't even know that there was a dev-state directory to
look for ;-).
Is there any comprehensive documentation on devfsd and devfs anywhere
on the net? Could be good to read a bit more about this.

BRGDS

Dag


