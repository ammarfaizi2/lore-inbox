Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSLMOhb>; Fri, 13 Dec 2002 09:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSLMOhb>; Fri, 13 Dec 2002 09:37:31 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:16791 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264705AbSLMOha>;
	Fri, 13 Dec 2002 09:37:30 -0500
Date: Fri, 13 Dec 2002 15:41:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>,
       Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE feature request & problem
Message-ID: <20021213154156.A6001@ucw.cz>
References: <021401c2a05d$f1c72c80$551b71c3@krlis> <1039540202.14251.43.camel@irongate.swansea.linux.org.uk> <039d01c2a0ab$b19a5ad0$551b71c3@krlis> <1039569643.14166.105.camel@irongate.swansea.linux.org.uk> <20021211210416.A506@ucw.cz> <20021212181250.GB184@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021212181250.GB184@elf.ucw.cz>; from pavel@suse.cz on Thu, Dec 12, 2002 at 07:12:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 07:12:50PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > I have got xfs partition and man fsck.xfs say
> > > > that it will run automatically on reboot.
> > > 
> > > You need to force one. Something (I assume XFS) asked the disk for a
> > > stupid sector number. Thats mostly likely due to some kind of internal
> > > corruption on the XFS
> > 
> > Or the power supply doesn't give enough power to the drives anymore (my
> > 350W PSU is having heavy problems with five or more drives), and the IDE
> > transfers get garbled. Note that there is no CRC protection for non-data
> > xfers even when UDMA is in use, which includes LBA sector addressing.
> 
> But kernel would not log bogus LBA in such case.

It could, if the drive has read a different sector than it was supposed
to and the filesystem got confused by the data ...

-- 
Vojtech Pavlik
SuSE Labs
