Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752065AbWKAMza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbWKAMza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWKAMza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:55:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24986 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752065AbWKAMz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:55:29 -0500
Date: Wed, 1 Nov 2006 13:55:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm1: noidlehz problems
Message-ID: <20061101125506.GA2133@elf.ucw.cz>
References: <20061101122319.GA13056@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101122319.GA13056@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> First, it would be nice if we had someone listed as a maintainer of
> noidlehz stuff...
> 
> Then... I'm getting strange messages from noidlehz each time I
> unplug/replug AC power (perhaps due to interrupt latency?).
> 
> Disabling NO_HZ and high resolution timers due to timer broadcasting
> (C3 stops local apic)
> Adding 987988k swap on /dev/sda1.  Priority:-1 extents:1
> across:987988k
> Disabling NO_HZ and high resolution timers due to timer broadcasting
> (C3 stops local apic)
> EXT2-fs warning (device sda2): ext2_fill_super: mounting ext3
> filesystem as ext2
...
> Disabling NO_HZ and high resolution timers due to timer broadcasting
> (C3 stops local apic)
> Disabling NO_HZ and high resolution timers due to timer broadcasting
> (C3 stops local apic)
> 
> ...I'd expect one such message, not many of them. Something seems
> seriously wrong there...
> 
> Plus, suspend to RAM and disk is broken in -rc4-mm1. Suspend to RAM
> dies with screaming speaker, suspend to disk returns but machine is
> mostly toast (and screaming, looks like timer problem, beeps never
> end). I'll disable NO_HZ and try again.

Disabling NO_HZ did not help, but I disabled high resolution timers,
and s2ram now works. s2disk also started working.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
