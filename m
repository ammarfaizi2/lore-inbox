Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbVK2VwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVK2VwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVK2VwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:52:10 -0500
Received: from cantor2.suse.de ([195.135.220.15]:7628 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932430AbVK2VwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:52:09 -0500
Date: Tue, 29 Nov 2005 22:52:07 +0100
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129215207.GR19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133300591.3271.1.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 01:43:11PM -0800, Nicholas Miell wrote:
> On Tue, 2005-11-29 at 19:13 +0100, Andi Kleen wrote:
> > > Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
> > > to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
> > > the documentation, the 4 counters are symetrical and can measure
> > > any event that the processor offers.
> > 
> > Linux NMI watchdog does that.
> > 
> > All other perfctr users are supposed to keep their fingers away 
> > from the watchdog (it looks like oprofile doesn't but not for much
> > longer ...) 
> 
> Why? Hardcoding PMC 0 to be a cycle counter seems to be a waste of a
> perfectly usable performance counter. What if I want to profile four
> things, none of them requiring a cycle count?

You won't then anymore. Providing a full replacement for RDTSC is 
more important.

-Andi

