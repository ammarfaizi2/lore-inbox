Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWCDPWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCDPWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 10:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWCDPWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 10:22:13 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:6361 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751315AbWCDPWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 10:22:12 -0500
Date: Sat, 4 Mar 2006 02:34:36 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Message-ID: <20060304023436.GA4178@linux-mips.org>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com> <20060303.114406.64806237.nemoto@toshiba-tops.co.jp> <1141409638.9727.17.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141409638.9727.17.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 10:13:58AM -0800, john stultz wrote:

> > In kernel 2.6, update_times() is called directly in timer interrupt,
> > so there is no point calculating ticks here.  Then update_wall_time()
> > and calc_load() can also be optimized.  This also get rid of
> > difference of jiffies and jiffies_64 due to compiler's optimization
> > (which was reported previously with subject "jiffies_64 vs. jiffies").
> 
> 
> I'm not opposed to this change, but I'm not sure if the barrier with a
> clear comment as to why its needed might be better in the short term.

A good fix is harder than it looks and with your patches on the horizon
it seems the safest to get a stable 2.6.16 out of the door is the barrier.

  Ralf
