Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUJKSWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUJKSWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269163AbUJKSWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:22:17 -0400
Received: from gprs212-86.eurotel.cz ([160.218.212.86]:20608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267319AbUJKSWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:22:16 -0400
Date: Mon, 11 Oct 2004 20:21:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
Message-ID: <20041011182153.GC1007@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org> <20041011145628.GA2672@elf.ucw.cz> <Pine.LNX.4.58.0410110826380.3897@ppc970.osdl.org> <20041011173901.GA66749@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011173901.GA66749@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H!

> > That's the one. suspend-to-disk works, but suspend-to-ram leaves the fam 
> > going, and does not come back no matter how many times you press the power 
> > button. You need to kill it (twice) by holding the power button for five 
> > seconds (which is the "hard-power-off" signal to the southbridge, when 
> > everything else is locked up).
> 
> I had a somewhat equivalent problem with suspend-to-ram (working but
> no wakeup) which required two patches:
> - add PWRB and LID0 as wakeup devices[1]
> - ignore PRWF since it doesn't send acpi events [2]
> 
> It was with a 2.6.8-rc2 kernel, so the situation may have changed since then.

Actually on N620c it does not even suspend, so Linus has different
problem.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
