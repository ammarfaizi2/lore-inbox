Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSGMN6O>; Sat, 13 Jul 2002 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSGMN6N>; Sat, 13 Jul 2002 09:58:13 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:16278 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S313558AbSGMN6M>;
	Sat, 13 Jul 2002 09:58:12 -0400
Date: Sat, 13 Jul 2002 08:55:50 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <1026570328.9958.83.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207130840080.7697-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2002, Alan Cox wrote:

> On Sat, 2002-07-13 at 07:36, jbradford@dial.pipex.com wrote:
> > > Because we can't tell Linux users "your (once favorite) CD-ROM is not 
> > > implemented in Linux (any more), and will never ever be". If we explicitly 
> > > exclude hardware, where do we end?!
> > 
> > Like other mainstream operating systems :-)
> > 
> > One thing that occurs to me, but that I don't necessarily think is a good idea,
> > is that for a long time we had "old" IDE code and "new" IDE code in the kernel,
> > and there is no reason why we couldn't do a similar thing, (I.E. have
> > a "legacy devices will work" foo driver, and "legacy devices might 
> 
> So we'd have a legacy driver called oh say 'ide-cd' and a current one
> called 'ide-scsi'.
> 
> How does that change anything ?

It gives us the possibility to create a "clean" design for modern hardware 
while maintaining support for "legacy" hardware.  You don't have to carry 
around a lot of special cases and distort the design to take into account 
something that almost no one uses.  

One of the reasons I despise that other operating system is the way it 
carries around bloat, cruft, and crap(!) to support ancient DOS stuff.  
Having your legacy and current drivers gives the best of both worlds, 
supporting ancient stuff while maintaining clean code for modern stuff.


