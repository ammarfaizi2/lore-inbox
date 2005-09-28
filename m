Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVI1UTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVI1UTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVI1UTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:19:13 -0400
Received: from fmr14.intel.com ([192.55.52.68]:38338 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750766AbVI1UTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:19:13 -0400
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 28 Sep 2005 13:26:25 -0700
Message-Id: <1127939185.5046.17.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 20:18:54.0584 (UTC) FILETIME=[D946E780:01C5C469]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 13:01 -0700, Christoph Lameter wrote:
> On Wed, 28 Sep 2005, Seth, Rohit wrote:
> 
> > Recent changes in page allocations for pcps has increased the high watermark for these lists.  This has resulted in scenarios where pcp lists could be having bigger number of free pages even under low memory conditions. 
> > 
> >  	[PATCH]: Reduce the high mark in cpu's pcp lists.
> 
> There is no need for such a patch. The pcp lists are regularly flushed.
> See drain_remote_pages.

CONFIG_NUMA needs to be defined for that.  And then too for flushing the
remote pages.  Also, when are you flushing the local pcps.  Also note
that this patch is just bringing the free pages on the pcp list closer
to what used to be the number earlier.

-rohit

