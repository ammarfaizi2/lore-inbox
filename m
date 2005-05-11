Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVEKVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEKVcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVEKVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:32:52 -0400
Received: from mail.shareable.org ([81.29.64.88]:53968 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261232AbVEKVct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:32:49 -0400
Date: Wed, 11 May 2005 22:32:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511213218.GE5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <20050511210935.GA5093@mail.shareable.org> <E1DVydB-0002RF-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVydB-0002RF-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > I don't see the purpose of current->namespace and the associated mount
> > restrictions at all.  I asked Al Viro what it's for, but haven't seen
> > a reply :(  IMHO current->namespace should simply be removed, because the
> > "current namespace" is represented just fine by
> > current->fs->rootmnt->mnt_namespace.
> 
> I'll look at what it would take to remove current->namespace.

The security implications don't seem to be important.  If you don't
want someone to access a namespace, then don't make it accessible.

But knowing Al it might exist for some subtle locking reason.  Be sure
to study the locking carefully :)

-- Jamie
