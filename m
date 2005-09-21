Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVIUEDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVIUEDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 00:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVIUEDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 00:03:50 -0400
Received: from nevyn.them.org ([66.93.172.17]:62602 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750767AbVIUEDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 00:03:49 -0400
Date: Wed, 21 Sep 2005 00:03:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Message-ID: <20050921040342.GA7175@nevyn.them.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20050919193105.GA12810@verdi.suse.de> <1127158937.3455.214.camel@cog.beaverton.ibm.com> <20050919194934.GC12810@verdi.suse.de> <1127242785.11080.20.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127242785.11080.20.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 11:59:45AM -0700, john stultz wrote:
> So, bugzilla.kernel.org has (temporarily at least) lost the reports from
> yesterday, but from the email i got, folks using my TSC consistency
> check that I posted were seeing what appears to be unsynched TSCs on
> dualcore AMD systems.
> 
> Personally I suspect that the powernow driver is putting the cores
> independently into low power sleep and the TSCs are being independently
> halted, causing them to become unsynchronized.
> 
> Do you still feel there is some other issue here? Any ideas for shaking
> out whatever else might in play?

FYI, at least I have reproduced this without powernow loaded.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
