Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWHaRVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWHaRVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWHaRVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:21:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750777AbWHaRVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:21:44 -0400
Date: Thu, 31 Aug 2006 10:21:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060831102127.8fb9a24b.akpm@osdl.org>
In-Reply-To: <9849.1157018310@warthog.cambridge.redhat.com>
References: <20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 10:58:30 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > - Send fine-grained incremental patches.  It's OK to do complete
> >   replacement patchsets when the code is new, but this stuff is supposed to
> >   be stabilised.
> 
> I thought the code was still officially *new*.

It's been floating around for ages; we want it to become *old*, showing a
decreasing rate of change.

> As I understood things from what you said, you delegated responsibility for my
> patches on to Trond, who hasn't taken them yet.

Trond merged the large nfs-affecting ones; I don't know if he intends to
handle the non-nfs bulk of the work though.

I doesn't matter, really - I'll frequently carry features with a plan to
send them into a subsystem tree.  Or Trond could duck it and I can send the
patches direct to Linus after git-nfs has merged.

Either way, the patches which are presently in -mm are "in the pipeline" -
they're the ones which people are testing (for compile, at least) and
reviewing (hah).  If we decide to send them into Trond then I'll add them
to my things-to-spam-maintainers-with pile.

Your CONFIG_BLOCK patches did a decent job of trashing your
fs-cache-make-kafs-* patches, btw.  What's up with that?  OK, it's sensible
for people to work against mainline but the net effect of doing that is to
create a mess for other people to clean up.

>  He has further delegated
> review responsibility on to Christoph, so I've been consolidating my patches
> to make it easier for Christoph (or whoever) to do so.

These patches are quite large and complex.  Frankly, I doubt if Trond or
Christoph have the bandwidth to review them.  It would be excellent if they
were able to, but...

We have a large coder-versus-reviewer imbalance, especially in the
filesystems area.  cf reiser4.

> So, as I understand the situation, my patches won't go anywhere until
> Christoph ACKs them and Trond takes them into his tree.  If this isn't so,
> please clarify the situation.
> 

If Christoph acks them then I can send them to Trond or Linus, at Trond's
option.

Or I can butt out, drop the patches, wait for them to turn up in Trond's
tree, at your option.
