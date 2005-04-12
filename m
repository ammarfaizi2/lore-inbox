Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVDLPBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVDLPBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVDLPBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:01:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:15776 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262427AbVDLOpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:45:44 -0400
Date: Tue, 12 Apr 2005 15:45:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050412144529.GE10995@mail.shareable.org>
References: <3S8oN-So-15@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> > Miklos Szeredi wrote:
> 
> >>   4) Access should not be further restricted for the owner of the
> >>      mount, even if permission bits, uid or gid would suggest
> >>      otherwise
> > 
> > Why?  Surely you want to prevent writing to files which don't have the
> > writable bit set?  A filesystem may also create append-only files -
> > and all users including the mount owner should be bound by that.
> 
> That will depend on the situation. If the user is mounting a tgz owned
> by himself, FUSE should default to being a convenient hex-editor.

If the user wants to edit a read-only file in a tgz owned by himself,
why can he not _chmod_ the file and _then_ edit it?

That said, I would _usually_ prefer that when I enter a tgz, that I
see all component files having the same uid/gid/permissions as the tgz
file itself - the same as I'd see if I entered a zip file.

-- Jamie
