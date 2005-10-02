Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVJBIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVJBIFE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 04:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVJBIFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 04:05:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:24979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751010AbVJBIFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 04:05:03 -0400
Subject: Re: [PATCH] nvidiafb: PPC & mode setting fixes (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <433F8774.6000301@gmail.com>
References: <1128225462.8267.24.camel@gaston>
	 <1128232186.8267.31.camel@gaston>  <433F8774.6000301@gmail.com>
Content-Type: text/plain
Date: Sun, 02 Oct 2005 18:02:06 +1000
Message-Id: <1128240126.8267.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-02 at 15:08 +0800, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
> > (This version removes a useless bit that slipped in the previous one)
> > 
> > This patch fixes a couple of things in nvidiafb:
> > 
> >  - The code for retreiving the mode from Open Firmware was broken. It
> > would crash at boot and was copied from the old rivafb code that didn't
> > work very well (I'll update rivafb too one of these days).
> 
> What do you think of making EDID retrieval from the OF generic?  Or is
> it too much hassle?

Well, at this point, it only really concerns nvidia and ati's and their
respective firmwares seem to expose some properties a bit differently...
The radeon code would probably work for nvidia though as I'm not trying
to get the connector type for nvidiafb yet, but if I ever try, it seems
the stuff is a bit different.

I'd say let's keep them separate for now, I may put them in a common
place some day ..

Ben.

> Thanks for the fix :-)  
> 
> Acked-by: Antonino Daplas <adaplas@pol.net>

Ok, if you confirm it doesn't seem to do any regression on other
hardware (I don't have any other nvidia hw to test with), I'd like it
upstream asap (probably too late for 2.6.14 though).

Ben.


