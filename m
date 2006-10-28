Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWJ1WyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWJ1WyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWJ1WyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 18:54:21 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:53904 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932112AbWJ1WyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 18:54:20 -0400
Date: Sat, 28 Oct 2006 15:54:14 -0700
From: thockin@hockin.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       Jiri Bohac <jbohac@suse.cz>, Luca Tettamanti <kronos.it@gmail.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028225414.GE10086@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com> <20061028024638.GA16579@hockin.org> <200610272059.13753.ak@suse.de> <1162059732.14733.8.camel@mindpipe> <20061028195739.GA18879@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028195739.GA18879@suse.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 09:57:39PM +0200, Vojtech Pavlik wrote:
> > > No we don't -- most BIOS still don't give us the HPET table 
> > > even when it is there in hardware. In the future this will change sure
> > > but people will still run a lot of older motherboards. 
> > 
> > I have exactly such a system (see thread "x86-64 with nvidia MCP51
> > chipset: kernel does not find HPET").  Is there anything at all I can do
> > to make the kernel see the HPET?  Can I try to guess the address?  BIOS
> > upgrade?
>  
> In most cases where the HPET is present but not reported, it's not
> configured. Usually, you need to write a chipset-specific register to
> configure the address.
> 
> Finding the register, finding some free MMIO space, writing the address
> to the register and telling the address to the kernel is enough.

Do we want to establish a precedent for chipsets that we can find the HPET
and configure ourselves?  Register them all as PCI quirks...
