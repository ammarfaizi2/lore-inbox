Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTLINGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbTLINGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:06:51 -0500
Received: from gaia.cela.pl ([213.134.162.11]:37905 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265624AbTLINGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:06:09 -0500
Date: Tue, 9 Dec 2003 14:03:42 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Greg KH <greg@kroah.com>, Witukind <witukind@nsbm.kicks-ass.org>,
       <recbo@nishanet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
In-Reply-To: <1070963757.869.86.camel@nomade>
Message-ID: <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Am I wrong ?

> > No, you are correct.  That's why I'm not really worried about this, and
> > I don't think anyone else should be either.

You are of course totally wrong - just because a device is present in the 
system doesn't mean that it's kernel modules are loaded - for example my 
floppy is always present in the system, but I access it like once a month 
or so - currently devfs (which I'm using on 3 computers with no problems 
for over a year now) will load the floppy module on access to /dev/fd0 and 
the module will unload automatically a few dozen minutes later after I'm 
done with the disk drive. On an 8 MB mem system keeping 60KB floppy 
driver non-stop in unswappable kernel memory is wastefull.  Especially 
since this also applies to microcode, sound drivers, scanners, rtc, etc...  
The system is properly configured - the modules for devices are loaded 
when needed - just because a device is present doesn't mean we need to 
have the driver loaded for it.

> A:	Such a functionality isn't needed on a properly configured
> 	system. All devices present on the system should generate
> 	hotplug events, loading the appropriate driver, and udev
> 	should notice and create the appropriate device node.
> 	In case of failure, please make a proper bug report.

Cheers,
MaZe.


