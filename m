Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVFGIp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVFGIp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 04:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVFGIp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 04:45:59 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:26329 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261794AbVFGIpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 04:45:50 -0400
Date: Tue, 7 Jun 2005 10:45:42 +0200
From: Voluspa <voluspa@telia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: grant_lkml@dodo.com.au, lista1@telia.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Linux v2.6.12-rc6
Message-Id: <20050607104542.66309852.voluspa@telia.com>
In-Reply-To: <21d7e997050607004411bfa36b@mail.gmail.com>
References: <20050607081116.65c10190.lista1@telia.com>
	<20050607061831.GA6957@elte.hu>
	<20050607083731.5edfd276.lista1@telia.com>
	<2lhaa112u32htehrvnmqg6vh2kl8puesj8@4ax.com>
	<21d7e997050607004411bfa36b@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005 17:44:00 +1000 Dave Airlie wrote:
> > On Tue, 7 Jun 2005 08:37:31 +0200, Voluspa wrote:
> > >Ah, sorry about the noise... I've been away from kernel testing too
> > >long. I patched a 2.6.11.11 tree without noticing all the rejects
> > >(this new machine is fast). But from what I remember, it was
> > >decided to do the -rc patches against the latest stable codebase,
> > >in this case .11 Shrug.
[...]
> It was explicitly stated by Linus way back 2.6.8.1 time that
> subsequent patches are against the base of the previous release, so
> -rcs are against 2.6.x not 2.6.x.y.. which all makes great sense if
> development is happening in parallel... I'm not sure I've ever heard
> anything else stated to oppose this, but apparently some people have..

Yes, I remember that episode well. But times and policy change, don't
they? When the "stable" dot-releases were introduced, there was another
discussion, albeit brief, of where the base should lie. And my memory
must have really left for an early vacation since the .x.y decision came
so easily and quickly to my mind.

Anyway, the -rc6 applied cleanly to a 2.6.11 kernel and my uptime is now
27 minutes.

Issue: The new "conservative" qpufreq governor doesn't work. Stuck on
full blast. Loading the "ondemand" and trying to echo that choice into
the scaling_governor file doesn't work ("cannot overwrite existing
file"). Must reboot since the "conservative" don't want to be unloaded
(is in use). Guess I could have unloaded the whole ACPI module system in
correct order, but a reboot was quicker --> 20 seconds...

Ask for more info about my setup if someone would like to work on this.

Meta-issue: Anyone not using hotplug/udev/whatever will trip on the
kbd-now-being-another-mouse. Should result in plenty of user bugreports
around the lists unless the fact is posted somewhere prominently. I took
a brief tour with the -rc5 (downloaded a whole kernel) and just shook my
head when the mice in X became totally unruly. Didn't know if I
should laugh or cry, that's how funny the cursor behaved. I've now
bumped up both the internal touchpad and the usb mouse one notch higher
in the /dev/input/mouseX list and all is well.

Mvh
Mats Johannesson
--
