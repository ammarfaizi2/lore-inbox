Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVCUXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVCUXqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:38079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262169AbVCUXl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:41:27 -0500
X-Authenticated: #20450766
Date: Tue, 22 Mar 2005 00:40:34 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, jim.hague@acm.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
In-Reply-To: <20050321145936.6f742d89.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
 <20050321145936.6f742d89.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andrew Morton wrote:

> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >
> > Hi
> > 
> > Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text 
> > becomes orange, penguins look sick (not sharp). X starts and runs normal 
> > (doesn't use fb), switching to vt not possible any more. Disabling 
> > fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the 
> > problem.
> 
> Guennadi, could you please confirm that
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
> 
> fixes this one?

As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X 
switching problem. We still don't know why starting with 2.4.11 I have to 
switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images. Jim 
says it is doubtful that this option brings any optimisations at all, 
still, it is a bit worrying, that something that worked with earlier 
kernels stopped working now. I traced this breakage down to the patch to 
pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem with 
my fb-geometry / colour settings, but I haven't heard from him since then, 
Jim?

Thanks
Guennadi
---
Guennadi Liakhovetski

