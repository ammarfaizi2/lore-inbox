Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHJTmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHJTmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWHJTlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:41:50 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:59117 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750829AbWHJTli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:41:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Jason Lunz <lunz@falooley.org>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 21:40:36 +0200
User-Agent: KMail/1.9.3
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Stefan Seyfried <seife@suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
In-Reply-To: <20060810190222.GA12818@knob.reflex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608102140.36733.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 21:02, Jason Lunz wrote:
> In gmane.linux.kernel, you wrote:
> > You make it sound much worse than it is. Apart for HPA, I'm not aware of
> > any setups that require extra treatment. And the amount of reported bugs
> > against it are pretty close to zero :-)

No, it's not.

> *ahem*.
> 
> I needed to do this to cure IDE hangs on resume:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> 
> Are you watching the suspend mailing lists? There's no shortage of them:
> 
> suspend-devel:	http://dir.gmane.org/gmane.linux.kernel.suspend.devel
> linux-pm:	http://dir.gmane.org/gmane.linux.power-management.general
> suspend2-devel:	http://dir.gmane.org/gmane.linux.swsusp.devel
> suspend2-users:	http://dir.gmane.org/gmane.linux.swsusp.general
> 
> I'm currently trying to help out one Sheer El-Showk, whose piix ide
> requires 30 seconds of floundering followed by a bus reset to resume:
> 
> http://thread.gmane.org/gmane.linux.kernel.suspend.devel/276/focus=347
> 
> But I know next-to-nothing about ATA.
> 
> It's not surprising you're not getting many bug reports. It's common for
> several things to go wrong during s2ram, and the user often ends up
> looking at a hung system with a dead screen. It takes some quality time
> with netconsole to even begin to narrow down that it's IDE hanging the
> system, after which you can *begin* solving the no-video-on-resume
> issue.

I agree.  Moreover, the disk-related resume-from-ram problems are the hardest
ones (the graphics may be handled from the user land to a reasonable extent).

Actually, I'm looking for someone who'd agree to be Cced on bug reports where
we suspect the problem may be related to IDE/PATA/SATA . ;-)

Greetings,
Rafael
