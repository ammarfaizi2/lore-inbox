Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVA1O0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVA1O0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVA1O0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:26:47 -0500
Received: from holomorphy.com ([66.93.40.71]:5352 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261407AbVA1O0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:26:38 -0500
Date: Fri, 28 Jan 2005 06:26:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
Message-ID: <20050128142620.GQ10843@holomorphy.com>
References: <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com> <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com> <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com> <20050127211319.GN10843@holomorphy.com> <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com> <20050128053036.GO10843@holomorphy.com> <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 02:14:36PM +0000, Hugh Dickins wrote:
> I had imagined that top down (non-FIXED) would continue to make
> more space available, the space below the text, just cutting off
> at PAGE_SIZE.  There was a more serious lower limit on ARM under
> discussion before, but ARM doesn't use top down so far as I can see.

rmk chimed in at one point and made it clear that ARM's actual lower
bounday was PAGE_SIZE (before that, all I knew was:
0 < x <= (FIRST_USER_PGD_NR << PGDIR_SHIFT)).


-- wli
