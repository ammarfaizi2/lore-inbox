Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVI2BFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVI2BFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVI2BFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:05:48 -0400
Received: from fmr16.intel.com ([192.55.52.70]:38292 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751255AbVI2BFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:05:47 -0400
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org, steiner@sgi.com, nickpiggin@yahoo.com.au
In-Reply-To: <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
	 <1127939185.5046.17.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0509281408480.15213@schroedinger.engr.sgi.com>
	 <1127943168.5046.39.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 28 Sep 2005 18:12:56 -0700
Message-Id: <1127956376.5046.44.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 01:05:26.0075 (UTC) FILETIME=[E03440B0:01C5C491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 14:56 -0700, Christoph Lameter wrote:
> On Wed, 28 Sep 2005, Rohit Seth wrote:
> 
> > On Wed, 2005-09-28 at 14:09 -0700, Christoph Lameter wrote:
> > > On Wed, 28 Sep 2005, Rohit Seth wrote:
> > > 
> > > > CONFIG_NUMA needs to be defined for that.  And then too for flushing the
> > > > remote pages.  Also, when are you flushing the local pcps.  Also note
> > > > that this patch is just bringing the free pages on the pcp list closer
> > > > to what used to be the number earlier.
> > > 
> > > What was the reason for the increase of those numbers?
> > Bugger batch size to possibly get more physical contiguous pages.  That
> > indirectly increased the high water marks for the pcps.
> 
> I know that Jack and Nick did something with those counts to insure that 
> page coloring effects are avoided. Would you comment?
> 

About 10% performance variation was seen from run to run with original
setting with certain workloads on x86 and IA-64 platforms.  And this
variation came down to about 2% with new settings.

-rohit

