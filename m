Return-Path: <linux-kernel-owner+w=401wt.eu-S1750990AbXAVIDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbXAVIDX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXAVIDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:03:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60045 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750741AbXAVIDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:03:22 -0500
Date: Mon, 22 Jan 2007 19:03:06 +1100
From: David Chinner <dgc@sgi.com>
To: Stefan Priebe - FH <studium@profihost.com>
Cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: XFS or Kernel Problem / Bug
Message-ID: <20070122080306.GW33919298@melbourne.sgi.com>
References: <20060801143212.D2326184@wobbly.melbourne.sgi.com> <44CEDA1D.5060607@profihost.com> <20060801143803.E2326184@wobbly.melbourne.sgi.com> <44CF36FB.6070606@profihost.com> <20060802090915.C2344877@wobbly.melbourne.sgi.com> <44D07AB7.3020409@profihost.com> <20060802201805.A2360409@wobbly.melbourne.sgi.com> <45B35CD7.4080801@profihost.com> <20070122061852.GT33919298@melbourne.sgi.com> <45B46CEE.4090808@profihost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B46CEE.4090808@profihost.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2007 at 08:51:10AM +0100, Stefan Priebe - FH wrote:
> Hi!
> 
> I'm  not shure but perhaps it isn't an XFS Bug.
> 
> Here is what i find out:
> 
> We've about 300 servers at the momentan and 5 of them are "old" Intel 
> Pentium 4 Machines with a DFI PM-12 Mainboard with VIA chipset. It only 
> happens on THESE Machines.

Hmmm - that points more to a hardware problem than a software problem;
crashes in generic_file_buffered_write() are relatively uncommon, and
to have them all isolated to a specific type of hardware is suspicious....

Wasn't there a major update of the IDE layer in 2.6.18? or was that
2.6.19 that I'm thinking of? BTW, have you run memtest86 on these
boxes to rule out dodgy memory?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
