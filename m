Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUKIOBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUKIOBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKIOBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:01:30 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:16907 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261419AbUKIOB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:01:28 -0500
Date: Tue, 9 Nov 2004 14:01:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] VM routine fixes
Message-ID: <20041109140122.GA5388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041109125539.GA4867@infradead.org> <200411081432.iA8EWfmh023432@warthog.cambridge.redhat.com> <15068.1100008386@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15068.1100008386@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:53:06PM +0000, David Howells wrote:
> 
> > Please don't stick CONFIG_MMU all over the place but keep them in as small
> > as possible blocks.
> 
> You seem to have changed your mind. Last I heard from you wanted them in as
> few large blocks as possible. Now you want them in many small blocks. If you
> want it changing, please feel free to supply me with a patch.

sorry, typo.  Should have read as large as possible - small doesn't make
sense with the first half of the sentence anyway.

> > As I told you before please move registration of MMU-only sysctls
> > to a MMU-only file in mm/
> 
> No. These belong in the vm_table. It doesn't seem especially straightforward
> to do what you want. If you want it doing your way, then feel free to send
> Andrew a patch.

It is.  You can register multiple tables for the same hierachy.

> > this is nasty.  The right thing would probably to swich !MMU arches
> > to use the compount-page mechanism from the hugetlb code for this.
> 
> Supply me with a patch and I'll test it. I don't know how the compound-page
> stuff works, but it's quite possibly the wrong way to do it. There is no MMU
> available, so you can't generate adjacency that way.

so look at the code.  It's not about the MMU at all, it's about handling
the Linux page structures.   What you're doing is a big mess and should
not be merged.  So if you want to fix the issue do it properly.

