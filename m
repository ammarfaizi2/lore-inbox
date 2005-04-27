Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVD0MZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVD0MZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 08:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVD0MZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 08:25:11 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:9892 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261525AbVD0MZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 08:25:02 -0400
To: bulb@ucw.cz
CC: pavel@suse.cz, hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050427115754.GA8981@vagabond> (message from Jan Hudec on Wed,
	27 Apr 2005 13:57:54 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond>
Message-Id: <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 14:23:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What makes you think Pavel was talking about semantics?!

    Well, if it brings us ugly semantics, keeping those two lines out for
                               ^^^^^^^^^
    a while can help merge a lot...

> The point was that:
> Ok, there is a strong disagreement about these two lines. Could we have
> a patch with everything but these two lines, so it can be integrated
> immediately to profit of the testing and generally be useful, and then
> the controversial bits when the issue is beaten to death?

I could remove this check.

But it would only cause confusion.  How would the userspace utilities
differentiate between the safe out-of-kernel and the unsafe in-kernel
module?  Adding hacks to make this possible is far more ugly IMO than
integrating the current well tested solution.

It makes no sense.  If someone would give me a rational explanation
why it is bad, I would be content.  But you just tell me it's
terrible, ugly, crap which may well be true, but are not technical
terms, which I can relate to.

> As I understand it, doing things like this is butt ugly. Not just in
> fuse -- in NFS, in samba, everywhere where such hacks are employed. But
> now they just have enough of those hacks and want a cleaner solution.

Please do.  I want it too.

_When_ we have a better solution, all the hacks can be removed, and
the world will rejoice.

Until then, let the hacks live!  Please!

Thanks,
Miklos
