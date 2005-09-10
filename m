Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVIJBoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVIJBoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVIJBoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:44:46 -0400
Received: from fsmlabs.com ([168.103.115.128]:59525 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1030454AbVIJBop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:44:45 -0400
Date: Fri, 9 Sep 2005 18:51:08 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat
 mode
In-Reply-To: <20050910003022.GB61151@muc.de>
Message-ID: <Pine.LNX.4.61.0509091849310.978@montezuma.fsmlabs.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net>
 <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com>
 <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com> <20050910003022.GB61151@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2005, Andi Kleen wrote:

> On Fri, Sep 09, 2005 at 10:07:28AM -0700, Zwane Mwaikambo wrote:
> > On Tue, 6 Sep 2005, Ashok Raj wrote:
> > 
> > > On Tue, Sep 06, 2005 at 01:16:28AM +0200, Andi Kleen wrote:
> > > > On Sat, Sep 03, 2005 at 02:33:30PM -0700, akpm@osdl.org wrote:
> > > > > 
> > > > > From: Ashok Raj <ashok.raj@intel.com>
> > > > > 
> > > > > Newly introduced physflat_* shares way too much with cluster with only a very
> > > > > differences.  So we introduce some common functions in that can be reused in
> > > > > both cases.
> > 
> > On a slightly different topic, how come we're using physflat for hotplug 
> > cpu?
> 
> The original idea was to always use physflat mode for hotplug because
> that does all the sequencing stuff and avoids the shortcut races.
> But then Ashok decided it was better to add more ifdefs to flat mode
> instead and I gave up protesting at some point.

Ok so you wanted to segragate them, i can understand that, but didn't we 
have a version which worked around the races by doing the same thing, 
hotplug or not? Is this the one where you weren't pleased with the 
supposed execution penalty?

Thanks,
	Zwane

