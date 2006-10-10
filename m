Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWJJPIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWJJPIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWJJPIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:08:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932150AbWJJPH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:07:59 -0400
Subject: Re: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault
	handlers
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061010143342.GA5580@infradead.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	 <20061010143342.GA5580@infradead.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 17:07:56 +0200
Message-Id: <1160492876.3000.301.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 15:33 +0100, Christoph Hellwig wrote:
> On Tue, Oct 10, 2006 at 04:21:32PM +0200, Nick Piggin wrote:
> > This patchset is against 2.6.19-rc1-mm1 up to
> > numa-add-zone_to_nid-function-swap_prefetch.patch (ie. no readahead stuff,
> > which causes big rejects and would be much easier to fix in readahead
> > patches than here). Other than this feature, the -mm specific stuff is
> > pretty simple (mainly straightforward filesystem conversions).
> > 
> > Changes since last round:
> > - trimmed the cc list, no big changes since last time.
> > - fix the few buglets preventing it from actually booting
> > - reinstate filemap_nopage and filemap_populate, because they're exported
> >   symbols even though no longer used in the tree. Schedule for removal.
> 
> Just kill them and the whole ->populate methods.  We have a better API that
> replaces them 100% with your patch, and they've never been a widespread
> API.

concur; just nuke the parts that have become unused right away. They're
not "removed" as such, but "replaced by better"


