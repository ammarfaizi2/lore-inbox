Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUKDAMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUKDAMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbUKDAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:08:16 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:61069 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261993AbUKDAGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:06:03 -0500
Date: Thu, 4 Nov 2004 01:06:00 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Blaisorblade <blaisorblade_spam@yahoo.it>
cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
In-Reply-To: <200411032132.37947.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.61.0411040054580.877@scrub.home>
References: <20041102232001.370174C0BC@zion.localdomain>
 <Pine.LNX.4.61.0411031909460.877@scrub.home> <20041103183415.GH381@smtp.west.cox.net>
 <200411032132.37947.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Nov 2004, Blaisorblade wrote:

> You later say "If possible, I'd avoid this patch at all". Why? Is this code 
> too intrusive, or implementing a wrong check, or bloating the source?

It adds a special case to the kconfig core to make it behave differently, 
but it shouldn't behave differently depending on how the kernel is 
compiled.

> > > E.g. if someone wrote a patch which stores the arch in .config and warns/
> > > refuses to load it for a different configuration, I would accept it
> > > happily.
> Yes, this is another idea, which is also fine, while not excluding the other 
> IMHO.

This is the better solution, because it solves the more general problem, 
when a .config doesn't match the Kconfig and not just your special case.

> > We already have part of this, except I don't know for certain of
> > CONFIG_ARCH == CONFIG_$(SUBARCH) (... to mix syntax all the hell up).
> 
> No warning is output. Or better, yes, you get warnings, but tons of not clear 
> ones, like "warning, undefined symbol".

I don't really expect to use CONFIG_$(SUBARCH) and rather add a real 
CONFIG_ARCH to Kconfig.

bye, Roman

