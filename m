Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWBWQmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWBWQmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWBWQmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:42:25 -0500
Received: from kanga.kvack.org ([66.96.29.28]:37357 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751460AbWBWQmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:42:24 -0500
Date: Thu, 23 Feb 2006 11:37:24 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Arjan van de Ven <arjan@intel.linux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [Patch 2/3] fast VMA recycling
Message-ID: <20060223163724.GB27682@kvack.org>
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140687029.4672.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140687029.4672.8.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 10:30:29AM +0100, Arjan van de Ven wrote:
> One could argue that this should be a generic slab feature (the preloading) but
> that only gives some of the gains and not all, and vma's are small creatures,
> with a high "recycling" rate in typical cases.

I think this is wrong, and far too narrow in useful scope to be merged.  
It's unnecessary bloat of task_struct and if this is really a problem, then 
there is a [performance] bug in the slab allocator.  Please at least provide 
the slab statistics for what is going on, as the workload might well be 
thrashing the creation and destruction of slabs, which would be a much better 
thing to fix.

		-ben
