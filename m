Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135866AbRDYO3Z>; Wed, 25 Apr 2001 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135869AbRDYO3Q>; Wed, 25 Apr 2001 10:29:16 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:51467 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135866AbRDYO3A>;
	Wed, 25 Apr 2001 10:29:00 -0400
Date: Wed, 25 Apr 2001 16:28:52 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: John Fremlin <chief@bandits.org>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010425162851.D18214@pcep-jamie.cern.ch>
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu> <m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz> <m2snj3xhod.fsf@bandits.org> <20010424021756.A931@pcep-jamie.cern.ch> <20010424120649.A23347@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424120649.A23347@bug.ucw.cz>; from pavel@suse.cz on Tue, Apr 24, 2001 at 12:06:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > Are you sure? A suspend takes about 5-10 seconds on my laptop.
> 
> Ouch? Really?

No, I was thinking of one of the earlier 2.4 kernels.  2.4.3 seems
faster again.

> What  I do is killall apmd, then apm -s and it is more or less
> instant. [Are you using suspend-to-disk? AFAICS my toshiba can not do
> suspend to disk, that's why I'm interested].

Mind doesn't do suspend-to-disk either.  I think it can with Windows but
I've never run Windows on it to find out :-)

I've always presumed the disk activity that starts after closing the lid
and before powering down is due to the kernel, or maybe apmd, calling
sync().

> > (It was noticably faster with  2.3 kernels, btw. Now it spends a second
> > or two apparently not noticing the APM event (though the BIOS is making
> > the speaker beep ), then syncing the disk, then maybe another pause, then
> > maybe some more disk activity, then finally shutting down. 2.3 started
> > t he disk activity immediately and didn't pause. Perhaps 2.4.3 mm
> > problems?)
> 
> Take a look what apmd does. I'm killing it before apm -s.

Hmm.  Perhaps apmd needs a "do not sync" option, for when you don't care.

-- Jamie
