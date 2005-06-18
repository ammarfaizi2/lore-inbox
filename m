Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVFRSKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVFRSKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVFRSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:10:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262167AbVFRSE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:04:56 -0400
Date: Sat, 18 Jun 2005 11:06:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
In-Reply-To: <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org>
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Linus Torvalds wrote:
> On Sat, 18 Jun 2005, Jeff Garzik wrote:
> > 
> > GIT NOTE 1:  The top-of-tree cset is the result of my use of the new git 
> > conflict merging code.  It seemed to work quite nicely.  I did:
> > 
> > 	git-pull-script $vanilla_linus_repo	# conflicts appeared
> > 	vi drivers/net/r8169.c			# fix conflict
> > 	git-update-cache drivers/net/r8169.c
> > 	git-commit-tree ...
> 
> The last step can be just "git commit", and it will do the right thing
> these days (and with a nice big warnign that it looks like you're
> committing a merge).

In fact, your last commit was broken, exactly because you had _not_ done 
this part right.

Your parent information was crap, meaning that when I pulled, I had to
re-merge. In fact, I'm going to undo this pull entirely, because of this -
it's simply _wrong_. You claim to have done a merge and indeed your "data"
is merged, but your history is totally buggered because you didn't do the 
proper parents.

		Linus
