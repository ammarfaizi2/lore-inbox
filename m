Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263701AbUECPKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUECPKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUECPKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:10:07 -0400
Received: from vena.lwn.net ([206.168.112.25]:17103 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263701AbUECPKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:10:02 -0400
Message-ID: <20040503150958.6864.qmail@lwn.net>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Sat, 01 May 2004 00:07:40 +0200."
             <20040430220740.GA45095@colin2.muc.de> 
Date: Mon, 03 May 2004 09:09:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "Nuts" means that the X server goes into an unkillable, 100% system time
> > state.  It manages to scribble a mess onto the screen first.  Pointer moves
> > (I believe that's in hardware) but the server does not respond to anything.
> 
> Most likely it is a problem with the AGP driver. I assume you have AGP 
> compiled in. Does it work when you boot with agp=off ? 

If you turn on CONFIG_GART_IOMMU, it seems to force CONFIG_AGP as well, so
yes.  And yes, if I boot with agp-off, it works.

Andrew had asked:

> There are various loops where the driver spins on a
> hardware register, with an mdelay() in the loop.
> 
> Can you get a sysrq-p trace?

There's this little problem in that, to make things go wrong, I have to
fire up X.  That pretty well hoses the display, and an attempt to chvt back
to a regular console just hangs.  I guess I may have to dig in and try to
track this one down the hard way; wish I knew more about AGP hardware...

Thanks,

jon

