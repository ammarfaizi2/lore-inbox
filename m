Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUBFR2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbUBFR2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:28:11 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:59663
	"EHLO muru.com") by vger.kernel.org with ESMTP id S265546AbUBFR2H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:28:07 -0500
Date: Fri, 6 Feb 2004 09:28:16 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] powernow-k8 max speed sanity check
Message-ID: <20040206172815.GB8222@atomide.com>
References: <20040131203512.GA21909@atomide.com> <20040203131432.GE550@openzaurus.ucw.cz> <20040205181704.GC7658@atomide.com> <20040205184841.GB590@elf.ucw.cz> <20040205213303.GA9757@atomide.com> <20040205213837.GF1541@elf.ucw.cz> <20040205215620.GC9757@atomide.com> <20040206002806.GB1736@elf.ucw.cz> <20040206011509.GE10268@atomide.com> <20040206125623.GC22597@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206125623.GC22597@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [040206 04:57]:
> 
> > But I meant calculating all the valid values inbetween min and max without
> > relying on getting those values from the BIOS.
> 
> I do not think values can be calculated by some simple
> formula. voltage/frequency relations may be quite complex..
> 
> > I guess the code already does that to figure out how many steps are needed
> > to change between min and max?
> 
> Well, but it steps voltage first, then frequency [going up] or
> frequency first, voltage then [going down]; middle values used by the
> transitions are not too good if you want to be power-efficient.

OK, I see. Then your idea of using a lookup table for blacklisted BIOSes
makes good sense.

Tony
