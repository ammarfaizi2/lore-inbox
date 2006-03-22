Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWCVKau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWCVKau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWCVKau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:30:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12526 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751207AbWCVKau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:30:50 -0500
Date: Wed, 22 Mar 2006 10:30:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@citi.umich.edu>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
Message-ID: <20060322103044.GB7025@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <cel@citi.umich.edu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
References: <1142961077.7987.14.camel@lade.trondhjem.org> <20060321174634.GA15827@infradead.org> <1142964532.7987.61.camel@lade.trondhjem.org> <20060321185734.GB19125@infradead.org> <1142967981.7987.92.camel@lade.trondhjem.org> <44205003.8070702@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44205003.8070702@citi.umich.edu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 02:12:03PM -0500, Chuck Lever wrote:
> i have been watching the multi-segment iovec work since then, and fully 
> intended to add the support for readv/writev aio in the NFS direct path 
> when the generic support becomes available.


we agreed to not add another set of methods but rather consolidate the
existing two sets of aio and vectored methods into one.  So to merge the
core support all users including nfs need to be updated.  the last wip
patchset is posted in the at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=114177713027505&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114177739515518&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114177739313588&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=114177739407636&w=2

any nfs work should happen ontop of that.

I'm sill the opinion removing the iovec arguments isn't helpfull, but
it's your code and if you think it helps you move forwarg go ahead with
this.

