Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293338AbSCTVvH>; Wed, 20 Mar 2002 16:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312236AbSCTVut>; Wed, 20 Mar 2002 16:50:49 -0500
Received: from imladris.infradead.org ([194.205.184.45]:51725 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S312235AbSCTVug>;
	Wed, 20 Mar 2002 16:50:36 -0500
Date: Wed, 20 Mar 2002 21:46:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320214607.A6363@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Hugh Dickins <hugh@veritas.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Dave McCracken <dmccr@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random> <20020320203520.A2003@infradead.org> <20020320223425.P4268@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 10:34:25PM +0100, Andrea Arcangeli wrote:
> > The problem is not the 4GB ZONE_NORMAL but the ~1GB KVA space.
> 
> Then you misunderstood what's the zone-normal, the zone normal is 800M
> in size not 4GB.

No, it was braino when writing.

> The 1GB of KVA is what constraint the size of the zone
> normal to 800M. We're talking about the same thing, just looking at it
> from different point of views.

Okay agreed now after the 'reminder'.

> > UnixWare/OpenUnix had huge problems getting all kernel structs for managing
> > 16GB virtual into that - on the other hand their struct page is more
> > then twice as big as ours..
> 
> We do pretty well with pte-highmem, there is some other bit that will be
> better to optimize, but nothing major.

One major area to optimize are the kernel stacks I think.
