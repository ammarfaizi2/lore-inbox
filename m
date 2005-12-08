Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVLHGQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVLHGQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbVLHGQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:16:55 -0500
Received: from cantor.suse.de ([195.135.220.2]:56493 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030470AbVLHGQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:16:54 -0500
Date: Thu, 8 Dec 2005 07:16:48 +0100
From: Andi Kleen <ak@suse.de>
To: Ren? Rebe <rene@exactcode.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] x86_64: Test patch for ATI/Nvidia timer problems
Message-ID: <20051208061648.GI11190@wotan.suse.de>
References: <20051126142030.GA26449@wotan.suse.de> <200511271502.18782.rene@exactcode.de> <20051127141155.GI20775@brahms.suse.de> <200512051614.52620.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512051614.52620.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:14:48PM +0100, Ren? Rebe wrote:
> Hi,
> 
> On Sunday 27 November 2005 15:11, Andi Kleen wrote:
> 
> > > > But it worked properly before suspend/resume without noapic? 
> > > 
> > > Without noapic the timer has about the 2x speed compared to real-time. I
> > > only used the machien with noapic since otherwise it is barely useful.
> > 
> > It has that still with the patch applied? The patch was supposed
> > to fix that at least part of that problem on ATI systems
> > (there seems to be also a timer miscalibration problem on some other
> > laptops) 
> 
> Sorry for the late reply, just too much to do ... It appears my MSI Megabook
> S270 with Ati chipset and AMD Turion freezes on boot with your patch applied
> to 2.6.14.2 after the io schedulers are registered. Without the patch it boots
> up fine.

Ok thanks. 

Does it work when booted with acpi_skip_timer_override ? 

I sometimes wish this ATI chipset wouldn't exist - its timers are an endless
headache. Admittedly the Linux code for this is somewhat screwy too, but
their hardware also doesn't seem to be quite kosher.

-Andi
