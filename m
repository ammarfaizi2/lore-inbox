Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRCaAyb>; Fri, 30 Mar 2001 19:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRCaAyV>; Fri, 30 Mar 2001 19:54:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59144 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131809AbRCaAyM>; Fri, 30 Mar 2001 19:54:12 -0500
Date: Sat, 31 Mar 2001 02:52:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: James Simmons <jsimmons@linux-fbdev.org>, Pavel Machek <pavel@suse.cz>,
   Russell King <rmk@arm.linux.org.uk>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010331025233.A6086@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local> <20010331023952.C6784@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010331023952.C6784@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sat, Mar 31, 2001 at 02:39:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ug!!! This is getting bad. Give me some time. I plan on releasing a new
> > vesafb using MMX to help speed up the drawing routines. It will help alot
> > with the latency issues. I also know using ARM assembly we can greatly
> > reduce the latency issues.
> 
> There is another issue with vesafb.  It tries to use an MTRR, but this
> fails for the 2.5MB region that is video RAM because 2.5MB is not a
> power of two.
> 
> The console driver does not actually use 2.5MB.  Does it make sense to
> use an MTRR for the smaller power-of-two region?

I had patch which tried that at one point. Just try all 2^n numbers
<= size until it succeeds.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
