Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUHGINT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUHGINT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUHGINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 04:13:19 -0400
Received: from holomorphy.com ([207.189.100.168]:211 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266296AbUHGINQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 04:13:16 -0400
Date: Sat, 7 Aug 2004 01:13:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Hirokazu Takahashi'" <taka@valinux.co.jp>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040807081311.GY17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hirokazu Takahashi' <taka@valinux.co.jp>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	"Seth, Rohit" <rohit.seth@intel.com>
References: <20040806.013522.74731251.taka@valinux.co.jp> <200408062055.i76KtcY08296@unix-os.sc.intel.com> <20040806210750.GT17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806210750.GT17188@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 02:07:50PM -0700, William Lee Irwin III wrote:
> update_mmu_cache() does not appear to check the size of the translation
> to be established in many architectures. e.g. on arch/ia64/ it does
> flush_icache_range(addr, addr + PAGE_SIZE) unconditionally, and only
> sets PG_arch_1 on a single struct page. Similar comments apply to
> sparc64 and ppc64; I didn't check any others.

In general not much seems to be getting done about cache coherency in
hugetlb at all. This may be problematic even in mainline.


-- wli
