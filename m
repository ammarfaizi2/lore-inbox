Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSBRVoO>; Mon, 18 Feb 2002 16:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBRVoI>; Mon, 18 Feb 2002 16:44:08 -0500
Received: from [194.25.47.66] ([194.25.47.66]:24333 "HELO brenner.novaville.de")
	by vger.kernel.org with SMTP id <S287865AbSBRVmz>;
	Mon, 18 Feb 2002 16:42:55 -0500
Date: Mon, 18 Feb 2002 22:42:50 +0100 (CET)
From: Oliver Hillmann <oh@novaville.de>
To: linux-kernel@vger.kernel.org
Subject: jiffies rollover, uptime etc.
Message-ID: <Pine.LNX.4.10.10202182040260.11179-100000@rimini.novaville.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yes, I know this is defenitely no new issue (maybe its none to you
anyway), since I found posts about this dating from 1998: the
jiffies counter rolls over after approx. 497 days uptime, which
causes the uptime to roll over as well, and seems to cause some
other irretation in the system itself (my pc speaker starting
beeping constantely...)

I noticed this on a couple of servers just having had 500 days of
uptime, and so I starting looking at the kernel code and played
around with a tiny jiffie manipulating kernel module. Since jiffies
is unsigned long (being 32 bits wide on x86) and counts 1/100th
seconds, it can only hold about 497 days...

This seems to be true for both 2.2 and 2.4, at least for 2.2.16 and
2.4.17, which I tested...

The uptime thingy could IMHO be solved with some kind of rollover
counter, and I'm currently digging into that area... Stuff like a pc
speaker driver going wild bothers me a bit more...

Could anybody perhaps tell me why he/she doesn't consider this a
problem? And is there a fundamental problem with solving this in
general? (I do see a problem with defining jiffies long long on x86,
because it might break a lot of things and probably wouldnt perform
as often as jiffies is touched... And you might sense I haven't
been into kernel hacking much...)

My first post here, sorry :)

Regards,

Oliver

