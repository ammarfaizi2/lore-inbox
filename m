Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTFYAeC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTFYAeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:34:02 -0400
Received: from holomorphy.com ([66.224.33.161]:5339 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263449AbTFYAd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:33:56 -0400
Date: Tue, 24 Jun 2003 17:47:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030625004758.GO26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306250111.01498.phillips@arcor.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 01:11:01AM +0200, Daniel Phillips wrote:
>   - Page size is represented on a per-address space basis with a shift count.
>     In practice, the smallest is 9 (512 byte sector), could imagine 7 (each
>     ext2 inode is separate page) or 8 (actual hardsect size on some drives).
>     12 will be the most common size.  13 gives 8K blocksize for, e.g., alpha.
>     21 and 22 give 2M and 4M page size, matching hardware capabilities of
>     x86, and other sizes are possible on machines like MIPS, where page size
>     is software controllable
>   - Implemented only for file-backed memory (page cache)

Per struct address_space? This is an unnecessary limitation.


On Wed, Jun 25, 2003 at 01:11:01AM +0200, Daniel Phillips wrote:
>   - Special case these ops in page cache access layer instead of having the
>     messy code in the block IO library
>   - Subpage struct pages are dynamically allocated.  But buffer_heads are gone
>     so this is a lateral change.

This gives me the same data structure proliferation chills as bh's.


-- wli
