Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVI1V47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVI1V47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVI1V44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:56:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9385 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751015AbVI1V4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:56:42 -0400
Date: Wed, 28 Sep 2005 14:56:34 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Rohit Seth <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org, steiner@sgi.com, nickpiggin@yahoo.com.au
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
In-Reply-To: <1127943168.5046.39.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0509281455310.15902@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com> 
 <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com> 
 <1127939185.5046.17.camel@akash.sc.intel.com> 
 <Pine.LNX.4.62.0509281408480.15213@schroedinger.engr.sgi.com>
 <1127943168.5046.39.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Rohit Seth wrote:

> On Wed, 2005-09-28 at 14:09 -0700, Christoph Lameter wrote:
> > On Wed, 28 Sep 2005, Rohit Seth wrote:
> > 
> > > CONFIG_NUMA needs to be defined for that.  And then too for flushing the
> > > remote pages.  Also, when are you flushing the local pcps.  Also note
> > > that this patch is just bringing the free pages on the pcp list closer
> > > to what used to be the number earlier.
> > 
> > What was the reason for the increase of those numbers?
> Bugger batch size to possibly get more physical contiguous pages.  That
> indirectly increased the high water marks for the pcps.

I know that Jack and Nick did something with those counts to insure that 
page coloring effects are avoided. Would you comment?

