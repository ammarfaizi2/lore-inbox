Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSI3P1y>; Mon, 30 Sep 2002 11:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSI3P1y>; Mon, 30 Sep 2002 11:27:54 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:44928 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261211AbSI3P1x>; Mon, 30 Sep 2002 11:27:53 -0400
Date: Mon, 30 Sep 2002 11:33:19 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020930153319.GA18695@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929153817.GC1014@suse.de>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:38:17PM +0200, Jens Axboe wrote:
> On Sun, Sep 29 2002, Alan Cox wrote:
> > Most of my boxes won't even run a 2.5 tree yet. I'm sure its hardly
> > unique. Middle of November we may begin to find out how solid the core
> > code actually is, as drivers get fixed up and also in the other
> > direction as we eliminate numerous crashes caused by "fixed in 2.4" bugs
> 
> Well why don't they run with 2.5?
> 
> Alan, I think you are a pessimist painting a much bleaker picture of 2.5
> than it deserves. Sure lots of drivers may be broken still, I would be
> naive if I thought that this is all changed in time for oct 31. Most of
> these will not be fixed until people actually _use_ 2.5 (or 3.0-pre, or
> whatever it will be called), and that will not happen until Linus
> actually releases a -rc or similar. And so the fsck what? Noone expects
> 2.6-pre/3.0-pre to be perfect.

Ok, after losing a disk in the early 2.5 series, and not being able to
compile pretty much any kernel since 2.5.33, I decided to give 2.5.39 a
try last weekend.

Built kernel, rebooted, almost seems to get stuch during the ide-probing
(10 seconds wait is a conservative estimate), but it came up in single
user. Checking for errors in /proc/kmsg, nothing. Great reboot
multiuser start X open a window lose all access to my keyboard. Completely
log in remotely with ssh, hmm kernel errors about unknown scancodes.

Reboot, just don't use X for the moment, maybe I can catch an oops,
lockup during boot while loading the uhci usb driver. Alt-sysrq works,
another fsck later (these seem to take a lot longer, but that could be
subjective). Disable hotplug/usb during startup, reboot, within 2
minutes orinoco_cs driver locks up and starts throwing debugging goo
about transmit timeouts and resetting card. Nice, except for the fact
that interrupts seem to be disabled and this time magic-sysrq doesn't
work.

Pull the battery out to be able to reboot the laptop, and went back to
2.4.20-latest for now. 2.5.33 did work mostly (after fixing up a bunch
of compile fixes and the oss cs4281 driver), but seems to last only
about 1 hour on battery life vs. the solid 3 1/2 hours with a 2.4 kernel.
All of this is on a Thinkpad X20, which doesn't have a serial console.

Using APM, not ACPI. But this is not a bugreport, because I haven't even
got a chance to isolate any single problem in a way that I can create a
useful report.

> I'm not worried.

I am a bit worried, at least as far as Coda is concerned, there is a lot
of unmerged stuff, and as long as I can't do any testing of the changes
it is a bit useless to send them off to Linus. I hope things stabilize
before the feature freeze.

Jan

