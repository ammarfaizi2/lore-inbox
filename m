Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWJPIiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWJPIiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWJPIiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:38:00 -0400
Received: from mail.gmx.de ([213.165.64.20]:44164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964841AbWJPIh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:37:59 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0610160107qff115d2r8adef99452560e16@mail.gmail.com>
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
	 <1160976752.6477.3.camel@Homer.simpson.net>
	 <b0943d9e0610160107qff115d2r8adef99452560e16@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 09:08:30 +0000
Message-Id: <1160989710.17131.14.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 09:07 +0100, Catalin Marinas wrote:
> On 16/10/06, Mike Galbraith <efault@gmx.de> wrote:
> > On Sun, 2006-10-15 at 07:59 +0000, Mike Galbraith wrote:
> >
> > > 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
> > > CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
> > > runs a lot faster ;-)  I'll try a stripped down config sometime.
> >
> > My roughly three orders of magnitude (amusing to watch:) boot slowdown
> > turned out to be stack unwinding.  With CONFIG_UNWIND_INFO disabled,
> > 2.6.19-rc2 + patch-2.6.19-rc1-kmemleak-0.11 runs just fine.
> 
> Kmemleak introduces some overhead but shouldn't be that bad.
> DEBUG_SLAB also introduces an overhead by erasing the data in the
> allocated blocks.

2.6.18 with your rc6 patch booted normally with stack unwind enabled.

	-Mike 

