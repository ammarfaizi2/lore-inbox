Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWBBTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWBBTjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWBBTjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:39:10 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:36048 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751177AbWBBTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:39:08 -0500
X-ORBL: [67.117.73.34]
Date: Thu, 2 Feb 2006 11:38:33 -0800
From: Tony Lindgren <tony@atomide.com>
To: Erik Slagter <erik@slagter.name>
Cc: linux-acpi@vger.kernel.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Joerg Sommrey <jo@sommrey.de>,
       Andrew Morton <akpm@osdl.org>, Len <len.brown@intel.com>,
       Brown@skylla.slagter.name, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060202193833.GM15939@atomide.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EC94C3@hdsmsx401.amr.corp.intel.com> <1138845041.5557.20.camel@localhost.localdomain> <1138873815.4449.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138873815.4449.61.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Slagter <erik@slagter.name> [060202 01:50]:
> On Thu, 2006-02-02 at 01:50 +0000, Alan Cox wrote:
> > On Mer, 2006-02-01 at 20:35 -0500, Brown, Len wrote:
> > > This endeavor is full of risk, and I would be extremely careful
> > > about enabling features that the BIOS explicitly disabled --
> > > unless the hardware manufacturer publicly publishes
> > > support for the feature, or the errata that you're working around.

Well the same code could also be used to disable C states on buggy
hardware. On my Fujitsu Lifebook p2120 C states are enabled, but don't
work. But we don't have currently anything in place to fix them or
disable them. And enabling C states on amd76x could be a cmdline option.
 
> > Folks had code that supported AMD76x by banging the hardware directly.
> > On some AMD76x systems it caused corruption. Nobody AFAIK ever figured
> > out if it was an errata (nothing obvious in the docs/errata list) or a
> > bug in the code doing the banging on the chip or some other bit of
> > hardware on the mainboard that needed extra handling.
> 
> Looks like it would be beneficial if someone, preferably with some
> authority ;-), would try to get Tyan and/or AMD to reveal this
> information.
> 
> I have read the docs for the AMD768 chipset numerous times, but I least
> I (okay okay, I am not the expert here ;-)) cannot find anything that
> would prevent this from working correctly.
> 
> AFAIK Tyan has been more or less cooperative with linux developers in
> the past?! I'd be more than happy to ask them, but I don't think they
> will take me very serious

The C states on amd76x are quite usable. The only problem I had on my
Tyan s2460 was the some BIOS bug puts the machine into sleep at first
when they're enabled :) This does not happen on other systems.

Tony

