Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbRCaAlb>; Fri, 30 Mar 2001 19:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRCaAlZ>; Fri, 30 Mar 2001 19:41:25 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:55817 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131791AbRCaAlC>;
	Fri, 30 Mar 2001 19:41:02 -0500
Date: Sat, 31 Mar 2001 02:39:52 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Pavel Machek <pavel@suse.cz>, Russell King <rmk@arm.linux.org.uk>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010331023952.C6784@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0103281948200.1748-100000@linux.local>; from jsimmons@linux-fbdev.org on Wed, Mar 28, 2001 at 07:54:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Ug!!! This is getting bad. Give me some time. I plan on releasing a new
> vesafb using MMX to help speed up the drawing routines. It will help alot
> with the latency issues. I also know using ARM assembly we can greatly
> reduce the latency issues.

There is another issue with vesafb.  It tries to use an MTRR, but this
fails for the 2.5MB region that is video RAM because 2.5MB is not a
power of two.

The console driver does not actually use 2.5MB.  Does it make sense to
use an MTRR for the smaller power-of-two region?

-- Jamie
