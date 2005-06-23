Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVFWXfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVFWXfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbVFWXfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:35:00 -0400
Received: from thunk.org ([69.25.196.29]:60579 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262883AbVFWXem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:34:42 -0400
Date: Thu, 23 Jun 2005 19:34:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050623233431.GB6485@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, pavel@ucw.cz,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622170135.GB18544@thunk.org> <E1Dl9LG-0007xP-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Dl9LG-0007xP-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 07:48:50PM +0200, Miklos Szeredi wrote:
> > On the other hand, sometimes a root process, or some other user's
> > process, might _want_ to give permission to allow a trusted FUSE
> > filesystem the potential to monkey with it (return potentially
> > untrusted information, or stop it entirely), in exchange for access to
> > the filesystem.  So it would be nice if there was some way that a
> > process could tell the kernel that it is willing to give permission to
> > allow certain FUSE filesystems to potentially affect it.  Say, via a
> > fnctl() call, perhaps.
> 
> Hmm.  'su' works for root.  

??  Not sure what you're saying.

> How do you think fcntl() could be used?  I think a task flag settable
> via prctl() would be more appropriate.

The problem with a task flag is that a root process might not want to
give permission for _all_ user-mountable filesystem, but only certain
ones.  So the idea is that the process should be able to specify
specific mountpoints as being "ok" for the process to access.

					- Ted
