Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290682AbSAYOTw>; Fri, 25 Jan 2002 09:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290687AbSAYOTm>; Fri, 25 Jan 2002 09:19:42 -0500
Received: from skiathos.physics.auth.gr ([155.207.123.3]:39152 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S290682AbSAYOT2>; Fri, 25 Jan 2002 09:19:28 -0500
Date: Fri, 25 Jan 2002 16:17:21 +0200 (EET)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Ed Sweetman <ed.sweetman@wmich.edu>, Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020124232749Z290458-13996+11481@vger.kernel.org>
Message-ID: <Pine.GSO.4.21.0201251535520.11551-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have been watching this thread for a while now. I am surprised everybody
is happy with the temperature drops they get and don't look a bit
further. I might be sounding like a *ickhead but here go my .02 euros:

With STOPGNT enabled, the disconnection happens by the northbridge
actually halting the FSB for the CPU until the next interrupt. The
continuous dis/reconnection causes increased lattency on the PCI bus and
strictly timed PCI transfers needed by TV-Tuner cards/software or sound
software suffer greatly from this. It also results in poorer hd
performance.
 
Also with such a power hungry CPU as the Athlon, bus dis/reconnection
results in current demand changing from 40A to 5A to 40A ... every few ms.
This puts your motherboards' voltage regulator under unecessary strain as
well those in your PSU.

Furthermore, CPUs do like lower operating temperatures, but even more they
like constant temperatures. Differences like 10-15C every now and then
(load/idle) put the cpu die under mechanichal strain from thermal
contraction/expansion.

Finally, this procedure can actually *hide* severe cooling inefficiency of
the system. People seem to go with the moto: STOPGNT lowers my
temperature, so it is a good thing. Well, it doesn't. Run SETI@HOME and
you are back where you started. It can take only a hot summer day and you
have a fried chip.

There was a thought by somebody, that you should only enable disconnection
after some time of inactivity. This sounds better, but then, don't we 
have S1/S3 for this already?

This feature of the AMD processors seemed like a real bargain once but
now, I doupt there is one motherboard vendor out there that allows you to
control it in the BIOS (like they used too). Even more, they suggest you
leave this feature alone. A walk in troubleshooting/support forums
suggests the same: It is a feature you can do without, you'd be better off
with a cooler that can cool and a well ventilated case.

Sorry for the length,

-Kostas


