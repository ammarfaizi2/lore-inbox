Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVGCOE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVGCOE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVGCOE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 10:04:27 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:52754 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261442AbVGCOEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 10:04:22 -0400
To: frankvm@frankvm.com
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050703135010.GA1298@janus> (message from Frank van Maarseveen
	on Sun, 3 Jul 2005 15:50:10 +0200)
Subject: Re: FUSE merging?
References: <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu> <20050703135010.GA1298@janus>
Message-Id: <E1Dp54X-00050g-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 03 Jul 2005 16:03:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There's
> > nothing magic about that.  It's as if it was N different servers for N
> > different clients, only more effective.
> 
> Not entirely, there is a UID dependancy.

Ahh, so there is.

Does it actually work?  I doubt it.  The VFS won't allow two different
dentries to refer to the same name.  And without that, how would you
have several inodes for a single name?

> > I think what you call namespace invariance is basically true for all
> > existing filesystems.  There could be a filesystem which returns
> > different directory contents based on whatever it wants, but it can't
> > return a different "dentry" for the same name.
> 
> This is not what I mean. The directory contents itself must be identical
> for every user. And every name must of course correspond with only one
> dentry. That's name-space invariance IMO.

OK.

> > > IMHO The namespace argument against FUSE is weak for multiple
> > > reasons. The only variancy I see is when crossing the mount
> > > point. And that disappears once EACCES is returned when
> > > non-ptraceable processes try to cross it.
> > 
> > Yes, but still this is just a difference in permission, and not a
> > difference in namespace.
> 
> Exactly. And such a difference in permission already exists for (sane)
> networked file systems such as NFS with "squash_root" in effect on
> the server.

Agreed.

Miklos
