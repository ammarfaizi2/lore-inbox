Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266037AbRGGFsy>; Sat, 7 Jul 2001 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266035AbRGGFsp>; Sat, 7 Jul 2001 01:48:45 -0400
Received: from science.horizon.com ([192.35.100.1]:49458 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S266037AbRGGFse>; Sat, 7 Jul 2001 01:48:34 -0400
Date: 7 Jul 2001 05:48:20 -0000
Message-ID: <20010707054820.720.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: What's the status of kernel PNP?
Cc: tom@lpsg.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that 2.4.6-ac1 parport won't compile (well, link) without
the kernel PnP stuff configured.  So I tried turning it on.

It prints a line saying that it found my modem at boot time, but doesn't
actually configure it, so I have to run isapnp anyway if I want to use it.

Okay, RTFM time... Documentation/isapnp.txt doesn't say anything about
boot time (only /proc/isapnp usage after boot and some function call
interfaces for kernel programming that are hard to follow).

kernel-parameters.txt gives a hint, although it required reading the
source code to figure out what to pass as "isapnp=" to turn verbose up.

A lot of google searching comes up with a lot of stale data but the only
2.4-relevant kernel ISAPNP howto is written in Japanese.  Lots of stuff
describes it as a feature in the 2.4 kernels, but I can't find anything
on how to use it.

MAINTAINERS claims that it's maintained, but the web page is down (the
whole site has moved, and /~pnp doesn't exist on the new site) and the
only mailing list archives I can find for pnp-devel (at geocrawler)
doesn't have any updates since the year 2000 - and those are all spam.

I'm a little suspect about that maintained status, although I haven't
written the maintainer yet.


But the upshot of all of this is that I can't figure out WTF to do with
this "feature", since I haven't noticed it actually doing anything except
taking up kernel memory.


On another machine, with an ISA PCMCIA adapter, which works with isapnp
and David Hinds' PCMCIA package, but if I try to use the 2.4 cardbus
code, it fails to probe the PCMCIA adapter, apparently because the PnP
code again didn't set it up.  (And there's no obvious way to force a
re-probe after boot unless I build the whole thing as a module.)  Again,
the PnP code cheerfully points out that the PCMCIA adpater exists, but
doesn't appear to grasp the concept that I didn't put the adapter into
the machine because it looks pretty.


Can someome point me at TFM or some other source of information?  I'd be
much obliged.
