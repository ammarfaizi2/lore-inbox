Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUFWWi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUFWWi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFWWh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:37:59 -0400
Received: from holomorphy.com ([207.189.100.168]:54405 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263301AbUFWWgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:36:43 -0400
Date: Wed, 23 Jun 2004 15:35:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: More bug fix in mm/hugetlb.c - fix try_to_free_low()
Message-ID: <20040623223521.GI1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
References: <20040623194243.GB1552@holomorphy.com> <10650.1088029049@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10650.1088029049@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:17:29AM +1000, Keith Owens wrote:
> While we are discussing hugetlb, what is the official method of
> identifying a hugetlb page - at the page level, not through a vma?
> When taking a crash dump, hugetlb pages must be treated as user data,
> not as kernel pages.  LKCD must be able to identify hugetlb pages from
> the page struct, dumping cannot assume that any mm context is valid so
> vma scans are out.  The identification method must work whether the
> hugetlb pages are in use or not.  In 2.4 LKCD I added PG_hugetlb, but I
> would prefer a test that did not require yet another PG flag.

PG_compound should get you going. You might want to do some extra
checks for order and release function just to be sure.


-- wli
