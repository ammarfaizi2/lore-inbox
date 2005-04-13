Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVDMRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVDMRDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDMRDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:03:18 -0400
Received: from mail.shareable.org ([81.29.64.88]:24993 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261404AbVDMRDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:03:00 -0400
Date: Wed, 13 Apr 2005 18:02:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: aia21@cam.ac.uk, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413170222.GJ12825@mail.shareable.org>
References: <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org> <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> I have a little project to imlement a "userloop" filesystem, which
> works just like "mount -o loop", but you don't need root privs.  This
> is really simple to do with FUSE and UML.

That would be a nice way to implement those rarely used old
filesystems that aren't really needed in the kernel source tree any
more, but which it would be nice to have access to as legacy
filesystem formats.

In other words, migrating old legacy filesystems out of the kernel
tree, into FUSE.

> I don't think that it's far feched, that in certain situations the
> user _does_ have the right (and usefulness) to do otherwise privileged
> filesystem operations.

It's really a matter of philosophy, as to whether the results of
stat() are just handy information for the user, or are always defined
to mean what you can/can't do with a file.

Local-ssh-into-UML makes more sense for this in some ways, because the
uids/gids inside your tgz files or foreign loop filesystems are not
related to the space of uids/gids of the host system.  Yet, the
results from stat() don't distinguish the number spaces, and "ls"
doesn't map the numbers to names properly in the wrong space.

-- Jamie
