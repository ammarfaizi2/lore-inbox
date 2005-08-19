Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVHSVUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVHSVUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVHSVUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:20:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965156AbVHSVT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:19:59 -0400
Date: Fri, 19 Aug 2005 22:19:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819211951.GA9804@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
	Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
	fsdevel <linux-fsdevel@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk> <20050819180037.GA5686@infradead.org> <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk> <20050819194129.GB2756@parcelfarce.linux.theplanet.co.uk> <20050819194306.GH29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819194306.GH29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 08:43:06PM +0100, Al Viro wrote:
> On Fri, Aug 19, 2005 at 08:41:29PM +0100, Matthew Wilcox wrote:
> > > is getting crowded.  Linus, do you have any objections to that or suggestions
> > > on filename here?
> > 
> > fs/symlink.c?
> 
> Or fs/lib/symlink.c...

That's a very good idea.  We were in need of fs/lib/ for a long time
to unwind all the generic routines of the VFS logic.
