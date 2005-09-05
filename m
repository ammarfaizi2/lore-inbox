Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVIES00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVIES00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVIES00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:26:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2399
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932375AbVIES0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:26:25 -0400
Date: Mon, 5 Sep 2005 20:26:21 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: tony.luck@intel.com
Cc: Bill Davidsen <davidsen@tmr.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org, klive@cpushare.com
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050905182621.GF5606@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl> <4314D98E.2030801@tmr.com> <200508311914.j7VJEN7M009450@agluck-lia64.sc.intel.com> <20050831194701.GP1614@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831194701.GP1614@g5.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 09:47:01PM +0200, Andrea Arcangeli wrote:
> I'm thinking to add optional aggregations for (\d+)\.(\d+)\.(\d+)\D and
> for different archs. So you can watch ia64 only or 2.6.13 only etc...
> 
> The "-tiger-smp/-generic-up" makes life harder indeed ;).

I now implemented some basic aggregation per-arch and per-branch but I'm
not yet merging in the same row kernels with only a different
localversion (example: 2.6.13-ppc64 isn't merged with 2.6.13). The
problem is that the localversions may be random and so it complicates
things as said above (it'd be really nice to have a way to identify the
localversion reliably). Suggestions are welcome. Thanks.
