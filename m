Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVDMJOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVDMJOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 05:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDMJOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 05:14:42 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:28899 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261152AbVDMJOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 05:14:39 -0400
To: jamie@shareable.org
CC: aia21@cam.ac.uk, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412215220.GA23321@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 22:52:20 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org>
Message-Id: <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Apr 2005 11:14:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are uses for both.  For example today I was updating the tar ball 
> > which is used to create the var file system for a new chroot.  I certainly 
> > want to see corretly setup owner/permissions when I look into that tar 
> > ball using a FUSE fs...
> 
> If I'm updating a var filesystem for a new chroot, I'd need the
> ability to chmod and chown things in that filesystem.  Does that work
> as an ordinary user?

Yes, within UML for example. 

I have a little project to imlement a "userloop" filesystem, which
works just like "mount -o loop", but you don't need root privs.  This
is really simple to do with FUSE and UML.

I don't think that it's far feched, that in certain situations the
user _does_ have the right (and usefulness) to do otherwise privileged
filesystem operations.

Miklos
