Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbUBSQER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 11:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSQER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 11:04:17 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:40305 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267323AbUBSQEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 11:04:16 -0500
Date: Thu, 19 Feb 2004 00:58:19 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       arjanv@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040219085819.GB1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com> <20040218211035.A13866@infradead.org> <20040218150607.GE1269@us.ibm.com> <20040218222138.A14585@infradead.org> <20040218145132.460214b5.akpm@osdl.org> <20040219091132.GE17140@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219091132.GE17140@khan.acc.umu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 10:11:32AM +0100, David Weinehall wrote:
> On Wed, Feb 18, 2004 at 02:51:32PM -0800, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > I don't understand why IBM is pushing this dubious change right now,
> > 
> > It isn't a dubious change, on technical grounds.  It is reasonable for a
> > distributed filesystem to want to be able to shoot down pte's which map
> > sections of pagecache.  Just as it is reasonable for the filesystem to be
> > able to shoot down the pagecache itself.
> > 
> > We've exported much lower-level stuff than this, because some in-kernel
> > module happened to use it.
> 
> Probably not always the right choice, though...  I highly suspect we
> far to much of our intestines are easily available.

Again, the whole point of the patch is to -reduce- the degree of
intestinal export.

						Thanx, Paul
