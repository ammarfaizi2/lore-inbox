Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbVKWWWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbVKWWWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKWWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:22:23 -0500
Received: from fmr21.intel.com ([143.183.121.13]:27094 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932588AbVKWWWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:22:19 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0511231325150.23433@schroedinger.engr.sgi.com>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <Pine.LNX.4.62.0511231128090.22710@schroedinger.engr.sgi.com>
	 <1132775194.25086.54.camel@akash.sc.intel.com>
	 <20051123115545.69087adf.akpm@osdl.org>
	 <1132779605.25086.69.camel@akash.sc.intel.com>
	 <Pine.LNX.4.62.0511231325150.23433@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 14:29:03 -0800
Message-Id: <1132784943.25086.87.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 22:22:05.0150 (UTC) FILETIME=[5587C7E0:01C5F07C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 13:25 -0800, Christoph Lameter wrote:
> On Wed, 23 Nov 2005, Rohit Seth wrote:
> 
> > I thought Nick et.al came up with some of the constant values like batch
> > size to tackle the page coloring issue specifically.  In any case, I
> > think one of the key difference between 2.4 and 2.6 allocators is the
> > pcp list.  And even with the minuscule batch and high watermarks this is
> > helping ordinary benchmarks (by reducing the variation from run to run).
> 
> Could you share some benchmark results?
> 

Some components of cpu2k on 2.4 base kernels show in access of 40-50%
variation from run to run.  The same variations came down to about 10%
for 2.6 based kernels.   

-rohit

