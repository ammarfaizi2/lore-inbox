Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWEIJes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWEIJes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWEIJes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:34:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8577 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751483AbWEIJer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:34:47 -0400
Date: Tue, 9 May 2006 10:34:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, davem@davemloft.net, suparna@in.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 2/6] Kprobes: Get one pagetable entry
Message-ID: <20060509093441.GA26953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prasanna S Panchamukhi <prasanna@in.ibm.com>,
	linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
	akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
	suparna@in.ibm.com, richardj_moore@uk.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509070106.GB22493@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 12:31:06PM +0530, Prasanna S Panchamukhi wrote:
> This patch provide a wrapper routine to allocate one page
> table entry for a given virtual address address. Kprobe's
> user-space probe mechanism uses this routine to get one
> page table entry. As Nick Piggin suggested, this generic
> routine can be used by routines like get_user_pages,
> find_*_page, and other standard APIs.

In find_*_page it defintily cannot be used because theses routines
are doing pagecache lookups and couldn't care less about users.

If you want to get this patch in convert the places currently opencoding
to it, otherwise it just adds more bloat.

