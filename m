Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUHRW70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUHRW70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267600AbUHRW70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 18:59:26 -0400
Received: from holomorphy.com ([207.189.100.168]:40634 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267381AbUHRW7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 18:59:25 -0400
Date: Wed, 18 Aug 2004 15:59:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818225915.GQ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com> <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com> <20040818143029.23db8740.davem@redhat.com> <20040818214026.GL11200@holomorphy.com> <20040818220001.GN11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818220001.GN11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 03:00:01PM -0700, William Lee Irwin III wrote:
> Or, if not pgoff_t, introduce a pfn_t for this purpose, an unsigned
> arithmetic type of architecture-dependent width (such systems may not
> want 64-bit page indices and the like for various reasons). But
> exhibiting a system with the need for such is yet to be done, and in
> fact, even with a 32B struct page, 16TB RAM (the minimum required to
> trigger more physical address bits >= BITS_PER_LONG + PAGE_SHIFT) has
> a 128GB mem_map[] with 4KB pages, an 8GB mem_map[] with 64KB pages,
> and so will have far, far deeper support issues than pfn overflows.
> Even supposing a kernel could be made to boot and the like, the massive
> internal fragmentation from using a large enough emulated PAGE_SIZE to
> get mem_map[] to fit within virtualspace will surely render such a
> machine completely useless, likely to the point of being unable to run
> userspace, or panicking much earlier from boot-time allocation failures.

Given this, will a pfn suffice?


-- wli
