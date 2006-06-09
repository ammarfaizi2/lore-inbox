Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWFIUfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWFIUfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFIUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:35:50 -0400
Received: from thunk.org ([69.25.196.29]:41929 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932358AbWFIUft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:35:49 -0400
Date: Fri, 9 Jun 2006 16:35:23 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Michael Poole <mdpoole@troilus.org>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609203523.GE10524@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Gerrit Huizenga <gh@us.ibm.com>,
	Michael Poole <mdpoole@troilus.org>, Andrew Morton <akpm@osdl.org>,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489D36C.3010000@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 04:00:44PM -0400, Jeff Garzik wrote:
> But for ext3 specifically, it seems like bolting on extents, 48bit, 
> delayed allocation, and other new features weren't really suited for the 
> original ext2-style design.  Outside of the support (and marketing, 
> because that's all version numbers are in the end) issues already 
> mentioned, I think it falls into the nebulous realm of "taste."

If is very much a matter of taste, why are you trying to dictate to
the ext2 developers how they choose to do things?  As long as it
works, and we haven't screwed up yet, I'd argue this is falls into the
category of letting each subsystem decide how they best work.  The way
DaveM and the networking team works is quite different from how the
SCSI developers work or the XFS team work --- it's not a
one-size-fits-all sort of thing.

And I'd also dispute with your "weren't really suited for the original
ext2-style design" comment.  Ext2/3 was always designed to be
extensible from the start, and we've successfully added features quite
successfully for quite a while.

> Rather than taking another decade to slowly fix ext2 design decisions, 
> why not move the process along a bit more rapidly?  Release early, 
> release often...

I don't think it will be another decade, but yes, regardless of
whether we do a code fork or not, it will take time.  Basically, you
and the ext2 developers have a disagreement about whether or not a
code fork will actually move the process along more quickly or not.
Either way, we will be releasing early and often, so people can test
it out and comment on it.  Releasing patches to LKML is just the first
step in this process.

						- Ted
