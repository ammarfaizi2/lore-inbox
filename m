Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVGCNuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVGCNuT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 09:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGCNuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 09:50:19 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:58296 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261436AbVGCNuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 09:50:11 -0400
Date: Sun, 3 Jul 2005 15:50:10 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: frankvm@frankvm.com, akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: FUSE merging?
Message-ID: <20050703135010.GA1298@janus>
References: <20050701130510.GA5805@janus> <E1DoLSx-0002sR-00@dorka.pomaz.szeredi.hu> <20050701152003.GA7073@janus> <E1DoOwc-000368-00@dorka.pomaz.szeredi.hu> <20050701180415.GA7755@janus> <E1DojJ6-00047F-00@dorka.pomaz.szeredi.hu> <20050702160002.GA13730@janus> <E1DoxmP-0004gV-00@dorka.pomaz.szeredi.hu> <20050703112541.GA32288@janus> <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dp4S4-0004ub-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 03:24:04PM +0200, Miklos Szeredi wrote:
> > > Hmm, do you mean returning different directory contents based on uid?
> > 
> > 	http://clusternfs.sourceforge.net
> > 
> > Don't ask me how this plays with the dcache.
> 
> But here the decision on what to return is in the _server_.

It still means that name space invariancy cannot be guaranteed.

> There's
> nothing magic about that.  It's as if it was N different servers for N
> different clients, only more effective.

Not entirely, there is a UID dependancy.

> I think what you call namespace invariance is basically true for all
> existing filesystems.  There could be a filesystem which returns
> different directory contents based on whatever it wants, but it can't
> return a different "dentry" for the same name.

This is not what I mean. The directory contents itself must be identical
for every user. And every name must of course correspond with only one
dentry. That's name-space invariance IMO.

> > IMHO The namespace argument against FUSE is weak for multiple reasons. The
> > only variancy I see is when crossing the mount point. And that disappears
> > once EACCES is returned when non-ptraceable processes try to cross it.
> 
> Yes, but still this is just a difference in permission, and not a
> difference in namespace.

Exactly. And such a difference in permission already exists for (sane)
networked file systems such as NFS with "squash_root" in effect on
the server.

-- 
Frank
