Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVD0NXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVD0NXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVD0NXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:23:50 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:21924 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261309AbVD0NXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:23:20 -0400
To: bulb@ucw.cz
CC: pavel@suse.cz, hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050427123944.GA11020@vagabond> (message from Jan Hudec on Wed,
	27 Apr 2005 14:39:44 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu> <20050427123944.GA11020@vagabond>
Message-Id: <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 15:22:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It makes no sense.  If someone would give me a rational explanation
> > why it is bad, I would be content.  But you just tell me it's
> > terrible, ugly, crap which may well be true, but are not technical
> > terms, which I can relate to.
> 
> Where the hell do you see it above.

I meant it as a plural "you" mainly refering to Christoph, who did use
those words, and not too sparingly either :)

I did not mean it personally, please accept my apologies.

> The userland tools don't need to know. They just need to not be suid.

But I'd want to continue distribute the non-crippled kernel module
too, with suid fusermount.  Then fusermount _has_ to know which kernel
module is currently active.

> Ok, here I say it is ugly (but not that it's crap). And the reason is,
> that there is a permission system, with some semantics, and then various
> filesystems adapt it in varous ways to fit what they want. So every
> filesystem ends up with it's onw little different behaviour.
> 
> That being said, fuse does just about the same as NFS, samba and others
> and I don't really see the reason why it couldn't be integrated. But
> I am not the one to decide.

Every opinion counts.

I'm not trying to convince people that the current solution is
perfect.  What I'm saying that it's

  a) not harmful

  b) it makes non-privileged mounts possible

And b) is _the_ most important feature IMO, so the argument for
stripping it out has to be very good.

Thanks,
Miklos

