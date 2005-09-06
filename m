Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVIFGnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVIFGnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVIFGnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:43:43 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:30400 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932421AbVIFGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:43:42 -0400
Date: Mon, 5 Sep 2005 23:45:27 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow for arch-specific IOREMAP_MAX_ORDER
Message-ID: <20050906064527.GA18916@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20050824221202.GA28977@plexity.net> <20050828183902.D14294@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050828183902.D14294@flint.arm.linux.org.uk>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 28 2005, at 18:39, Russell King was caught saying:
> On Wed, Aug 24, 2005 at 03:12:02PM -0700, Deepak Saxena wrote:
> > Version 6 of the ARM architecture introduces the concept of 16MB pages
> > (supersections) and 36-bit (40-bit actually, but nobody uses this)
> > physical addresses. 36-bit addressed memory and I/O and ARMv6 can
> > only be mapped using supersections and the requirement on these is
> > that both virtual and physical addresses be 16MB aligned.
> 
> Have we sorted out how we handle the issue of IO vs memory outside the
> normal 4GB?  We can only map one or other depending on how the domains
> are setup and get the correct permission behaviour.

That's an arch-specific issue that we'll have to handle in the ARM code
and really shouldn't impact this patch itself. FYI, all the 36-bit CPUs
I know of (from Intel) only have I/O above 4G.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
