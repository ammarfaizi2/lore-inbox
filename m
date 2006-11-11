Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947213AbWKKNzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947213AbWKKNzp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbWKKNzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:55:45 -0500
Received: from www.osadl.org ([213.239.205.134]:9951 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754483AbWKKNzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:55:44 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200611111451.33511.ak@suse.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <200611101029.59251.ak@suse.de>
	 <1163243677.8335.245.camel@localhost.localdomain>
	 <200611111451.33511.ak@suse.de>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 14:58:08 +0100
Message-Id: <1163253488.8335.247.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 14:51 +0100, Andi Kleen wrote:
> > > > And afaict the reason for that is that we're using jiffies to determine if
> > > > the TSC has gone bad, and that test is getting false positives.
> > > 
> > > The i386 clocksource had always trouble with that. e.g.  I have a box
> > > where the TSC works perfectly fine on a 64bit kernel, but since the new i386
> > > clocksource code is in it always insists on disabling it shortly after boot.
> 
> shortly after boot means in user space here, not during the first idling.
> 
> > > My guess is that some of the checks in there are just broken and need
> > > to be fixed.
> > 
> > It's the unconditional mark_unstable call in ACPI C2 state. /me looks.
> 
> The system doesn't support C2 states. It's an older single socket Athlon 64 
> with VIA chipset. I haven't looked in detail on why it fails.

Does it have cpu freqency changing ?

	tglx


