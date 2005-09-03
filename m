Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVICPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVICPiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVICPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 11:38:50 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:783 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750983AbVICPit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 11:38:49 -0400
To: ericvh@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net, v9fs-developer@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-reply-to: <a4e6962a0509030801616dd011@mail.gmail.com> (message from Eric
	Van Hensbergen on Sat, 3 Sep 2005 10:01:49 -0500)
Subject: Re: FUSE merging?
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	 <20050902153440.309d41a5.akpm@osdl.org>
	 <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a050903062941d46389@mail.gmail.com>
	 <E1EBYsp-0007Sc-00@dorka.pomaz.szeredi.hu> <a4e6962a0509030801616dd011@mail.gmail.com>
Message-Id: <E1EBa5v-0007Xz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 03 Sep 2005 17:38:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, it may confuse the user.  It may even confuse the kernel for
> > sticky directories(*).  But basically it just works, and is very
> > simple.
> > 
> 
> In principal, Plan 9 file servers handle permission checking
> server-side, so we could likewise punt -- but it seemed a good idea to
> have some form of mapping for directory listings (and things like
> sticky directories) to make sense.

Yes if the user/group names are available (as in 9P), then doing the
mapping based on /etc/passwd for example makes sense.

But sshfs only transfers the numeric uid/gid, and hence there's simply
no info to base any transformation on.

It could transfer /etc/passwd from the remote server, and use that to
do mapping, but that is getting more complex than the problem actually
warrants IMO.

Miklos
