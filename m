Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWBMSer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWBMSer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWBMSer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:34:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21511 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932397AbWBMSeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:34:46 -0500
Date: Mon, 13 Feb 2006 19:34:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213183445.GA3588@stusta.de>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org> <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org> <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:16:59AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 13 Feb 2006, Linus Torvalds wrote:
> > 
> > DaveA, I'll apply this for now. Comments?
> 
> Btw, the fact that Mauro has the same exact PCI ID (well, lspci stupidly 
> suppresses the ID entirely, but the string seems to match the one that 
> Dave Jones reports) may be unrelated.

Dave's patch removes the entry for the card with the 0x5b60.

According to his bug report, Mauro has a Radeon X300SE that should 
have the 0x5b70 according to pci.ids from pciutils and that doesn't seem 
to be claimed by the DRM driver (and the dmesg from the bug report 
confirms that the radeon DRM driver didn't claim to be responsible for 
this card).

> DaveJ (or Mauro): since you can test this, can you test having that ID 
> there but _without_ the other changes to drm in -rc1?
> 
> Ie was it the addition of that particular ID, or are the other radeon
> driver changes (which haven't had as much testing) perhaps the culprit?
> 
> I realize that without the ID, that card would never have been tested 
> anyway, but the point being that plain 2.6.15 with _just_ that ID added 
> has at least gotten more testing on other (similar) chips. So before I 
> revert that particular ID, it would be nice to know that it was broken 
> even with the previous radeon driver state.

The ID removed by Dave's patch is the only ID listed for an RV370 chips 
(the other RV370's aren't listed in the radeon DRM driver).

I suspect Dave and Mauro having unrelated problems.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

