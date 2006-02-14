Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422883AbWBNX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWBNX4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBNX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:56:05 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:14981 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1422883AbWBNX4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:56:03 -0500
Date: Tue, 14 Feb 2006 18:55:12 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Adrian Bunk <bunk@stusta.de>
cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213183445.GA3588@stusta.de>
Message-ID: <Pine.LNX.4.64.0602141851530.18291@innerfire.net>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213183445.GA3588@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Adrian Bunk wrote:

> Date: Mon, 13 Feb 2006 19:34:45 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: Linus Torvalds <torvalds@osdl.org>
> Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
>     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>     Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
>     dri-devel@lists.sourceforge.net
> Subject: Re: 2.6.16-rc3: more regressions
> 
> On Mon, Feb 13, 2006 at 10:16:59AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 13 Feb 2006, Linus Torvalds wrote:
> > > 
> > > DaveA, I'll apply this for now. Comments?
> > 
> > Btw, the fact that Mauro has the same exact PCI ID (well, lspci stupidly 
> > suppresses the ID entirely, but the string seems to match the one that 
> > Dave Jones reports) may be unrelated.
> 
> Dave's patch removes the entry for the card with the 0x5b60.
> 
> According to his bug report, Mauro has a Radeon X300SE that should 
> have the 0x5b70 according to pci.ids from pciutils and that doesn't seem 
> to be claimed by the DRM driver (and the dmesg from the bug report 
> confirms that the radeon DRM driver didn't claim to be responsible for 
> this card).
> 
> > DaveJ (or Mauro): since you can test this, can you test having that ID 
> > there but _without_ the other changes to drm in -rc1?
> > 
> > Ie was it the addition of that particular ID, or are the other radeon
> > driver changes (which haven't had as much testing) perhaps the culprit?
> > 
> > I realize that without the ID, that card would never have been tested 
> > anyway, but the point being that plain 2.6.15 with _just_ that ID added 
> > has at least gotten more testing on other (similar) chips. So before I 
> > revert that particular ID, it would be nice to know that it was broken 
> > even with the previous radeon driver state.
> 
> The ID removed by Dave's patch is the only ID listed for an RV370 chips 
> (the other RV370's aren't listed in the radeon DRM driver).
> 
> I suspect Dave and Mauro having unrelated problems.
> 
> > 		Linus
> 
> cu
> Adrian

The X300 has two pci ids:
0000:05:00.0 0300: 1002:5b60
0000:05:00.1 0380: 1002:5b70

0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 
[Radeon X300 (PCIE)]
0000:05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon 
X300SE]

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
