Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVK3BE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVK3BE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVK3BE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:04:29 -0500
Received: from ns1.suse.de ([195.135.220.2]:9887 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750728AbVK3BE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:04:28 -0500
Date: Wed, 30 Nov 2005 02:04:27 +0100
From: Andi Kleen <ak@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>, Andi Kleen <ak@suse.de>,
       Nicholas Miell <nmiell@comcast.net>,
       Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051130010426.GC19515@wotan.suse.de>
References: <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <1133305338.3271.30.camel@entropy> <20051129231750.GU19515@wotan.suse.de> <1133306966.3271.36.camel@entropy> <20051129233920.GW19515@wotan.suse.de> <20051129235626.GC9659@localhost.localdomain> <20051130003433.GA19515@wotan.suse.de> <20051130005205.GD9659@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130005205.GD9659@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It just seems to me unwise to make an ABI commitment to something
> that's not guaranteed by the architecture, perverse though it might
> seem for the chip designers to take it away.  CPU designers have been
> known to do some fairly perverse things from time to time..

What would you prefer? Letting them continue to use RDTSC
which is less and less an usable cycle count?  Telling the users
it's a bad idea without offering a credible alternative
for cycle counting? 

And if they break it the kernel can always trap it, so there's
at least a safety net.

One alternative would be to make a function in the vsyscall page, but
that would add at least an indirect function call which can be quite
slow and I can just hear people complaining about that.

Also there are only two slots in the vsyscall page left right now and I
already planned them for other things (although it would be possible to go 
for a full vDSO, just a lot of overhead) 

-Andi

