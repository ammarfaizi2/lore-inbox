Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVLZX1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVLZX1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVLZX1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 18:27:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39329 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932155AbVLZX1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 18:27:53 -0500
Date: Tue, 27 Dec 2005 00:27:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051226232712.GH1974@elf.ucw.cz>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org> <20051226203806.GC1974@elf.ucw.cz> <20051226225246.GA9915@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226225246.GA9915@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 26-12-05 17:52:48, Theodore Ts'o wrote:
> On Mon, Dec 26, 2005 at 09:38:06PM +0100, Pavel Machek wrote:
> > Stupid IBM. I've seen it appearing/disappearing, but did not work out
> > when.
> > 
> > No-C4-on-AC is bad -- if you just disconnect AC and walk away, you are
> > running without benefits of C4. Bad. Changing benchmarks depending on
> > you booting on AC or battery also look nasty.
> 
> The moment you disconnect AC, it C4 automagically appears.  When you
> reconnect to the AC mains, the C4 state disappears again, at least
> from the listing displayed by /proc/acpi/processor/CPU0/power.  So the
> first issue you brought up isn't a problem.

It does not seem to work like that here. I'm not sure what the exact
rules are, but I know that I sometimes have C4 and sometimes not. I
have C4 now, and it is used, even when I'm on AC power. Thinkpad X32.

> More of an issue is that there are times when the laptop might think
> that it's running of the AC mains, but in fact the owner may have
> connected an external battery, and might _want_ the system to be as
> frugal as possible with the power.

Yes... OTOH it is not that bad -- we could simply hardcode data from
acpi BIOS into kernel, ignore what ACPI says, and drive C4 even on AC
power. But that would be hack (tm). 

> Whether I boot from AC power battery seems to be immaterial; what
> seems to matter is whether or not the laptop is running on battery at
> the moment that /proc/acpi/processor/CPU0/power is sampled.

I did not realize ACPI was _that_ clever. Anyway, it is different on
my machine...
								Pavel
-- 
Thanks, Sharp!
