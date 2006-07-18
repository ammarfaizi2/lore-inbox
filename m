Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWGRT3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWGRT3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWGRT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:29:33 -0400
Received: from betty.vergenet.net ([64.85.198.114]:46464 "EHLO
	betty.vergenet.net") by vger.kernel.org with ESMTP id S932365AbWGRT3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:29:32 -0400
Date: Tue, 18 Jul 2006 15:13:48 -0400
From: Horms <horms@verge.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, rmk@arm.linux.org.uk, tony.luck@intel.com, paulus@samba.org,
       anton@samba.org, chris@zankel.net, linux-ia64@vger.kernel.org,
       linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
Message-ID: <20060718191345.GE20141@verge.net.au>
References: <31687.FP.7244@verge.net.au> <200607180027.51986.ak@suse.de> <20060717231056.GC12463@verge.net.au> <20060717172341.6d49f109.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717172341.6d49f109.akpm@osdl.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 05:23:41PM -0700, Andrew Morton wrote:
> On Mon, 17 Jul 2006 19:10:59 -0400
> Horms <horms@verge.net.au> wrote:
> 
> > On Tue, Jul 18, 2006 at 12:27:51AM +0200, Andi Kleen wrote:
> > > On Monday 17 July 2006 18:17, Horms wrote:
> > > ...
> > > Keeping the delay might be actually useful so that you can see the panic
> > > before system reboots when reboot on panic is enabled. I would just use a loop
> > > of mdelays(1) with touch_nmi_watchdog/touch_softirq_watchdog()s
> > > inbetween.
> > 
> > Ok, I will look into making that happen. I agree that the pause is
> > quite useful.
> 
> It's kind-of already implemented, via pause_on_oops.  Perhaps doing
> something like 
> 
> 	if (panic_on_oops)
> 		pause_on_oops = max(pause_on_oops, 5*HZ);
> 
> would be sufficient.

Thanks, that may well be sufficient. And I assume that it is nicely out
of the arch-dependant code in die(). I will poke around a bit more.

-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

