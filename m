Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293502AbSB1R1a>; Thu, 28 Feb 2002 12:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293520AbSB1RYr>; Thu, 28 Feb 2002 12:24:47 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:29398 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293628AbSB1RVx>;
	Thu, 28 Feb 2002 12:21:53 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15486.26414.396199.94258@harpo.it.uu.se>
Date: Thu, 28 Feb 2002 18:21:50 +0100
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Timer interrupt lockup on HT machine
In-Reply-To: <Pine.LNX.4.33.0202281339290.24779-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.33.0202281339290.24779-100000@biker.pdb.fsc.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck writes:
 > Another observation is that on the HT machines (whether or not the
 > above problem occurs) almost all interrupts seem to be handled by CPU 0.
 > 
 > CPU 1 gets a few, but in a ratio of about 1:10000 wrt CPU 0.
 > CPU 2 and 3 do not see any interrupts at all.
 > 
 > Has anybody heard of these problems yet, and are workarounds available?

I've heard about that IRQ imbalance on MP P4 Xeons from a person at Dell.
My understanding of it is that it's a consequence of the local APIC
priorization changes Intel did in the P4 xAPIC design. (Study Intel's IA32
Vol 3 manual in detail and you'll see them.) Supposedly Ingo Molnar is
working on a solution.

/Mikael
