Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTE0VrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTE0VrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:47:03 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13277 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264207AbTE0VrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:47:00 -0400
Date: Tue, 27 May 2003 14:59:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>
cc: John Stoffel <stoffel@lucent.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <4060000.1054072761@[10.10.2.4]>
In-Reply-To: <20030527184016.GA5847@suse.de>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > What the hell am I supposed to enter here?  This is just friggin ugly
>  > > and un-readable.  It should be cleaned up.
>  > I agree and I already fixed this here, so with the next update this will 
>  > look like this:
>  > 
>  > Subarchitecture Type
>  > > 1. PC-compatible (X86_PC)
>  >   2. Voyager (NCR) (X86_VOYAGER)
>  >   3. NUMAQ (IBM/Sequent) (X86_NUMAQ)
>  >   4. Summit/EXA (IBM x440) (X86_SUMMIT)
>  >   5. Support for other sub-arch SMP systems with more than 8 CPUs (X86_BIGSMP)
>  >   6. SGI 320/540 (Visual Workstation) (X86_VISWS)
>  >   7. Generic architecture (Summit, bigsmp, default) (X86_GENERICARCH) (NEW)
>  > choice[1-7]: 
>  > 
>  > This has other advantages too, one can see now which options were newly 
>  > added and the individual help texts are accessible.
> 
> Given that 99% of users will be choosing option 1, it might be a
> good thing to have the remaining options only shown if a
> CONFIG_X86_SUBARCHS=y and have things default to option 1 if =n.

Please, not more layered config options! That just makes people who
want to enable the x440 or other alternative platform require fair
amounts of psychic power (maybe this can be fixed with a big fat help
message, but so can the current method).

If you're going hide the other options away so much, then the default
should be the generic arch, IMHO.

M.

