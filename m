Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTHLRJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 13:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTHLRJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 13:09:26 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:17297
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S271026AbTHLRJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 13:09:21 -0400
Date: Tue, 12 Aug 2003 13:09:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Jon Burgess <mplayer@jburgess.uklinux.net>,
       linux kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030812170920.GB24774@gtf.org>
References: <3F38F5EC.2060003@jburgess.uklinux.net> <20030812163311.GL31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812163311.GL31810@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:33:11AM -0500, Matt Mackall wrote:
> On Tue, Aug 12, 2003 at 03:13:00PM +0100, Jon Burgess wrote:
> > Matt Mackall wrote:
> > > I've decided to take a stab at resurrecting Ingo's netconsole patch.
> > 
> > Is this different from the netdump patch which RedHat include in their 
> > kernel?
> > 
> > The RH kernel patch is at
> > http://www.kernelnewbies.org/kernels/rh9/SOURCES/linux-2.4.18-netdump.patch
> 
> Ahh, so that's what's become of it.
> 
> Theirs:
> - does crashdumps
> - does syslog without levels
> - has hooks for receive
> 
> Mine:
> - works in 2.6
> - has non-appalling configuration
> - works as a built-in and is available earlier in boot
> - does syslog with levels (haven't posted this though)

netconsole does syslog with levels, too.  I agree netdump/netconsole
have complete awful configuration.  I was thinking netlink would be a
good configurator.

The kernel printk <foo> prefixes map into syslog quite nicely.

In any case, there is my own active effort into cleaning up netdump to
be less x86-specific, and get it ready for mainline.

Maybe we can start discussing converging all these implementations on
netdev@oss.sgi.com?  (that's where the networking developers live)

	Jeff



