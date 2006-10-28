Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWJ1T7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWJ1T7M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWJ1T7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:59:12 -0400
Received: from styx.suse.cz ([82.119.242.94]:64660 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751380AbWJ1T7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:59:11 -0400
Date: Sat, 28 Oct 2006 21:57:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, thockin@hockin.org, Jiri Bohac <jbohac@suse.cz>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028195739.GA18879@suse.cz>
References: <1161969308.27225.120.camel@mindpipe> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com> <20061028024638.GA16579@hockin.org> <200610272059.13753.ak@suse.de> <1162059732.14733.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162059732.14733.8.camel@mindpipe>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 02:22:11PM -0400, Lee Revell wrote:

> On Fri, 2006-10-27 at 20:59 -0700, Andi Kleen wrote:
> > > Fortunately, we usually have an HPET, these days.  You can
> > definitely
> > > resync and get near-linear values of RDTSC.
> > 
> > No we don't -- most BIOS still don't give us the HPET table 
> > even when it is there in hardware. In the future this will change sure
> > but people will still run a lot of older motherboards. 
> 
> I have exactly such a system (see thread "x86-64 with nvidia MCP51
> chipset: kernel does not find HPET").  Is there anything at all I can do
> to make the kernel see the HPET?  Can I try to guess the address?  BIOS
> upgrade?
 
In most cases where the HPET is present but not reported, it's not
configured. Usually, you need to write a chipset-specific register to
configure the address.

Finding the register, finding some free MMIO space, writing the address
to the register and telling the address to the kernel is enough.

-- 
Vojtech Pavlik
Director SuSE Labs
