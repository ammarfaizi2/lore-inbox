Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVABUZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVABUZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVABUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:25:44 -0500
Received: from holomorphy.com ([207.189.100.168]:36245 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261318AbVABUZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:25:39 -0500
Date: Sun, 2 Jan 2005 12:25:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, riel@redhat.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       kernel@kolivas.org
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102202529.GK29332@holomorphy.com>
References: <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20050102151147.GA1930@suse.de> <20050102120324.2b52a848.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102120324.2b52a848.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> Lifting the artificial lowmem restrictions on blockdev mappings
>>> (thereby nuking mapping->gfp_mask altogether) would resolve a number of
>>> problems, not that anything making that much sense could ever happen.

Jens Axboe <axboe@suse.de> wrote:
>>  It should be lifted for block devices, it doesn't make any sense.

On Sun, Jan 02, 2005 at 12:03:24PM -0800, Andrew Morton wrote:
> Before we can permit blockdev pagecache to use highmem we must convert
> every piece of code which accesses the cache to use kmap/kmap_atomic.  If
> you grep around for b_data you'll see there are a lot of such places.
> Probably the migration could be done on a per-fs basis.

I'd regard such an incremental conversion strategy as a prerequisite, and
would have no trouble working within such constraints.


-- wli
