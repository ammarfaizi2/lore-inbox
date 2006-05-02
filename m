Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWEBMld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWEBMld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 08:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEBMld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 08:41:33 -0400
Received: from styx.suse.cz ([82.119.242.94]:39636 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932232AbWEBMlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 08:41:32 -0400
Date: Tue, 2 May 2006 14:41:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Auke Kok <sofar@foo-projects.org>, Auke Kok <auke-jan.h.kok@intel.com>,
       Ingo Oeser <ioe-lkml@rameria.de>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
Message-ID: <20060502124131.GA13160@suse.cz>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604221529.59899.ioe-lkml@rameria.de> <20060422134956.GC6629@wohnheim.fh-wedel.de> <200604230205.33668.ioe-lkml@rameria.de> <444CFFE5.1020509@intel.com> <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com> <444D8047.9080403@foo-projects.org> <Pine.LNX.4.61.0604250717590.28279@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604250717590.28279@chaos.analogic.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 07:29:40AM -0400, linux-os (Dick Johnson) wrote:

> >> Message signaled interrupts are just a kudge to save a trace on a
> >> PC board (read make junk cheaper still).
> >
> > yes. Also in PCI-Express there is no physical interrupt line anymore due to
> > the architecture, so even classical interrupts are sent as "message" over the bus.
> >
> >> They are not faster and may even be slower.
> >
> > thus in the case of PCI-Express, MSI interrupts are just as fast as the
> > ordinary ones. I have no numbers on whether MSI is faster or not then e.g.
> > interrupts on PCI-X, but generally speaking, the PCI-Express bus is not
> > designed to be "low latency" at all, at best it gives you X latency, where X
> > is something like microseconds. The MSI message itself only takes 10-20
> > nanoseconds though, but all the handling probably adds a large factor to that
> > (1000 or so). No clue on classical interrupt line latency - anyone?
> 
> About 9 nanosecond per foot of FR-4 (G10) trace, plus the access time
> through the gate-arrays (about 20 ns) so, from the time a device needs
> the CPU, until it hits the interrupt pin, you have typically 30 to
> 50 nanoseconds. Of course the CPU is __much__ slower. However, these
> physical latencies are in series, cannot be compensated for because
> the CPU can't see into the future.
 
You seem to be missing the fact that most of todays interrupts are
delivered through the APIC bus, which isn't fast at all.

-- 
Vojtech Pavlik
Director SuSE Labs
