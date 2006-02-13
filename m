Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWBMSvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWBMSvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWBMSvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:51:54 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:42936 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964784AbWBMSvy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:51:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KInkry6I8oS3koOf0aODQbtPSz+klMgENju7oZPHvnyapS30eqbY93ad1I9EM9CV++LuDzQZY7MgMyEZ2ectf+HnEtbjf7Epzehbqor1tAFxfZzyVPN575yBwAoUipQSiy8j6ArJn4klIS/KDrKqTmLsL0M/oRQXo86qIDdF59Q=
Message-ID: <a728f9f90602131051y3fc87256w3225c32b1ae27648@mail.gmail.com>
Date: Mon, 13 Feb 2006 13:51:50 -0500
From: Alex Deucher <alexdeucher@gmail.com>
To: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213184209.GC32350@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
	 <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
	 <20060213183445.GA3588@stusta.de> <20060213184209.GC32350@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Dave Jones <davej@redhat.com> wrote:
> On Mon, Feb 13, 2006 at 07:34:45PM +0100, Adrian Bunk wrote:
>  > On Mon, Feb 13, 2006 at 10:16:59AM -0800, Linus Torvalds wrote:
>  > >
>  > >
>  > > On Mon, 13 Feb 2006, Linus Torvalds wrote:
>  > > >
>  > > > DaveA, I'll apply this for now. Comments?
>  > >
>  > > Btw, the fact that Mauro has the same exact PCI ID (well, lspci stupidly
>  > > suppresses the ID entirely, but the string seems to match the one that
>  > > Dave Jones reports) may be unrelated.
>  >
>  > Dave's patch removes the entry for the card with the 0x5b60.
>  > According to his bug report, Mauro has a Radeon X300SE that should
>  > have the 0x5b70 according to pci.ids from pciutils and that doesn't seem
>  > to be claimed by the DRM driver (and the dmesg from the bug report
>  > confirms that the radeon DRM driver didn't claim to be responsible for
>  > this card).
>
> The X300SE (mine at least) is a dual head card, with a 0x5b60 _and_ a 0x5b70
>
>                 Dave
>

The secondary id is just a place holder for the windows driver so
dualhead will work on windows 2000.  Neither the drm nor the xorg DDX
uses the secondary id.

Alex
