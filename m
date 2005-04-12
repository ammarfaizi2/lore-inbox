Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVDLQNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVDLQNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVDLQJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:09:23 -0400
Received: from mail.shareable.org ([81.29.64.88]:21664 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262412AbVDLQE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:04:27 -0400
Date: Tue, 12 Apr 2005 17:04:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412160409.GH10995@mail.shareable.org>
References: <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > If the user wants to edit a read-only file in a tgz owned by himself,
> > why can he not _chmod_ the file and _then_ edit it?
> > 
> > That said, I would _usually_ prefer that when I enter a tgz, that I
> > see all component files having the same uid/gid/permissions as the tgz
> > file itself - the same as I'd see if I entered a zip file.
> 
> I can accept that usually you are not interested in the stored
> uid/gid.  But doubt that you want to lose permission information when
> you mount a tar file.  Zip is a different kettle of fish since that
> doesn't contain uid/gid/permissions.

It's not about being not interested.

It's because I'd want my programs, and other users, to have exactly
the same access to the tgz contents through vfs as they have when
accessing the tgz file directly.  Not some baroque combination of
unobvious hard-coded permission rules, that aren't even visible
through stat(), and which both increase permissions for the user and
decrease it for others at the same time.

I see why you may want to hide certain things from other users
sometimes - the sshfs example is a good one.  I daresay Al Viro could
come up with a per-user or per-keyring mount point for those occasions :)

-- Jamie
