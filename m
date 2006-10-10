Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWJJOdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWJJOdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWJJOdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:33:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59073 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932090AbWJJOdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:33:49 -0400
Date: Tue, 10 Oct 2006 15:33:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault handlers
Message-ID: <20061010143342.GA5580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <npiggin@suse.de>,
	Linux Memory Management <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121314.19693.75503.sendpatchset@linux.site>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 04:21:32PM +0200, Nick Piggin wrote:
> This patchset is against 2.6.19-rc1-mm1 up to
> numa-add-zone_to_nid-function-swap_prefetch.patch (ie. no readahead stuff,
> which causes big rejects and would be much easier to fix in readahead
> patches than here). Other than this feature, the -mm specific stuff is
> pretty simple (mainly straightforward filesystem conversions).
> 
> Changes since last round:
> - trimmed the cc list, no big changes since last time.
> - fix the few buglets preventing it from actually booting
> - reinstate filemap_nopage and filemap_populate, because they're exported
>   symbols even though no longer used in the tree. Schedule for removal.

Just kill them and the whole ->populate methods.  We have a better API that
replaces them 100% with your patch, and they've never been a widespread
API.

