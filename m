Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132601AbRDXASf>; Mon, 23 Apr 2001 20:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRDXASZ>; Mon, 23 Apr 2001 20:18:25 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:14089 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132601AbRDXASM>;
	Mon, 23 Apr 2001 20:18:12 -0400
Date: Tue, 24 Apr 2001 02:17:56 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: John Fremlin <chief@bandits.org>
Cc: Pavel Machek <pavel@suse.cz>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010424021756.A931@pcep-jamie.cern.ch>
In-Reply-To: <E14pgBe-0003gg-00@the-village.bc.nu> <m2k84jkm1j.fsf@boreas.yi.org.> <20010420190128.A905@bug.ucw.cz> <m2snj3xhod.fsf@bandits.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2snj3xhod.fsf@bandits.org>; from chief@bandits.org on Sat, Apr 21, 2001 at 12:41:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> > > I'm wondering if that veto business is really needed. Why not reject
> > > *all* APM rejectable events, and then let the userspace event handler
> > > send the system to sleep or turn it off? Anybody au fait with the APM
> > > spec?
> > 
> > My thinkpad actually started blinking with some LED when you pressed
> > the button. LED went off when you rejected or when sleep was
> > completed.
> 
> Does the led start blinking when the system sends an apm suspend? In
> that case I don't think you'd notice the brief period between the
> REJECT and the following suspend from userspace ;-)

Are you sure?  A suspend takes about 5-10 seconds on my laptop.

(It was noticably faster with 2.3 kernels, btw.  Now it spends a second
or two apparently not noticing the APM event (though the BIOS is making
the speaker beep), then syncing the disk, then maybe another pause, then
maybe some more disk activity, then finally shutting down.  2.3 started
the disk activity immediately and didn't pause.  Perhaps 2.4.3 mm
problems?)

-- Jamie

