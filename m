Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbQKOA1u>; Tue, 14 Nov 2000 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130848AbQKOA1k>; Tue, 14 Nov 2000 19:27:40 -0500
Received: from [194.73.73.138] ([194.73.73.138]:49083 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S130414AbQKOA1c>;
	Tue, 14 Nov 2000 19:27:32 -0500
From: davej@suse.de
Date: Tue, 14 Nov 2000 23:57:08 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: _deepfire@mail.ru
Subject: RE: /proc tweaking
Message-ID: <Pine.LNX.4.21.0011142338150.1275-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff wrote...

> >Take a look at powertweak. >http://powertweak.sourceforge.net
> >Made by kernel people, for non-kernel people.
> Maybe i were not enough exact, but i`ve meant
> addition of some intelligence to tweaking /proc
> e.g. something what automates tuning, not only
> providing interface to such actions.

 If you check the version in CVS, you'll notice addition of
profiles which allow you to do just this.
"This is an Oracle server", "This is an Apache server" e.t.c.
(These profiles can also be combined for multi-purpose boxes)

> But after lookthru ptweaks source i realized
> what its ONLY interface (to proc), and MAYBE
> it does some PCI tuning

 I assume you're referring to 0.1.17 codebase, which is no
longer getting actively developed. The version in CVS is due to
be released _very_ soon, and is notably improved.
- Profiles (as mentioned above)
- Each option now offers comprehensive advice.
- Other areas of tuning.
  Notably CPU MSRs (with the /dev/msr interface), and
  disk elevator adjustment.
- Several other new goodies.

And if it doesn't support your hardware, then hey, we accept patches.

> BTW powertweak is a port from unfamous MD

 Bzzt, thanks for playing. I've no idea what program you're
referring to, a google-search for "MD /proc/sys" revealed
nothing relevant.

 Just for the record, it started as the 2.2 `Tune PCI bridges'
feature moved to userspace named "TunePCI" (never released),
and then had a reimplementation of a tool called `proctune'
by Arjan van de Ven added to it. Only then did it get named
Powertweak-Linux.

 Time passed, and eventually Arjan rewrote the /proc/sys
tuning code to use XML.

> There is another argument, telling what doing autotune is ugly

How do you propose that the kernel should "know" what role you
intend to use it for ? Answer : It shouldn't, it's a userspace
problem, best solved in userspace by a userspace tool.

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
