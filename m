Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVKJVxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVKJVxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVKJVxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:53:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23742 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932177AbVKJVxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:53:05 -0500
Date: Thu, 10 Nov 2005 21:52:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051110215255.GA25712@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@engr.sgi.com>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	hugh@veritas.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu> <20051110042613.7a585dec.akpm@osdl.org> <Pine.LNX.4.62.0511101335140.16283@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511101335140.16283@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 01:37:19PM -0800, Christoph Lameter wrote:
> On Thu, 10 Nov 2005, Andrew Morton wrote:
> 
> > spinlock in struct page, and the size of the spinlock varies a lot according
> > to config.  The only >wordsize version we really care about is
> > CONFIG_PREEMPT, NR_CPUS >= 4.  (which distros don't ship...)
> 
> Suse, Debian and Redhat ship such kernels.

No.  SuSE and Redhat have always been smart enough to avoid CONFIG_PREEMPT
like the plague, and even Debian finally noticed this a few month ago.

