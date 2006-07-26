Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWGZPmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWGZPmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWGZPmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:42:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:23503 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751669AbWGZPmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:42:18 -0400
Subject: Re: [NFS] [PATCH] [nfsd] Add lock annotations to e_start and e_stop
From: Josh Triplett <josht@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>
In-Reply-To: <1153901976.3381.1.camel@laptopd505.fenrus.org>
References: <1153840824.12517.9.camel@josh-work.beaverton.ibm.com>
	 <20060726080656.GA28346@infradead.org>
	 <1153901976.3381.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 08:42:17 -0700
Message-Id: <1153928537.12517.44.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 10:19 +0200, Arjan van de Ven wrote:
> On Wed, 2006-07-26 at 09:06 +0100, Christoph Hellwig wrote:
> > On Tue, Jul 25, 2006 at 08:20:24AM -0700, Josh Triplett wrote:
> > > e_start acquires svc_export_cache.hash_lock, and e_stop releases it.  Add lock
> > > annotations to these two functions so that sparse can check callers for lock
> > > pairing, and so that sparse will not complain about these functions since they
> > > intentionally use locks in this manner.
> > > 
> > > Signed-off-by: Josh Triplett <josh@freedesktop.org>
> > 
> > The Signed-off-by: line doesn't match the from line of this mail.  Is that
> > any problem or fine in general?
> 
> As far as I can see it's customary for the SOB line to state the
> affiliation of the person, eg the company that wants to own the
> copyright on the code. So I'd expect Josh to use his ibm.com account...

When my internship with IBM ends, the address in the From line stops
working.  I've already run into a number of bounces when sending in
these patches; I don't want to contribute to that problem.  The address
I gave in the Signed-off-by line should always work, as I can change
where it forwards.

- Josh Triplett


