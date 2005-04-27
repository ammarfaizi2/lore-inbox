Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVD0Kne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVD0Kne (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 06:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVD0KnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 06:43:19 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:55459 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261396AbVD0KnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 06:43:07 -0400
To: pavel@suse.cz
CC: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050427092450.GB1819@elf.ucw.cz> (message from Pavel Machek on
	Wed, 27 Apr 2005 11:24:50 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz>
Message-Id: <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 12:42:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is the controversial part in all it's glory:
> > 
> > 	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
> > 		return -EACCES;
> > 
> > Leaving it out would gain us what exactly?
> 
> Well, if it brings us ugly semantics, keeping those two lines out for
> a while can help merge a lot...

To the mount owner the semantics are quite normal.  Others will be
denied access to the mountpoint, which doesn't introduce any new
semantics either.

If you look at it from the POV of _any_ process, there are NO NEW
SEMANTICS.  Nothing that programs, scripts or anything has to be
modified for.  Nothing that could cause _any_ problems later, if this
check was removed.

Prove me wrong!

Thanks,
Miklos
