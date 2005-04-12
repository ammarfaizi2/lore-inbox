Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVDLOpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVDLOpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVDLOoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:44:17 -0400
Received: from mail.shareable.org ([81.29.64.88]:13984 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262260AbVDLOhW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:37:22 -0400
Date: Tue, 12 Apr 2005 15:37:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, dan@debian.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412143707.GD10995@mail.shareable.org>
References: <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3S9b7-1yl-1@gated-at.bofh.it> <3S9uB-1Lj-3@gated-at.bofh.it> <3SbG5-3Mb-41@gated-at.bofh.it> <3ScC1-4zl-1@gated-at.bofh.it> <3ScLO-4GA-9@gated-at.bofh.it> <3SdeV-54h-21@gated-at.bofh.it> <3SeXf-6BK-21@gated-at.bofh.it> <E1DLKOd-0001Nd-MG@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLKOd-0001Nd-MG@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> >> That is exactly the intended effect.  If I'm at my work machine (where
> >> I'm not an admin unfortunately) and I mount my home machine with sshfs
> >> (because FUSE is installed fortunately :), then I bloody well don't
> >> want the sysadmin or some automated script of his to go mucking under
> >> the mountpoint.
> > 
> > I think that would be _much_ nicer implemented as a mount which is
> > invisible to other users, rather than one which causes the admin's
> > scripts to spew error messages.  Is the namespace mechanism at all
> > suitable for that?
> 
> This will require shared subtrees plus a way for new logins from the same
> user to join an existing (previous login) namespace.

Or "per-user namespaces".

It's part of a more general problem of how you limit access to private
data such as crypto keys, either per user, or more finely than that.

Isn't that what all the keyring stuff is for?

-- Jamie
