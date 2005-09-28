Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVI1V4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVI1V4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVI1Vzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:55:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37309 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751087AbVI1VzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:55:22 -0400
Date: Wed, 28 Sep 2005 14:55:14 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: "Seth, Rohit" <rohit.seth@intel.com>, akpm@osdl.org, linux-mm@kvack.org,
       Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
In-Reply-To: <15630000.1127942318@flay>
Message-ID: <Pine.LNX.4.62.0509281454210.15902@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com>
 <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
 <15630000.1127942318@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Sep 2005, Martin J. Bligh wrote:

> >> Recent changes in page allocations for pcps has increased the high watermark for these lists.  This has resulted in scenarios where pcp lists could be having bigger number of free pages even under low memory conditions. 
> >> 
> >>  	[PATCH]: Reduce the high mark in cpu's pcp lists.
> > 
> > There is no need for such a patch. The pcp lists are regularly flushed.
> > See drain_remote_pages.
> 
> That's only retrieving pages which have migrated off-node, is it not?

Its freeing all pages in off node pcps. There is no page migration 
in the current kernels.


