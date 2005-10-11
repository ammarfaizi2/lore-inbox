Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVJKCWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVJKCWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 22:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVJKCWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 22:22:43 -0400
Received: from mtl.rackplans.net ([65.39.167.249]:63980 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S1751349AbVJKCWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 22:22:43 -0400
Date: Mon, 10 Oct 2005 22:22:37 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Lars Roland <lroland@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Direct Rendering drivers for ATI X300 ?
In-Reply-To: <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0510102221320.26127@innerfire.net>
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
 <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the problem.. there is no entry in pciids.h for my card:

0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 
[Radeon X300 (PCIE)]
0000:05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon 
X300SE]

0000:05:00.0 0300: 1002:5b60
0000:05:00.1 0380: 1002:5b70


On Mon, 10 Oct 2005, Lars Roland wrote:

> Date: Mon, 10 Oct 2005 21:00:42 +0200
> From: Lars Roland <lroland@gmail.com>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Direct Rendering drivers for ATI X300 ?
> 
> On 10/10/05, Gerhard Mack <gmack@innerfire.net> wrote:
> > Hello,
> >
> > Can anyone tell me if there are working open source DRM drivers that work
> > on recent 2.6.x kernels for the ATI X300?  I've tried dri.sourceforge.net
> > and r300 but neither seems to even bother compiling.  I've spent several
> > hours on google without luck.
> >
> >         Gerhard
> 
> What are your dmesg reporting, when loading the modules, if you see
> something along these lines:
> 
> -------------------
> [drm] Initialized drm 1.0.0 20040925
> PCI: Unable to reserve mem region #1:8000000@c0000000 for device 0000:01:00.0
> [drm] Initialized radeon 1.19.0 20050911 on minor 0:
> [drm] Used old pci detect: framebuffer loaded
> mtrr: 0xc0000000,0x8000000 overlaps existing 0xc0000000,0x4000000
> [drm:radeon_do_init_cp] *ERROR* Cannot use PCI Express without GART in
> FB memory
> -------------------
> 
> then you may have hit a possible x300/pci express issue - other than
> that I have it working perfectly here with kernel 2.6.14rc1, Quake3 is
> playable (although I am experiencing some minor problems with MergedFB
> combined with 3D gaming). I have written a small guide for Gentoo that
> explains how to get DRI/DRM working with R300 (and newer cards) all
> though you may not use Gentoo it should be very easy to get it working
> on other distributions:
> 
> The guide is here:
> http://forums.gentoo.org/viewtopic-t-374745-highlight-r300.html
> 
> 
> --------------
> Regards.
> 
> Lars Roland
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
