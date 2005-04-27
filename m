Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVD0Ocx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVD0Ocx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVD0Ocw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:32:52 -0400
Received: from mail.shareable.org ([81.29.64.88]:54185 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261662AbVD0Ocf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:32:35 -0400
Date: Wed, 27 Apr 2005 15:31:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@suse.cz, hch@infradead.org, linuxram@us.ibm.com, 7eggert@gmx.de,
       bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427143126.GB1957@mail.shareable.org>
References: <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > > This is the controversial part in all it's glory:
> > > 
> > > 	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
> > > 		return -EACCES;
> > > 
> > > Leaving it out would gain us what exactly?
> > 
> > Well, if it brings us ugly semantics, keeping those two lines out for
> > a while can help merge a lot...
> 
> To the mount owner the semantics are quite normal.  Others will be
> denied access to the mountpoint, which doesn't introduce any new
> semantics either.

Why, exactly, is this check in the kernel and not the FUSE daemon?

Someone said the FUSE daemon knows which user is making filesystem
requests, and can therefore do this.  Is it true?

-- Jamie
