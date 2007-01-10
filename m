Return-Path: <linux-kernel-owner+w=401wt.eu-S965121AbXAJV1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbXAJV1r (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbXAJV1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:27:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45408 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbXAJV1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:27:46 -0500
Date: Wed, 10 Jan 2007 22:27:45 +0100
From: Jan Kara <jack@suse.cz>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: Andrew Morton <akpm@osdl.org>, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070110212744.GD12654@atrey.karlin.mff.cuni.cz>
References: <20070110161215.GB12654@atrey.karlin.mff.cuni.cz> <200701102015.l0AKFOQu028764@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701102015.l0AKFOQu028764@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <20070110161215.GB12654@atrey.karlin.mff.cuni.cz>, Jan Kara writes:
> > > In message <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>, Jan Kara writes:
> [...]
> > > Jan, all of it is duable: we can downgrade the f/s to readonly, grab various
> > > locks, search through various lists looking for open fd's and such, then
> > > decide if to allow the mount or not.  And hopefully all of that can be done
> > > in a non-racy manner.  But it feels just rather hacky and ugly to me.  If
> > > this community will endorse such a solution, we'll be happy to develop it.
> > > But right now my impression is that if we posted such patches today, some
> > > people will have to wipe the vomit off of their monitors... :-)
> >   I see :). To me it just sounds as if you want to do remount-read-only
> > for source filesystems, which is operation we support perfectly fine,
> > and after that create union mount. But I agree you cannot do quite that
> > since you need to have write access later from your union mount. So
> > maybe it's not so easy as I thought.
> >   On the other hand, there was some effort to support read-only bind-mounts of
> > read-write filesystems (there were even some patches floating around but
> > I don't think they got merged) and that should be even closer to what
> > you'd need...
> 
> I didn't know about those patches, but yes, they do sound useful.  I'm
> curious who needed such functionality before and why.  If someone can point
> me to those patches, we can look into using them for Unionfs.  Thanks.
  Dave Hansen writes them. One of recent submissions starts for example at
http://openvz.org/pipermail/devel/2006-December/002543.html.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
