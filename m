Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSFDX0V>; Tue, 4 Jun 2002 19:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSFDX0U>; Tue, 4 Jun 2002 19:26:20 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:7116 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S317471AbSFDX0R>; Tue, 4 Jun 2002 19:26:17 -0400
Message-ID: <3CFD4CCE.9DB9BF52@cfl.rr.com>
Date: Tue, 04 Jun 2002 19:27:10 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Austin Gonyou <austin@digitalroadkill.net>
CC: Jan Hudec <bulb@ucw.cz>, kernelnewbies@nl.linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <20020604193806.58478.qmail@web14905.mail.yahoo.com>
		  <20020604222743.GA15714@artax.karlin.mff.cuni.cz> <1023231270.9282.23.camel@UberGeek>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Austin Gonyou wrote:
> 
> On Tue, 2002-06-04 at 17:27, Jan Hudec wrote:
> > On Tue, Jun 04, 2002 at 03:38:06PM -0400, Michael Zhu wrote:
> > > Hi, I built a kernel module. I can load it into the
> > > kernle using insmod command. But each time when I
> > > reboot my computer I couldn't find it any more. I mean
> > > I need to use the insmod to load the module each time
> > > I reboot the computer. How can I modify the
> > > configuration so that the Linux OS can load my module
> > > automatically during reboot? I need to copy my module
> > > to the following directory?
> > >   /lib/modules/2.4.7-10/
> >
> > Kernel does not seek for modules to load in any way. Actually, in usual
> > installation there are tons of modules compiled an mostly unused. You
> > must put the insmod command (or better modprobe command) somewhere in
> > the init scripts. Since I expect your installation is RedHat (the kernel
> > version looks like a RedHat one), there should already be one a it
> > should be loading all modules listed in /etc/modules.conf (not sure abou
> > the exact name - I don't have RedHat).
> 
> Isn't that what modules.conf (conf.modules on some) is for though? To
> have lists of available devices and load modules if their services are
> used?(i.e. ifup eth0, but eth0 doesn't exist at boot time, so ifup calls
> a utility that loads the module, then ifup continues to run)
> 
The utility is built into the kernel, it's called kmod and uses /etc/modules.conf
as it's config file....


Mark
