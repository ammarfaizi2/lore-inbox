Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTBUBxj>; Thu, 20 Feb 2003 20:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBUBxj>; Thu, 20 Feb 2003 20:53:39 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:14602 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S267076AbTBUBxi>;
	Thu, 20 Feb 2003 20:53:38 -0500
Date: Thu, 20 Feb 2003 21:03:39 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <3E556F00.30201@pobox.com>
Message-ID: <Pine.LNX.4.44.0302202058140.16982-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Jeff Garzik wrote:

> Ion Badulescu wrote:
> > A UP kernel compiled with CONFIG_X86_LOCAL_APIC=y dies a very horrible
> > death on an SMP Athlon motherboard (Tyan S2462 and S2468), flooding the
> > console with the following messages:
> 
> IMO just assume this option is just broken, unless you absolutely need it.

My only boxes on which this is a problem are the SMP athlons, and only 
with UP kernels...

> Red Hat ships UP kernels with this option disabled, because either the 
> code, the BIOS, or both are typically broken.

Only recently, though, and probably because they started receiving
complaints that the BOOT kernel (most importantly) and the UP kernel were
not booting up correctly on SMP athlons. At least that's the impression I
got browsing bugzilla.redhat.com.

Moreover, it makes a measurable difference in interrupt latency (and
consequently in the number of UDP packets dropped under stress), so on my
production machines I run RH kernels with this option re-enabled (among 
other changes).

Anyway, I'd like to get to the bottom of this, since I've narrowed it down 
so much. Anyone know who submitted the APIC changes in 2.4.10-pre12? I'd 
debug it myself, but I know next to nothing about the APIC. If you know 
where to get some documentation, I'm more than willing to give it a shot.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

