Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUBFM5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 07:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBFM5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 07:57:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7330 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264919AbUBFM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 07:57:11 -0500
Date: Fri, 6 Feb 2004 13:56:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040206125623.GC22597@atrey.karlin.mff.cuni.cz>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com> <20040205213837.GF1541@elf.ucw.cz> <20040205215620.GC9757@atomide.com> <20040206002806.GB1736@elf.ucw.cz> <20040206011509.GE10268@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206011509.GE10268@atomide.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Are the middle values needed? What if you only use the min and max 
> > > fid/vid values, and always recalculate the stepping tables from those 
> > > values?
> > 
> > Well, 1600MHz operation is very nice, as it has significantly less
> > power consumption but pretty much same performance. It also does not
> > start CPU fan most of the time :-).  
> 
> Yes, 1600MHz would be nice, I agree.
> 
> But I meant calculating all the valid values inbetween min and max without
> relying on getting those values from the BIOS.

I do not think values can be calculated by some simple
formula. voltage/frequency relations may be quite complex..

> I guess the code already does that to figure out how many steps are needed
> to change between min and max?

Well, but it steps voltage first, then frequency [going up] or
frequency first, voltage then [going down]; middle values used by the
transitions are not too good if you want to be power-efficient.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
