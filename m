Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSHWDMX>; Thu, 22 Aug 2002 23:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSHWDMX>; Thu, 22 Aug 2002 23:12:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34824
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318141AbSHWDMW>; Thu, 22 Aug 2002 23:12:22 -0400
Date: Thu, 22 Aug 2002 20:14:59 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
In-Reply-To: <m1ofbupfe1.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10208222014450.13077-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2002, Eric W. Biederman wrote:

> Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> > Eric W. Biederman wrote:
> > > I don't see any checking for the ATA bsy flag before you start sending
> > > commands.  I have seen the current IDE code fail too many times if I
> > > boot to fast, because of a lack of this one simple test.  So I don't
> > > see how this could be considered a proper probe.
> > 
> > 
> > There is no ATA bsy flag check at only one point, and that is before EXECUTE
> > DEVICE DIAGNOSTIC is issued.  The idea with this command is that it pretty much
> > stomps up and down the ATA bus, trouncing ongoing activity in the process.
> 
> The problem is that immediately after bootup ATA devices do not respond until
> their media has spun up.  Which is both required by the spec, and observed in
> practice.   Which is likely a problem if this code is run a few seconds after
> bootup.  Which makes it quite possible the drive will ignore the EXECUTE DEVICE
> DIAGNOSTICS and your error code won't be valid when the bsy flag
> clears.   I don't know how serious that would be. 

We did POST already.

> I can test and find out but I would rather confine my testing to
> commands that look like they will stay within the realms of
> predictable behavior.
> 
> And yes with LinuxBIOS I can reliably boot up fast enough to make this
> problem show up in practice.
> 
> Eric
> 

Andre Hedrick
LAD Storage Consulting Group

