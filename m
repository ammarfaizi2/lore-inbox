Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVDMSig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVDMSig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDMSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:38:35 -0400
Received: from iabervon.org ([66.92.72.58]:55046 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261194AbVDMShn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:37:43 -0400
Date: Wed, 13 Apr 2005 14:38:00 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Petr Baudis <pasky@ucw.cz>
cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
In-Reply-To: <20050413180719.GA25716@pasky.ji.cz>
Message-ID: <Pine.LNX.4.21.0504131420280.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Petr Baudis wrote:

> Dear diary, on Wed, Apr 13, 2005 at 07:01:34PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > For future reference, git is unhappy if you actually do this, because your
> > HEAD won't match the (empty) contents of the new directory. The easiest
> > thing is to cp -r your original, replace the shared stuff with links, and
> > go from there.
> 
> How is it unhappy? That would likely be a bug, unless you do something
> which really *needs* the tree populated and doesn't make sense otherwise
> (show-diff aka git diff w/o arguments, for example).

If you copy HEAD without copying the files, it will then try to apply the
patches which would apply to your previous directory to the empty
directory, which will just give a lot of errors about missing files. If
you don't copy HEAD, it tries to compare against nothing.

Upon further consideration, a "checkout-cache -a" at the end of your list
makes things generally happy.

The next problem is that rsync is replacing the .git/objects symlink with
the remote system's directory, which makes this not actually helpful.

	-Daniel
*This .sig left intentionally blank*

