Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131286AbRCHICB>; Thu, 8 Mar 2001 03:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRCHIBv>; Thu, 8 Mar 2001 03:01:51 -0500
Received: from mx0.gmx.net ([213.165.64.100]:33840 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S131286AbRCHIBh>;
	Thu, 8 Mar 2001 03:01:37 -0500
Date: Thu, 8 Mar 2001 09:01:15 +0100 (MET)
From: <konrad_lkml@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE bug in 2.4.2-ac12?
In-Reply-To: <20010307202016.B5030@suse.cz>
Message-ID: <31749.984038475@www28.gmx.net>
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009979400@gmx.net
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Authenticated-IP: [141.76.11.162]
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 06, 2001 at 09:32:46PM +0000, Paul Bristow wrote:
> > On Tuesday 06 March 2001 19:13, Konrad Stopsack wrote:
> > > Hello guys,
> > >
> > > I hope you've read my posting "DMA problem with ZIP drive and VIA
> > > VT82C598MVP / VT82C586B chip" (why does anybody answer?).
> > > I now tried the 2.4.2-ac12 kernel including the latest VIA 82c586b
> driver
> > > (version 3.21), but the effects were almost the same:
> > > - just when the kernel tried to access to the hard disk during boot,
> DMA
> > > errors were occured
> > > - "hdparm /dev/hda" displayed 9 MB per second (and not 11 MB like
> without
> > > ZIP) - /proc/ide/via reported 16 MB transfer rate (and not 33MB like
> > > without ZIP drive)
> > > - Kernel 2.4.2-ac12 reports a "ide-floppy: hdd: I/O error, pc = 5a,
> key = 
> > > 5, asc = 24, ascq =  0" error, 2.4.2 doesn't
> > >
> > > My IDE configuration is:
> > > /dev/hda: Hard disk  => Primary IDE controller
> > > /dev/hdc CD-ROM  => Secondary IDE controller
> > > /dev/hdd: ZIP           => Secondary IDE controller
> > >
> > > Could you please tell me whether it's a bug or a feature?
> > 
> > OK.  The ZIP drive can not handle uDMA, so it's normal for the 
secondary
> 
> > controller to drop back.  In my opinion, the primary controller should
> stay 
> > at uDMA speed, but it is PC hardware so it is perfectly possible there
> is 
> > something cheap that locks them together.  I will bring up ac-12 and
> check 
> > the error message...
> 
> Actually I'm beginning to suspect the PSU here ... does removing the
> CD-ROM (leaving just the HDD and the ZIP in) help? Does the ZIP cause
> errors even when connected just to the power cable (and not the IDE
> cable)?
> 
Do you mean the Power Supply Unit? Or the Program Storage Unit? ;-)

To answer to your questions:
 - I haven't tried to remove the CD-ROM because both devices shall work 
together
 - the ZIP doesn't cause problems when just the power cable is connected

Although my PC has only got an old Baby AT 200W power supply I don't think 
that's the point.

cu Konrad

-- 
Konrad Stopsack - konrad@stopsack.de

Sent through GMX FreeMail - http://www.gmx.net
