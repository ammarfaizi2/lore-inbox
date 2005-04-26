Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVDZGNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVDZGNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDZGNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:13:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36524 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261350AbVDZGMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:12:48 -0400
Date: Tue, 26 Apr 2005 07:12:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, timur.tabi@ammasso.com, hch@infradead.org,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050426061236.GA27220@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
	timur.tabi@ammasso.com, hozer@hozed.org,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <4263DEC5.5080909@ammasso.com> <20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com> <20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com> <52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org> <521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org> <52r7gytnfn.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52r7gytnfn.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 05:02:36PM -0700, Roland Dreier wrote:
> The idea is that applications manage the lifetime of pinned memory
> regions.  They can do things like post multiple I/O operations without
> any page-walking overhead, or pass a buffer descriptor to a remote
> host who will send data at some indeterminate time in the future.  In
> addition, InfiniBand has the notion of atomic operations, so a cluster
> application may be using some memory region to implement a global lock.
> 
> This might not be the most kernel-friendly design but it is pretty
> deeply ingrained in the design of RDMA transports like InfiniBand and
> iWARP (RDMA over IP).

Actuallky, no it isn't.   All these transports would work just fine with
the mmap a character device to hand out memory from the kernel approach
I told you to use multiple times and Andrew mentioned in this thread aswell.
What doesn't work with that design are the braindead designed by comittee
APIs in the RDMA world - but I don't think we should care about them too
much.

