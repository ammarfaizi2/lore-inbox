Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRI0Jc1>; Thu, 27 Sep 2001 05:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRI0JcR>; Thu, 27 Sep 2001 05:32:17 -0400
Received: from [194.100.11.136] ([194.100.11.136]:44160 "HELO 136.quartal.com")
	by vger.kernel.org with SMTP id <S272247AbRI0JcG>;
	Thu, 27 Sep 2001 05:32:06 -0400
Subject: Re: 2.4.10 swap behaviour (with vm-tweaks-2)
From: Osma Ahvenlampi <oa@iki.fi>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20010926154225.D27945@athlon.random>
In-Reply-To: <1001490108.1444.34.camel@136.quartal.com> 
	<20010926154225.D27945@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 27 Sep 2001 12:32:14 +0300
Message-Id: <1001583134.1895.96.camel@136.quartal.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrea,

after applying the patch, I repeated the experiment. Since the cat
/dev/dvd >/dev/null no longer really made any difference, I started at
the same time a dd if=/dev/hda2 of=/dev/null (a 6 GB partition) and
eight find / processes at slightly difference points in time (to
excercise the same disk blocks repeatedly). I let the whole thing run
for about 5 times longer than the original test, and while the system
still pushed a lot of programs onto swap (from an initial used memory of
190 megs, up to 80 was pushed onto swap while I kept "using" most of the
programs by clicking on buttons etc), the system remained fairly
responsive (a couple of individual apps became sluggish enough to
categorize as unresponsive, but a couple of other programs kept
responding almost as well as in a no-load condition). To top it off, I
tried to play some .ogg files with XMMS - there were breakups in the
output every 10-15 seconds, but other than that, XMMS worked fine as
well. I don't run XMMS with realtime priority, so that might have fixed
even the sound output problems.

I'd have to say I now (finally!) have a kernel which doesn't eat up all
my memory.. :) For the record, the setup now is 2.4.10 +
rml-preempt-kernel-1 + aa-vm-tweaks-2.

Cheers,

 Osma

On Wed, 2001-09-26 at 16:42, Andrea Arcangeli wrote:
> You really want to apply vm-tweaks-1, (or better vm-tweaks-2 inlined
> here with the bugfix for Cary's div by zero, woops) and try again. It
> applies cleanly to vanilla 2.4.10.

-- 
Osma Ahvenlampi <oa@iki.fi>

