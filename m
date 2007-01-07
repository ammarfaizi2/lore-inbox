Return-Path: <linux-kernel-owner+w=401wt.eu-S965283AbXAHBKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbXAHBKM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbXAHBKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:10:12 -0500
Received: from ozlabs.org ([203.10.76.45]:56885 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965283AbXAHBKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:10:11 -0500
Subject: Re: [patch] paravirt: isolate module ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, airlied@linux.ie
In-Reply-To: <20070106193152.GA26153@infradead.org>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
	 <1168064710.20372.28.camel@localhost.localdomain>
	 <20070106071424.GB11232@elte.hu>
	 <1168100325.20372.37.camel@localhost.localdomain>
	 <20070106193152.GA26153@infradead.org>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 16:35:59 +1100
Message-Id: <1168148159.20372.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2007-01-06 at 19:31 +0000, Christoph Hellwig wrote:
> On Sun, Jan 07, 2007 at 03:18:45AM +1100, Rusty Russell wrote:
> > PS.  drm_memory.h has a "drm_follow_page": this forces us to uninline
> > various page tables ops.  Can this use follow_page() somehow, or do we
> > need an "__follow_page" export for this case?
> 
> Not if avoidable.  And it seems avoidable as drm really should be using
> vmalloc_to_page.  Untested patch below:

Thanks Christoph, that patch looks great to me!  I didn't know about
vmalloc_to_page...

Want to produce a signed-off version?

Thanks,
Rusty.


