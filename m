Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316899AbSFDWyg>; Tue, 4 Jun 2002 18:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316900AbSFDWyf>; Tue, 4 Jun 2002 18:54:35 -0400
Received: from [209.184.141.168] ([209.184.141.168]:63846 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S316899AbSFDWyf>;
	Tue, 4 Jun 2002 18:54:35 -0400
Subject: Re: Load kernel module automatically
From: Austin Gonyou <austin@digitalroadkill.net>
To: Jan Hudec <bulb@ucw.cz>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020604222743.GA15714@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 04 Jun 2002 17:54:30 -0500
Message-Id: <1023231270.9282.23.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 17:27, Jan Hudec wrote:
> On Tue, Jun 04, 2002 at 03:38:06PM -0400, Michael Zhu wrote:
> > Hi, I built a kernel module. I can load it into the
> > kernle using insmod command. But each time when I
> > reboot my computer I couldn't find it any more. I mean
> > I need to use the insmod to load the module each time
> > I reboot the computer. How can I modify the
> > configuration so that the Linux OS can load my module
> > automatically during reboot? I need to copy my module
> > to the following directory?
> >   /lib/modules/2.4.7-10/
> 
> Kernel does not seek for modules to load in any way. Actually, in usual
> installation there are tons of modules compiled an mostly unused. You
> must put the insmod command (or better modprobe command) somewhere in
> the init scripts. Since I expect your installation is RedHat (the kernel
> version looks like a RedHat one), there should already be one a it
> should be loading all modules listed in /etc/modules.conf (not sure abou
> the exact name - I don't have RedHat).

Isn't that what modules.conf (conf.modules on some) is for though? To
have lists of available devices and load modules if their services are
used?(i.e. ifup eth0, but eth0 doesn't exist at boot time, so ifup calls
a utility that loads the module, then ifup continues to run)


> --------------------------------------------------------------------------------
>                   				- Jan Hudec `Bulb' <bulb@ucw.cz>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
