Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSLaJZN>; Tue, 31 Dec 2002 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSLaJZN>; Tue, 31 Dec 2002 04:25:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:36737 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266078AbSLaJZM>;
	Tue, 31 Dec 2002 04:25:12 -0500
Date: Tue, 31 Dec 2002 01:33:17 -0800
From: Richard Henderson <rth@twiddle.net>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [FB PATCH] cfbimgblt isn't 64-bit clean
Message-ID: <20021231013317.A14112@twiddle.net>
Mail-Followup-To: Antonino Daplas <adaplas@pol.net>,
	James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org> <1041173861.1013.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041173861.1013.9.camel@localhost.localdomain>; from adaplas@pol.net on Sun, Dec 29, 2002 at 10:58:43PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 10:58:43PM +0800, Antonino Daplas wrote:
> Only fast_imageblit() should be affected.  color_imageblit() and
> slow_imageblit() will not be affected.  

Indeed.

> Or we can change fast_imageblit() to always access the framebuffer
> memory 32-bits at a time. The attached patch should fix this.

This is probably better than the wholesale conversion to
32-bits that I did.

For the most part I don't care anymore; I've implemented a
hardware accelerated version for depth==1 in tgafb.c now.  ;-)


r~
