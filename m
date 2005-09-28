Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVI1UBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVI1UBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVI1UBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:01:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:33680 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750795AbVI1UBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:01:48 -0400
Date: Wed, 28 Sep 2005 13:01:23 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Seth, Rohit" <rohit.seth@intel.com>
cc: akpm@osdl.org, linux-mm@kvack.org, Mattia Dongili <malattia@linux.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Reset the high water marks in CPUs pcp list
In-Reply-To: <20050928105009.B29282@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.62.0509281259550.14892@schroedinger.engr.sgi.com>
References: <20050928105009.B29282@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Seth, Rohit wrote:

> Recent changes in page allocations for pcps has increased the high watermark for these lists.  This has resulted in scenarios where pcp lists could be having bigger number of free pages even under low memory conditions. 
> 
>  	[PATCH]: Reduce the high mark in cpu's pcp lists.

There is no need for such a patch. The pcp lists are regularly flushed.
See drain_remote_pages.
