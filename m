Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292947AbSB1Mva>; Thu, 28 Feb 2002 07:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293339AbSB1MtA>; Thu, 28 Feb 2002 07:49:00 -0500
Received: from nixpbe.pdb.sbs.de ([192.109.2.33]:15757 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S293338AbSB1Mph>;
	Thu, 28 Feb 2002 07:45:37 -0500
Date: Thu, 28 Feb 2002 13:48:23 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: PROBLEM: Timer interrupt lockup on HT machine
Message-ID: <Pine.LNX.4.33.0202281339290.24779-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

we have found another problem with our HT ("Jackson") prototype
machines. In our reboot tests we found that sometimes the timer
interrupts stop. This happens typically after ~30-50 seconds.

>From that time on, no more timer interrupts are encountered.
This happens only when the logical Jackson CPUs are enabled,
i.e. with the "acpismp=force" command line parameter, and approximately
at every 10th boot.

Another observation is that on the HT machines (whether or not the
above problem occurs) almost all interrupts seem to be handled by CPU 0.

CPU 1 gets a few, but in a ratio of about 1:10000 wrt CPU 0.
CPU 2 and 3 do not see any interrupts at all.

Has anybody heard of these problems yet, and are workarounds available?
I am currently investigating the problem and will be happy to supply
more information if requested.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





