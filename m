Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVFVRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVFVRzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVFVRvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:51:42 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:40718 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261690AbVFVRtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:49:22 -0400
To: tytso@mit.edu
CC: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050622170135.GB18544@thunk.org> (message from Theodore Ts'o on
	Wed, 22 Jun 2005 13:01:35 -0400)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622170135.GB18544@thunk.org>
Message-Id: <E1Dl9LG-0007xP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 19:48:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think this should be objectionable, since we already have
> times when root-owned tasks can get EACCESS when accessing some
> filesystem.  This can happen with any distributed filesystem that
> enforces real security --- whether it be nfs-root-squash, or the
> Andrew Filesystem, or NFSv4.  Root can get "permission denied" when
> some other userid with appropriate credentials would be allowed to
> access the file/directory.

Right.

> On the other hand, sometimes a root process, or some other user's
> process, might _want_ to give permission to allow a trusted FUSE
> filesystem the potential to monkey with it (return potentially
> untrusted information, or stop it entirely), in exchange for access to
> the filesystem.  So it would be nice if there was some way that a
> process could tell the kernel that it is willing to give permission to
> allow certain FUSE filesystems to potentially affect it.  Say, via a
> fnctl() call, perhaps.

Hmm.  'su' works for root.  

How do you think fcntl() could be used?  I think a task flag settable
via prctl() would be more appropriate.

Miklos
