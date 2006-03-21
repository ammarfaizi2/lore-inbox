Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWCUS6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWCUS6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWCUS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:58:15 -0500
Received: from pat.uio.no ([129.240.130.16]:53903 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932450AbWCUS6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:58:14 -0500
Subject: Re: [NFS] [GIT] NFS client update for 2.6.16
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
In-Reply-To: <20060321174634.GA15827@infradead.org>
References: <1142961077.7987.14.camel@lade.trondhjem.org>
	 <20060321174634.GA15827@infradead.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:58:01 -0500
Message-Id: <1142967482.7987.83.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.643, required 12,
	autolearn=disabled, AWL 1.36, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 17:46 +0000, Christoph Hellwig wrote:
> > commit 47989d7454398827500d0e73766270986a3b488f
> > Author: Chuck Lever <cel@netapp.com>
> > Date:   Mon Mar 20 13:44:32 2006 -0500
> > 
> >     NFS: remove support for multi-segment iovs in the direct write path
> >     
> >     Eliminate the persistent use of automatic storage in all parts of the
> >     NFS client's direct write path to pave the way for introducing support
> >     for aio against files opened with the O_DIRECT flag.
> 
> NACK.  We have patches pending that consolidate ->aio_read/write and
> ->read/writev into one operation.  this change is completely counterproductive
> towards that goal which has been discussed on -fsdevel for a while.

Could you, BTW, please post these pending patches? They are clearly not
in -mm, since these patches have been there for some time without
conflicting with anything else. The only references I could find were to
the following thread:

   http://thread.gmane.org/gmane.linux.file-systems/7748

which basically just adds a BUG() if you call NFS O_DIRECT with a
multi-segment iovec.

I can't see from those patches how Chuck's O_DIRECT changes can be
construed as being "counterproductive". AFAICS those changes are
completely orthogonal to your proposal.

Cheers,
  Trond

