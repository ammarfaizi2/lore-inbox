Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUHXVIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUHXVIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUHXVIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:08:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:5585 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268326AbUHXVIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:08:49 -0400
Date: Tue, 24 Aug 2004 23:14:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, LKML <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
In-Reply-To: <20040824204611.GB26136@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0408242302540.2770@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
 <16683.22576.781038.756277@alkaid.it.uu.se>
 <Pine.LNX.4.61.0408241859420.2770@dragon.hygekrogen.localhost>
 <20040824182930.GA7260@mars.ravnborg.org> <Pine.LNX.4.61.0408242129130.2770@dragon.hygekrogen.localhost>
 <20040824204611.GB26136@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Sam Ravnborg wrote:

> On Tue, Aug 24, 2004 at 09:33:09PM +0200, Jesper Juhl wrote:
> > 
> > Which brings me to another thing regarding configs and defaults - there 
> > does not seem to be much relation between the defaults in the various 
> > Kconfig files and the settings in arch/<foo>/defconfig which puzzles me, 
> > especially since "make defconfig" seems to use the stuff from 
> > arch/<foo>/defconfig and not what's specified in Kconfig...
> > Wouldn't it make sense to update the defconfig's to match the Kconfig's 
> > when I make these changes?
> 
> defconfig is only subject for changes by arch-maintainers.
> And defaults provided in Kconfig is mainly valid for i386 anyway -
> so are the Kconfig help text.
> 
Ok, thank you for enlightening me on that. So defaults are chosen first 
from defconfig, and then from Kconfig for options not present in 
defconfig.

I guess I should limit myself to i386 for this or maybe just abandon it 
alltogether. 
It still seems like a good idea though to make the defaults (at least on 
i386) match the help text recommendations, but if defconfig is used over 
Kconfig and defconfig is more or less off-limits, and changing Kconfig 
would result in wrong defaults on other archs (which would then cause more 
work for arch maintainers with updating their defconfig), then maybe it's 
really not such a good idea after all to go about changing this.

I'll stay away from making these changes for now unless I run across some 
really obvious and non-problematic cases.

--
Jesper Juhl

