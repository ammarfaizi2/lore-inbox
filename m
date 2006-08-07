Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWHGUsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWHGUsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWHGUsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:48:54 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15055 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932260AbWHGUsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:48:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jason Lunz <lunz@gehennom.net>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Mon, 7 Aug 2006 22:47:59 +0200
User-Agent: KMail/1.9.3
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz,
       linux-pm@osdl.org, linux-ide@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex>
In-Reply-To: <20060807162322.GA17564@knob.reflex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608072247.59184.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 18:23, Jason Lunz wrote:
> In gmane.linux.kernel, you wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> >
> > I tried it and guess what :)... swsusp doesn't work :@.
> >
> > This time I was able to dump process states with sysrq-t:
> > http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> >
> > My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
> > suspending device 2.0
> 
> Does it go away if you revert this?
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> 
> That should only affect resume, not suspend, but it does mess around
> with ide power management. Is this maybe happening on the *second*
> suspend?
> 
> > -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> > +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> 
> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.

I found that git-block.patch broke the suspend for me.  Still have no idea
what's up with it.

Rafael
