Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWDRJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWDRJnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDRJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:43:20 -0400
Received: from [205.233.219.253] ([205.233.219.253]:22976 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1750734AbWDRJnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:43:19 -0400
Date: Tue, 18 Apr 2006 05:41:30 -0400
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/4] sbp2: improved handling of device quirks
Message-ID: <20060418094130.GI5346@conscoop.ottawa.on.ca>
References: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.c5c36090a52cc591@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 02:50:06PM +0200, Stefan Richter wrote:
> Hi all,
> 
> the following series of patches reworks and adds to sbp2's handling of
> buggy SBP-2 hardware:

All applied.

Thanks,
Jody

> 
> 
> [PATCH 1/4] sbp2: consolidate workarounds
> -----------------------------------------
> Basically a refactoring, eases the integration of further workarounds.
> This patch was posted on linux1394-devel before.
> 
> 
> [PATCH 2/4] sbp2: add read_capacity workaround for iPod
> -------------------------------------------------------
> There is a bug in newer iPod firmwares which causes IO errors as soon
> as an iPod is plugged in, making it inaccessible. Usb-storage, which
> has to deal with the same problem, already has the same workaround we
> are adding here. The issue has only recently become known to also
> affect FireWire iPods.
> 
> This patch of the series is actually the reason why I'm Cc'ing LKML
> and AKPM: It'd be nice to have this merged sooner than later since
> distribution kernels ship in configurations now which uncover this
> device bug (particularly when EFI partion support is enabled).
> 
> This patch was posted on linux1394-devel before but I updated it
> today to cover two more affected iPod models.
> Requires PATCH 1/4.
> 
> 
> [PATCH 3/4] sbp2: make TSB42AA9 workaround specific to Momobay CX-1
> -------------------------------------------------------------------
> Makes an existing blacklist entry more specific, although no actual
> harm was done when this workaround caught devices which did not
> really need it.
> 
> This patch was posted on linux1394-devel before.
> Requires PATCH 1/4.
> 
> 
> [PATCH 4/4] sbp2: add ability to override hardwired blacklist
> -------------------------------------------------------------
> Some of the workarounds which are triggered by sbp2's built-in
> blacklist may be degrading or even disruptive if unintentionally
> applied to devices which don't require the workaround. As a quick
> countermeasure which does not require users to recompile the driver,
> a new flag for sbp2's respective module load parameter is provided
> which disables the blacklist lookup.
> 
> Note: There has no such problem occured in the past, however as we
> are adding more workarounds, such setbacks could become more likely.
> 
> This is a new patch.
> Requires PATCH 1/4, also needs PATCH 2/4 to apply without rejects.
> 
> -- 
> Stefan Richter
> -=====-=-==- -=-- -===-
> http://arcgraph.de/sr/
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
