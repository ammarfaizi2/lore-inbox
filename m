Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVL1AU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVL1AU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVL1AU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:20:57 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:56010 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932410AbVL1AU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:20:56 -0500
Date: Wed, 28 Dec 2005 01:20:42 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Gerhard Mack <gmack@innerfire.net>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: ati X300 support?
In-Reply-To: <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
Message-ID: <Pine.LNX.4.60.0512280103100.29982@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net>
 <200512270149.24440.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512270817340.15649@innerfire.net>
 <200512271545.31224.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0512271047260.2104@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Gerhard Mack wrote:

> I have it working in X.org with no problem.  I just can't get the drm
> module working in the kernel.  Last time I tried to just add my PCI ids 
> the problem was a lack of PCIE support in the drm drivers. 
> 
> FYI the fglrx drivers suck badly.  ATI hasn't bothered to keep their 
> drivers up to date at all and the result is that they finally have  
> working 2.6.14 drivers but only for 32 bit machines.  x86_64 is still 
> broken on any recent kernel and it's been that way for months.  ATI's tech 
> support basically gave up after several days and just informed me it 
> wasn't really supported and there is nothing they could do for me.

I don't want to defend ATI here or anything, but I use the 64-bit fglrx 
8.19.10 with 2.6.15-rc5 and it works (except for the minor patch for 
2.6.15-rc2-git3 and later that we came out with with Hugh Dickins and that 
was sent to the list not long ago).

The problem with PCIe is, that IMHO they do not activate the acceleration 
unless an AGP is detected (at least that's what it sounds to me like). If 
there is PCIe, there is no AGP, though AGP is not detected, and 
acceleration is not enabled. I think it may be as simple as that. I was 
reporting this to ATI a while ago. I haven't tried the new fglrx 8.20.8 
yet, but if they read the reports at all, then there's a good chance that 
this may be fixed there already.

Martin
