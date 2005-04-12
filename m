Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVDLQyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVDLQyl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDLQxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:53:11 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:34271 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262411AbVDLQwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:52:24 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412164501.GB14149@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 17:45:01 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org> <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu> <20050412161303.GI10995@mail.shareable.org> <E1DLOO0-0001xj-00@dorka.pomaz.szeredi.hu> <20050412164501.GB14149@mail.shareable.org>
Message-Id: <E1DLOcX-0001zw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 18:52:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > > And for either version of NFS, if the uid and gid are non-zero, and
> > > the permission bits indicate that an access is permitted, then the
> > > client does not consult the server for permission.
> > 
> > Where's that?  I see no such check.
> 
> 	/*
> 	 * Trust UNIX mode bits except:
> 	 *
> 	 * 1) When override capabilities may have been invoked
> 	 * 2) When root squashing may be involved
> 	 * 3) When ACLs may overturn a negative answer */
> 	if (!capable(CAP_DAC_OVERRIDE) && !capable(CAP_DAC_READ_SEARCH)
> 	    && (current->fsuid != 0) && (current->fsgid != 0)
> 	    && error != -EACCES)
> 		goto out;

Still can't find it :)

Which kernel?  Which file?

Thanks,
Miklos
