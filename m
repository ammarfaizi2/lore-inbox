Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWFSQRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWFSQRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWFSQRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:17:22 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:21140 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964782AbWFSQRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:17:21 -0400
Date: Mon, 19 Jun 2006 09:16:51 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Theodore Tso <tytso@thunk.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619161651.GS29684@ca-server1.us.oracle.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619155821.GA27867@infradead.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:58:21PM +0100, Christoph Hellwig wrote:
> Blease don't add a field to the superblock for the optimal I/O size.
> Any filesystem that wants to override it can do so directly in ->getattr.

	I don't disagree with you, but the idea of everyone implementing
->getattr where they just let it work before scares me.  It's a ton of
cut-n-paste error waiting to happen.  Especially if we make something
stale.
	Perhaps add generic_fillattr_blksize()?

myfs_fillattr(inode, stat)
{
    generic_fillattr_size(inode, myfavoriteblksize, stat)
}

Joel

-- 

Life's Little Instruction Book #407

	"Every once in a while, take the scenic route."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
