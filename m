Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbUAZXWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUAZXWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:22:02 -0500
Received: from gprs40-2.eurotel.cz ([160.218.40.2]:5184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265337AbUAZXWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:22:00 -0500
Date: Tue, 27 Jan 2004 00:21:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-ID: <20040126232148.GF310@elf.ucw.cz>
References: <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux> <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost> <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost> <1074912854.834.61.camel@gaston> <20040126181004.GB315@elf.ucw.cz> <1075154452.6191.91.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075154452.6191.91.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ah, also: The "Freeing memory" phase takes forever. That should
> > > really be fixed.
> > 
> > Well, it does the trick for me, but it takes 50% or so of suspend
> > time. Some memory managment guru making "freeing memory" faster would
> > certainly be welcome.
> > 								Pavel
> > PS: But I'd like to keep it simple...
> 
> Haven't looked at it yet. Several crash reports so far, mostly
> lockups right after printing the number of pages to save. I wonder
> if we have something broken in there. It dies for me once too at
> this point.
> 
> Also, at least on pmac laptops, the HD is usually so fast, that
> I suspect spending 10 seconds freeing things is less efficient than
> spending this 10 seconds writing 200Mb of data to disk :) Also, one
> wakup, it's quite painful to see everything be swapped in again. It
> may make sense to be less agressive on the memory freeing, though
> finding a good balance isn't easy.

Notice that swsusp needs half of physical memory free by design. That
means that we need _some_ freeing. Nigel's swsusp2 works around that
at cost of more complicated implementation.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
