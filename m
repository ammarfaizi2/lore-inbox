Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGKPoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTGKPoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:44:04 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:50644
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263861AbTGKPoB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:44:01 -0400
Date: Fri, 11 Jul 2003 11:58:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711155843.GD2210@gtf.org>
References: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:55:39PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > - The hptraid/promise RAID drivers are currently non functional, and
> > >   will probably be converted to use device-mapper.
> 
> Please put software RAID here to avoid confusion.

That introduces confusion with dev/md, which is what people have
traditionally called software RAID, IMO...

I like arjan's "fakeraid" or "ataraid" names.  ;-)


> > > IDE.
> > > ~~~~
> > > - Known problems with the current IDE code.
> > >   o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
> > FIXED
> > >   o  PCMCIA IDE hangs on eject
> > Should be fixed in 2.5, fixed(ish) in 2.4
> > >   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
> > >      either use 2.4 or fix it 8)
> > > - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
> > >   are no longer supported. The only way forward is to remove the translator
> > >   from the drive, and start over.
> >
> > Or to use device mapper to remap the disk.
> 
> "hdx=remap" and "hdx=remap63" boot options can be used.
> Or can I remove them?

You can remove them... if there is a userspace component that handles
this.  As much as I would love to do so, we can't just remove components
that DM _can_ handle ;-) ;-)  If so, we could go ahead and remove MD
raid0 too, and such.

	Jeff



