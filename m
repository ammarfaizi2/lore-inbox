Return-Path: <linux-kernel-owner+w=401wt.eu-S965086AbXAJURL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbXAJURL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbXAJURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:17:10 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44819 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965084AbXAJURJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:17:09 -0500
Date: Wed, 10 Jan 2007 15:15:24 -0500
Message-Id: <200701102015.l0AKFOQu028764@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Jan Kara <jack@suse.cz>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-reply-to: Your message of "Wed, 10 Jan 2007 17:12:15 +0100."
             <20070110161215.GB12654@atrey.karlin.mff.cuni.cz> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20070110161215.GB12654@atrey.karlin.mff.cuni.cz>, Jan Kara writes:
> > In message <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>, Jan Kara writes:
[...]
> > Jan, all of it is duable: we can downgrade the f/s to readonly, grab various
> > locks, search through various lists looking for open fd's and such, then
> > decide if to allow the mount or not.  And hopefully all of that can be done
> > in a non-racy manner.  But it feels just rather hacky and ugly to me.  If
> > this community will endorse such a solution, we'll be happy to develop it.
> > But right now my impression is that if we posted such patches today, some
> > people will have to wipe the vomit off of their monitors... :-)
>   I see :). To me it just sounds as if you want to do remount-read-only
> for source filesystems, which is operation we support perfectly fine,
> and after that create union mount. But I agree you cannot do quite that
> since you need to have write access later from your union mount. So
> maybe it's not so easy as I thought.
>   On the other hand, there was some effort to support read-only bind-mounts of
> read-write filesystems (there were even some patches floating around but
> I don't think they got merged) and that should be even closer to what
> you'd need...

I didn't know about those patches, but yes, they do sound useful.  I'm
curious who needed such functionality before and why.  If someone can point
me to those patches, we can look into using them for Unionfs.  Thanks.

> 									Honza
> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Erez.
