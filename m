Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFURSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFURSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWFURSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:18:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:10220 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750901AbWFURSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:18:16 -0400
Message-ID: <44997EF0.3000005@us.ibm.com>
Date: Wed, 21 Jun 2006 10:16:32 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de> <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com> <20060619222528.GC1648@openzaurus.ucw.cz> <20060619224130.GA17134@redhat.com> <Pine.LNX.4.61.0606200729280.7695@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0606200729280.7695@chaos.analogic.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

linux-os (Dick Johnson) wrote:

> The CPU produces heat. It's efficiency as a heater is nearly 100%
> because it doesn't produce much noise or anything else to transfer
> its 50+ watts into anything but heat. Spinning doesn't make friction.
> It doesn't make more heat. The total box dissipation might even
> be reduced because there is little memory activity and no seeks
> of hard disks.
> 
> Some CPUs will go to a low-power 'sleep' mode if halted. Some require
> more than that, they must fetch 'pause', i.e., rep nop to stay in
> a low power mode. Other CPUs will throttle back their power
> consumption when the instruction cache is inactive, read spinning.
> These CPUs are normally used in lap-tops to maximize battery life.

What creates a fair amount of the heat in a CPU is the period of time
when the transistors switch from nearly zero resistance to infinite
resistance.  That brief period where the resistance very high but not
yet infinite generates heat.  That's why running a CPU at a higher clock
speed generates more heat:  there are more of those high resistance
transitions in a given period of time.

I think every processor since at least 1998 or so has had a mode where
executing the HLT instruction puts the bulk of the chip in a steady
state.  When it's in that steady state, the transistors don't switch, so
there are no high resistance periods.

This is, of course, completely different than the sleep or reduced clock
modes that modern processors support.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEmX7wX1gOwKyEAw8RAu+MAJwOgq1rwrcr+dQHnM9ucT6R1+ZlOACgkLR7
J0CmccUthcHknCaXYTL6ON0=
=lkld
-----END PGP SIGNATURE-----
