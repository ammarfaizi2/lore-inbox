Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272307AbTG3Wu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272308AbTG3Wu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:50:58 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:53447 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272307AbTG3Wu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:50:57 -0400
Date: Thu, 31 Jul 2003 00:50:51 +0200 (MEST)
Message-Id: <200307302250.h6UMopj1024131@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, nelsonis@earthlink.net
Subject: Re: Dell 2650 Dual Xeon freezing up frequently
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003 15:52:58 -0600, Ian S. Nelson wrote:
>I'm running a RedHat 2.4.20 kernel on some 2650's   all dual xeon 
>(pentium 4 jacksonized  so it looks like 4 procsessors)  2 have 1GB of 
>RAM and 1 has 2GB of RAM.   THey all wedge, some times after a few 
>minutes,  sometimes after hours.
>
>I hooked up a serial consol to capture a kernel panic or something else 
>that would be fun to debug,  no such luck..  It just locks up.  No nothing.

Welcome to the club. Our PE2650 used to hang hard anywhere from a few
days to two weeks after each reboot. This started after our RH7.3 to
RH8.0 upgrade and may be related to problems with the tg3 NIC driver.
(RH7.3 was stable, but then I think we used a bcm<something> driver.)

After having these problems from January to March or April, with a
a series of RH upgrade kernels, I accidentally found that enabling
the I/O-APIC nmi_watchdog solved all problems. (I can only speculate
that somehow the regular I/O-APIC NMIs prevent some hang somewhere.)
It's now running stable as a rock since April.

/Mikael
