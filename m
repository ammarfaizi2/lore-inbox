Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVKWSKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVKWSKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVKWSKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:10:51 -0500
Received: from fmr24.intel.com ([143.183.121.16]:37011 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932128AbVKWSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:10:50 -0500
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
	conditions
From: Rohit Seth <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       christoph@lameter.com
In-Reply-To: <20051122215838.2abfdbd4.akpm@osdl.org>
References: <20051122161000.A22430@unix-os.sc.intel.com>
	 <20051122213612.4adef5d0.akpm@osdl.org>
	 <20051122215838.2abfdbd4.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 23 Nov 2005 10:17:00 -0800
Message-Id: <1132769820.25086.23.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Nov 2005 18:10:02.0324 (UTC) FILETIME=[1F9FA940:01C5F059]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 21:58 -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > The `while' loop worries me for some reason, so I wimped out and just tried
> >  the remote drain once.
> 
> Even the `goto restart' which is in this patch worries me from a livelock
> POV.  Perhaps we should only ever run drain_all_local_pages() once per
> __alloc_pages() invokation.
> And perhaps we should run drain_all_local_pages() for GFP_ATOMIC or
> PF_MEMALLOC attempts too.

Good point for PF_MEMALLOC scenario.

-rohit

