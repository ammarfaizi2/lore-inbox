Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUKTVdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUKTVdv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbUKTVbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:31:52 -0500
Received: from holomorphy.com ([207.189.100.168]:20617 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263183AbUKTVaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:30:05 -0500
Date: Sat, 20 Nov 2004 13:29:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041120212954.GB2714@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org> <20041120183128.GW2714@holomorphy.com> <20041120211931.GA21321@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120211931.GA21321@infradead.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 10:31:28AM -0800, William Lee Irwin III wrote:
>> This patch converts FRV to use remap_pfn_range() in its
>> io_remap_page_range() function.

On Sat, Nov 20, 2004 at 09:19:31PM +0000, Christoph Hellwig wrote:
> What about introducing io_remap_pfn_range while you're at it so we can
> have a cross-plattform calling convention?

That's a pretty serious issue and the one that actually compelled work
to be done on remap_pfn_range(), though it was known to be an issue
for other reasons sufficiently compelling for mainline inclusion in
isolation. You might say that the "ulterior motive" on my part with
remap_pfn_range() was to ultimately leverage it to help resolve the
io_remap_page_range() issue though it directly benefits ia32 and ppc440.

A bit of research is needed to deal with the six-argument variants for
that effort that hasn't been wrapped up yet, and that's really the only
thing holding back the io_remap_pfn_range() sweep to unify the 5 and 6
argument conventions. I do have the hardware to test the 6 argument
architectures, which should make testing easy once I dredge up the info.


-- wli
