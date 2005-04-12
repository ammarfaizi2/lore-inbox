Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVDLQmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVDLQmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVDLQlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:41:10 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:27615 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262392AbVDLQhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:37:24 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412161303.GI10995@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 17:13:03 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org> <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu> <20050412161303.GI10995@mail.shareable.org>
Message-Id: <E1DLOO0-0001xj-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 18:37:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Note that NFS checks the permissions on _both_ the client and server,
> > > for a reason.
> > 
> > Does it?  If I read the code correctly the client checks credentials
> > supplied by the server (or cached).  But the server does the actual
> > checking of permissions.
> > 
> > Am I missing something?
> 
> Yes, for NFSv2, this test in nfs_permssion():
> 
> 	if (!NFS_PROTO(inode)->access)
> 		goto out;

I've seen that, I just thought that was for some broken servers not
for all NFSv2 servers.

Anyway that's been fixed in NFSv3, so obviously the "permission
checking on both sides" wasn't optimal :)

> And for either version of NFS, if the uid and gid are non-zero, and
> the permission bits indicate that an access is permitted, then the
> client does not consult the server for permission.

Where's that?  I see no such check.

Thanks,
Miklos
