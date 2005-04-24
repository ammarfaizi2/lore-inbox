Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVDXWXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVDXWXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVDXWXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 18:23:20 -0400
Received: from mail.shareable.org ([81.29.64.88]:11432 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262461AbVDXWXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 18:23:13 -0400
Date: Sun, 24 Apr 2005 23:22:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] private mounts
Message-ID: <20050424222258.GA10685@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <1114381206.4480.54.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114381206.4480.54.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > Much better is the proposal to make namespaces first-class objects,
> > that can be switched to.  Then users can choose to have themselves a
> > namespace containing their private mounts, if they want it, with
> > login/libpam or even a program run from .profile switching into it.
> > 
> > While users can be allowed to create their own namespaces which affect
> > the path traversal of their _own_ directories, it's important that the
> > existence of such namespaces cannot affect path traversal of other
> > directories such as /etc, or /autofs/whatever - and that creation of
> > namespaces by a user cannot prevent the unmounting of a non-user
> > filesystem either.
> > 
> > The way to do that is shared subtrees, or something along those lines.
> 
> Right. Adding to it. To begin with the system namespace has all its
> entire tree shared. So when a new namespace is cloned, the new namespace
> can see any new mount/unmount/binds done in the system namespace as
> well. (System namespace is the first initial namespace created by
> default).
> 
> Any private mounts done by the user in his private-namespace 
> will first make that part of the tree private first and then will
> continue with the mount. Otherwise the private mount will end up showing
> in the system namespace(since it is shared).

Yes, exactly that.

-- Jamie
