Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUC0POH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbUC0POH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:14:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261785AbUC0POF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:14:05 -0500
Date: Sat, 27 Mar 2004 10:13:41 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Daniel Forrest <forrest@lmcg.wisc.edu>, linux-kernel@vger.kernel.org
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
Message-ID: <20040327151341.GP31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu> <20040327142459.GF21884@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327142459.GF21884@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 02:24:59PM +0000, Jamie Lokier wrote:
> GCC's manual claims that fsin, fcos and fsqrt instructions are only
> used if the -funsafe-math-optimizations flag is also used, if the GCC
> version is >= 2.6.1.  However you may find that Glibc's <math.h> ends
> up using those instructions when -ffast-math is used alone.

Well, -ffast-math sets -funsafe-math-optimizations, unless you do
-ffast-math -fno-unsafe-math-optimizations, so the difference is not that
big.  glibc math inlines will be eventually replaced by GCC builtins as soon
as GCC is known to optimize at least as good as glibc's math inlines and so
even that difference will cease to exist.

	Jakub
