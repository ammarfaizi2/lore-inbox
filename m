Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWFJKDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWFJKDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWFJKDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:03:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29850 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750787AbWFJKDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:03:38 -0400
Date: Sat, 10 Jun 2006 11:03:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610100317.GC20526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerrit Huizenga <gh@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <4489C34B.1080806@garzik.org> <E1FompD-0006pL-Dg@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FompD-0006pL-Dg@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 12:39:19PM -0700, Gerrit Huizenga wrote:
> > PRECISELY.  So you should stop modifying a filesystem whose design is 
> > admittedly _not_ modern!
> 
> So just how long do you think it would take to get a modern filesystem
> into the hands of real users, supported by the distros?  From community
> building, through design, development, testing, delivery?

JFS is pretty nice because it has many adavanced features but still is
rather simple.  XFS has even more cool features such as a WIP parallel
fsck and is proven on the biggest filesystems on COS operating systems
out there, but as a disadvantage is hugely complex so outsiders have a
hard time getting into it.

So shortem the option I'd recommend is to start supporting XFS more broadly,
because it's the high end filesystem that's out there today and fill the
needs people have in the next five or so years.

For the time after that we need to think about something that can scale
aswell and better while beeing simpler.  Also we need to start thinking
about a clustered filesystem more, it might or might not make sense to
have a cluster filesystem also do the next generation local filesystem
thing.  I'd probably start designing such a next gen fs by taking jfs
and revamping it completely.

