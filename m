Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTLOHos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 02:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTLOHos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 02:44:48 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:41388 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263343AbTLOHoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 02:44:46 -0500
Subject: Re: alsa on gentoo ppc 2.6.0-test11-benh1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031212083609.6db56e5b.zdavatz@ywesee.com>
References: <20031212083609.6db56e5b.zdavatz@ywesee.com>
Content-Type: text/plain
Message-Id: <1071474131.12496.411.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 18:42:12 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> soundcore              11200  3 snd,dmasound_core
> 
> When I do amixer I get:
> amixer: Mixer attach default error: No such device
> 
> I done my kernel with make menuconfig, make, make modules_install
> 
> I have been searching the Net for clues but did not find anything so far, to get my sound working.

It seems you are trying to load both dmasound_pmac and alsa
snd-powermac, they are mutually exclusive.
 

> 2. Why does my computer go to sleep when I press 'CapsLook'. Can I turn
> that off or is this still a 2.6.0 Bug?

That's a strange thing that appeared with one snapshot of test11
and disappeared with the next one afaik. I don't have a good explanation. It
definitely doesn't happen on my laptops, and the logs I got from users seemed
to indicate that the PMU chip (which controls the keyboard on those laptops)
was actually the one sending a spurrious 0x7f event (power key). It may be
something we do that triggers that though I haven't been able to find out
what.

If it happens reproduceably, you may want to disable whatever userland
daemon you have that triggers sleep when you press the power key. (I
suppose pbbuttonsd).

Ben.


