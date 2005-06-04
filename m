Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFDAek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFDAek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFDAek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:34:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261196AbVFDAeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:34:13 -0400
Date: Fri, 3 Jun 2005 20:34:07 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
Message-ID: <20050604003407.GA10816@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 04:38:43PM -0700, Andrew Morton wrote:
 > Jeff Garzik <jgarzik@pobox.com> wrote:
 > >
 > > 
 > > So...  are we gonna see 2.6.12 sometime soon?
 > > 
 > 
 > Current plan is -rc6 in a few days, 2.6.12 a week after that.
 > 
 > 
 > My things-to-worry-about folder still has 244 entries.  Nobody seems to
 > care much.  Poor me.
 > 
 > Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
 > the usual suspects.

There's quite a few in there judging by the looks of the subjects
that aren't worth holding up the release imo.  Will the world
end if we dont ship 2.6.12 with support for Geode optimisation
for eg ?

Of the bugzillas...

 > Subject: [Bug 2698] Kernel Crash; Could be related to quotas on ext3

sounds promising, but needs user confirmation.

 > Subject: [Bug 3054] madvise doesn't fail for exceding RSS limit.

test program seems to dtrt for me on 2.6.12-rc5-git8

 > Subject: [Bug 4282] ALSA driver in Linux 2.6.11 causes a kernel panic when loading the EMU10K1 driver
 > Subject: [Bugme-new] [Bug 4282] New: ALSA driver in Linux 2.6.11 causes a

not reproducable by user, or alsa folks. hrmph.

 > Subject: [Bug 4342] "Near touchpad upper buttons" not working on a dell
 > Subject: [Bugme-new] [Bug 4342] New: "Near touchpad upper buttons" not

sounds like this got better, but still isnt perfect :(

 > Subject: [Bug 4377] New: Severe memory leak issue

Hmm. yet more oom-killer woes.
Some kind person from IBM pulled out a patch that we stuck in RHEL4
which does a sysrq-M at the time an oom kill occurs, which we've
found handy tracking down these. Might be worth including.
It got sent to the list late last week. I can dig it out if you
don't have it queued already.

 > Subject: [Bug 4382] New: first joystick button mapped to extra number

needs work
 
 > Subject: [Bug 4481] hang at boot from kernels 2.6.9 and above

*shrug*

 > Subject: [Bug 4665] New: ACPI battery monitor does not work

"The problem is not present in 2.6.12-rc5-mm2"

 > Subject: [Bug 4688] CD devices have their capacity set incorrectly, preventing

hmm, it'd be great if bugme.osdl.org had a 'needinfo' state.

 > Subject: [Bugme-new] [Bug 4281] New: ALPS Touchpad Tap-to-Click Broken

seems fixed functionality wise, but needs some tuning.

 > Subject: [Bugme-new] [Bug 4295] New: Garbage all over the screen when using

meh, fglrx tainted crap.

 > Subject: [Bugme-new] [Bug 4297] New: VIA 82xxx sound problem with kernel

needinfo.

 > Subject: [Bugme-new] [Bug 4299] New: glidepoint touchpad movement broken

user wont test until after 2.6.12 is released. catch22.

 > Subject: [Bugme-new] [Bug 4300] New: hpt366 S-ATA driver causes the kernel

dupe of 2555
"hpt366.o driver hangs computer when probing htp374-based HighPoint Rocket 1540 SATA card"
needinfo.

 > Subject: [Bugme-new] [Bug 4306] New: USB no longer survives resume in 2.6.11

rc5 - "seems to work again"

 > Subject: [Bugme-new] [Bug 4315] New: DMA timeouts on ASUS M2400N

needinfo

 > Subject: [Bugme-new] [Bug 4318] New: fcntly system calls with options

REJECTED->INVALID

 > Subject: [Bugme-new] [Bug 4323] New: no cursor in console with intelfb

no idea.

 > Subject: [Bugme-new] [Bug 4340] New: ohci_1394 module breaks S3 suspend

firedire broken. film at 11.
I'm amazed it works when not suspended half the time.

 > Subject: [Bugme-new] [Bug 4347] New: savavgfb ddc eeprom oops when "sensors"

"Yes Andrew, it is. The first bug is fixed since 2.6.11.7/2.6.12-rc1, the second
 since 2.6.12-rc2."

 > Subject: [Bugme-new] [Bug 4352] New: Problems with PowerNow on Athlon-XP
 > Subject: [Bugme-new] [Bug 4392] New: powernow-k8 driver doesn't work with
 > Subject: PowerNow-K8 and Winchester CPUs
 > Subject: Re: kernel oops with powernow-k8 on k8t neo-v
 > Subject: Re: PowerNow-K8 and Winchester CPUs

should be fixed in -rc6 due to the cpufreq update a day or two ago.

 > Subject: [Bugme-new] [Bug 4454] New: Mobile Intel Prescott with Enhanced

likely still present.

 > Subject: Re: VIA interrupt quirk for 2.6.12?
 > Subject: RE: VIA interrupt quirk for 2.6.12?
 > Subject: VIA interrupt quirk for 2.6.12?

didn't this get merged a few days ago ?


I would go through some of the rest on the list, but I'm hungry :-)
Maybe more later..

		Dave

