Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVBZGOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVBZGOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 01:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVBZGOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 01:14:14 -0500
Received: from smtp9.wanadoo.fr ([193.252.22.22]:31674 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261526AbVBZGOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 01:14:09 -0500
X-ME-UUID: 20050226061407854.D0B282400116@mwinf0909.wanadoo.fr
Date: Sat, 26 Feb 2005 07:04:35 +0100
To: Christian <evil@g-house.de>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Tom Rini <trini@kernel.crashing.org>,
       Meelis Roos <mroos@linux.ee>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050226060435.GA16401@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de> <20050225063609.GA21244@pegasos> <49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org> <20050225121536.GA20174@pegasos> <421FEF81.2070806@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <421FEF81.2070806@g-house.de>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 04:39:45AM +0100, Christian wrote:
> Sven Luther wrote:
> >Some backports that i got from the list. The complete list of patches is 
> >at :
> >
> >  http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/?rev=0&sc=0
> 
> dooh, these websvn patches are giving me a headache.... will have to 
> learn /usr/bin/svn first :-\

Well : 

  svn co svn://svn.debian.org/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches

> >--- kernel-source-2.6.8.orig/arch/ppc/platforms/prep_pci.c	2004-12-28
> 
> yes, the prep_pci.c and its irq-mappings. the PowerStackII lines were 
> changed back and forth, and a current 2.6-BK is only different in one 
> line to the patch you mentioned:

I guess the one line is the one for the IDE device, ..., indeed. The one line
in question is to enable the onboard IDE controller, which exist but is
probably not used, since the place on the board where it should be has no
connector soldered. I hear that there is an IDE powerstack II model though, so
...

> http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/powerpc-prep-powerstack-irq_2.6.11-rc5.patch
> 
> unfortunately it did not help either and i'll switch back to vanilla 
> 2.6.8 again and hopefully find out exactly when scsi stopped working.

As i understand leigh's and other post, i believe that this is the fix, but
that other stuff went in too which did break.

> http://nerdbynature.de/bits/hal/2.6.11-rc5/
> http://nerdbynature.de/bits/hal/2.6.11-rc5.patched/

Friendly,

Sven Luther

