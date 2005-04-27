Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVD0XAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVD0XAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVD0XAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:00:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33450 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262076AbVD0W7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:59:55 -0400
Date: Wed, 27 Apr 2005 16:58:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050427145842.GD28119@elf.ucw.cz>
References: <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427115754.GA8981@vagabond> <E1DQla0-0001vG-00@dorka.pomaz.szeredi.hu> <20050427123944.GA11020@vagabond> <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQmUm-0001yy-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The userland tools don't need to know. They just need to not be suid.
> 
> But I'd want to continue distribute the non-crippled kernel module
> too, with suid fusermount.  Then fusermount _has_ to know which kernel
> module is currently active.

Add a mount flag and make kernel refuse mount on unknown flags?

> > Ok, here I say it is ugly (but not that it's crap). And the reason is,
> > that there is a permission system, with some semantics, and then various
> > filesystems adapt it in varous ways to fit what they want. So every
> > filesystem ends up with it's onw little different behaviour.
> > 
> > That being said, fuse does just about the same as NFS, samba and others
> > and I don't really see the reason why it couldn't be integrated. But
> > I am not the one to decide.
> 
> Every opinion counts.
> 
> I'm not trying to convince people that the current solution is
> perfect.  What I'm saying that it's
> 
>   a) not harmful
> 
>   b) it makes non-privileged mounts possible
> 
> And b) is _the_ most important feature IMO, so the argument for
> stripping it out has to be very good.

Well, you'll have problems with suid programs suddenly not being able
to access files. nfs gets away with it, but nfs is perceived as
"broken" anyway...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
