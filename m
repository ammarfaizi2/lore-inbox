Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWBCCgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWBCCgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 21:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWBCCgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 21:36:46 -0500
Received: from mail.tmr.com ([64.65.253.246]:40208 "EHLO firewall2.tmr.com")
	by vger.kernel.org with ESMTP id S964856AbWBCCgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 21:36:45 -0500
Date: Thu, 2 Feb 2006 21:36:41 -0500 (EST)
From: Bill Davidsen <tmrbill@tmr.com>
Reply-To: davidsen@tmr.com
To: Pavel Machek <pavel@ucw.cz>
cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
In-Reply-To: <20060202201943.GB2264@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0602022134260.12829-100000@firewall2.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, Pavel Machek wrote:

>      
> X-UID: 40919
> 
> On Čt 02-02-06 14:40:28, Bill Davidsen wrote:
> > Pavel Machek wrote:
> > >On Mon 30-01-06 18:30:29, Bill Davidsen wrote:
> > >
> > >>Please take this as a question to elicit information, not 
> > >>an invitation for argument.
> > >>
> > >>In Linux currently:
> > >>SCSI - liiks like SCSI
> > >>USB - looks like SCSI
> > >>Firewaire - looks like SCSI
> > >>SATA - looks like SCSI
> > >>Compact flash and similar - looks like SCSI
> > >
> > >
> > >Your definition of "looks like scsi" is way too broad. CF looks like
> > >PCMCIA and that in turn is ide chip on isa-like bus.
> > >
> > >(unless you plug it to usb reader)
> > >
> > I was unaware of any serious use of PCMCIA reader cards therese days, as 
> > you note the CD shows up as an sd device. I have a laptop which might 
> > have a card slot, if it takes CD I'll pull one from my camera and try it 
> > there instead of the USB reader.
> 
> CD? Did you want to say CF?

Yes, thanks.
> 
> Anyway it is not really PCMCIA reader. It is just PCMCIA-to-CF
> adapter, plugged into PCMCIA slot. Adapter is pretty much passive. 
> 
> > The question is still why not make all devices look like SCSI, and use 
> > one set of drivers and a bit of glue. Redhat used to use ide-scsi by 
> > default if my memory serves, and the overhead wasn't an issue even back 
> > on my 1st Linux laptop running Slackware on a Thinkpad 486-25 (the fat 
> > one, not the 486-16 -;).
> 
> CF card is as much ide as it can get. You can even pug it to IDE cable
> with passive adapter!
> 
> Forcing everything to SCSI makes about as much sense as making
> everything look like IDE.

No, we have the way to make everything look like SCSI now, ide-scsi. We 
can't make (real) SCSI look like IDE. And if you are using IDE instead of 
ATAPI (non-SCSI command set?) you would ahve to stay with an older kernel.

> 							Pavel

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
Doing interesting things with little computers since 1979

