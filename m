Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135849AbRDYM2u>; Wed, 25 Apr 2001 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135851AbRDYM2m>; Wed, 25 Apr 2001 08:28:42 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6660 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135849AbRDYM20>;
	Wed, 25 Apr 2001 08:28:26 -0400
Message-ID: <20010424120649.A23347@bug.ucw.cz>
Date: Tue, 24 Apr 2001 12:06:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        John Fremlin <chief@bandits.org>
Cc: Pavel Machek <pavel@suse.cz>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu> <m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz> <m2snj3xhod.fsf@bandits.org> <20010424021756.A931@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010424021756.A931@pcep-jamie.cern.ch>; from Jamie Lokier on Tue, Apr 24, 2001 at 02:17:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I'm wondering if that veto business is really needed. Why not reject
> > > > *all* APM rejectable events, and then let the userspace event handler
> > > > send the system to sleep or turn it off? Anybody au fait with the APM
> > > > spec?
> > > 
> > > My thinkpad actually started blinking with some LED when you pressed
> > > the button. LED went off when you rejected or when sleep was
> > > completed.
> > 
> > Does the led start blinking when the system sends an apm suspend? In
> > that case I don't think you'd notice the brief period between the
> > REJECT and the following suspend from userspace ;-)
> 
> Are you sure? A suspend takes about 5-10 seconds on my laptop.

Ouch? Really?

What  I do is killall apmd, then apm -s and it is more or less
instant. [Are you using suspend-to-disk? AFAICS my toshiba can not do
suspend to disk, that's why I'm interested].

> (It was noticably faster with  2.3 kernels, btw. Now it spends a second
> or two apparently not noticing the APM event (though the BIOS is making
> the speaker beep ), then syncing the disk, then maybe another pause, then
> maybe some more disk activity, then finally shutting down. 2.3 started
> t he disk activity immediately and didn't pause. Perhaps 2.4.3 mm
> problems?)

Take a look what apmd does. I'm killing it before apm -s.
								Pavel
