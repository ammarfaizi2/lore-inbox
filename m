Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTGKQJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTGKQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:09:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28061 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264039AbTGKQJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:09:05 -0400
Date: Fri, 11 Jul 2003 18:23:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
In-Reply-To: <20030711155843.GD2210@gtf.org>
Message-ID: <Pine.SOL.4.30.0307111809500.17195-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Jeff Garzik wrote:

> On Fri, Jul 11, 2003 at 04:55:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > - The hptraid/promise RAID drivers are currently non functional, and
> > > >   will probably be converted to use device-mapper.
> >
> > Please put software RAID here to avoid confusion.
>
> That introduces confusion with dev/md, which is what people have
> traditionally called software RAID, IMO...

s/software RAID/propertiary software RAIDs/

> I like arjan's "fakeraid" or "ataraid" names.  ;-)

"fakeraid" sounds good. :-)

> > > > IDE.
> > > > ~~~~
> > > > - Known problems with the current IDE code.
> > > >   o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
> > > FIXED
> > > >   o  PCMCIA IDE hangs on eject
> > > Should be fixed in 2.5, fixed(ish) in 2.4
> > > >   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> > > >      either use 2.4 or fix it 8)
> > > > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> > > >   are no longer supported. The only way forward is to remove the translator
> > > >   from the drive, and start over.
> > >
> > > Or to use device mapper to remap the disk.
> >
> > "hdx=remap" and "hdx=remap63" boot options can be used.
> > Or can I remove them?
>
> You can remove them... if there is a userspace component that handles
> this.  As much as I would love to do so, we can't just remove components
> that DM _can_ handle ;-) ;-)  If so, we could go ahead and remove MD
> raid0 too, and such.

How userspace component can help if you have ie. On-Track DM
on your boot device?

I think you missed my point :-).

I think if somebody adds On-Track and EZ auto-detection to device mapper
I can safely remove these ide boot options...

--
Bartlomiej

> 	Jeff

