Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUA3FoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUA3FoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:44:20 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:62340 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266533AbUA3FoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:44:18 -0500
Date: Fri, 30 Jan 2004 00:29:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org, Micha Feigin <michf@post.tau.ac.il>
Subject: Re: PNP depends on ISA ? (2.6.2-rc2
Message-ID: <20040130002904.GB13308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org, Micha Feigin <michf@post.tau.ac.il>
References: <20040126193144.GC2004@luna.mooo.com> <20040126161746.GA3180@neo.rr.com> <20040128231633.GF3975@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128231633.GF3975@luna.mooo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 01:16:33AM +0200, Micha Feigin wrote:
> On Mon, Jan 26, 2004 at 04:17:46PM +0000, Adam Belay wrote:
> > On Mon, Jan 26, 2004 at 09:31:44PM +0200, Micha Feigin wrote:
> > > I was wondering why pnp depends on isa being selected in 2.6.2-rc2, is
> > > pnp really only relevant to isa? What happens with pci etc. ?
> > > This may explain why using pnpbios locks up my machine (at least as of 2.6.0-test9).
> > 
> > Yes, it only is related to isa devices, but they include onboard devices
> > such as serial ports.  It will, however, prevent resource conflicts
> > between pci and system devices, especially with unusual configurations.
> > Does using pnpbios cause your machine to lockup at boot?  If so, around
> > where does it occur?  DMI information would also be useful for blacklisting
> > purposes.
> > 
> 
> I just checked again with 2.6.2-rc2. It occurs right after pnpbios
> starts up. I wrote the oops down by hand since the computer went into a
> hard lockup (no sysrq key), but couldn't get any results out of
> ksymoops for some reason (maybe I am misusing it, any way to disable
> pnpbios on a kernel compiled with so I can run it from the running
> kernel?).

the kernel parameter pnpbios=off should work.

> I attached the oops log and the dmi data (didn't know what is needed of
> it).

I appreciate the information will add this to the blacklist.

Thanks,
Adam
