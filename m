Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269194AbUISJF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbUISJF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 05:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUISJF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 05:05:28 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:39950 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269191AbUISJFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 05:05:22 -0400
Date: Sun, 19 Sep 2004 10:04:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [2/7] avoid page_table_lock in handle_mm_fault
Message-ID: <20040919100453.A2596@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
	"David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
	wli@holomorphy.com, davem@redhat.com, raybry@sgi.com, ak@muc.de,
	manfred@colorfullife.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, vrajesh@umich.edu, hugh@veritas.com
References: <Pine.LNX.4.58.0409010938200.9907@schroedinger.engr.sgi.com> <1094080164.4025.17.camel@gaston> <Pine.LNX.4.58.0409012140440.23186@schroedinger.engr.sgi.com> <20040901215741.3538bbf4.davem@davemloft.net> <Pine.LNX.4.58.0409020920570.26893@schroedinger.engr.sgi.com> <20040902131057.0341e337.davem@davemloft.net> <Pine.LNX.4.58.0409021358540.28182@schroedinger.engr.sgi.com> <20040902140759.5f1003d5.davem@davemloft.net> <B6E8046E1E28D34EB815A11AC8CA312902CD3243@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409181625010.24054@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409181625010.24054@schroedinger.engr.sgi.com>; from clameter@sgi.com on Sat, Sep 18, 2004 at 04:26:36PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!ptep_cmpxchg(vma, addr, page_table, orig_entry, entry))
> +	{

wrong brace placement.

> +			if (!pmd_test_and_populate(mm, pmd, new))
> +				pte_free(new);
> +                        else

indentation using spaces instead of tabs

> +			pteval = ptep_xchg_flush(vma, address, pte, pgoff_to_pte(page->index));

please make sure lines are never longer than 80 characters
