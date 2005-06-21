Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVFUNPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVFUNPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVFUNO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:14:26 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:39943 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261389AbVFUNNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:13:54 -0400
To: alan@lxorguk.ukuu.org.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1119357566.3325.127.camel@localhost.localdomain> (message from
	Alan Cox on Tue, 21 Jun 2005 13:39:28 +0100)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <1119357566.3325.127.camel@localhost.localdomain>
Message-Id: <E1DkiZA-0005Yl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jun 2005 15:13:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So I welcome constructive discussion.  However bear in mind, that I
> > definitely don't want to disable unprivileged mounts.  For me that is
> > _the_ most important feature of FUSE.
> 
> If the choice was "merge FUSE without unpriv mounts for now" or "discard
> fuse completely" which is preferable.

FUSE is doing fine outside mainline, so discard wouldn't be such a big
setback.  Including it without unpriv mounts would effectively fork
FUSE into an out-of-tree and an in-tree version, which is sure to
cause confusion.

So yes, I'd prefer not merging to merging without unpriv mounts.  But
it's GPL, so obviously I don't have any legal control over it.

> It seems to me (just IMHO) that it would be better to merge FUSE without
> that feature and then spend the time getting that feature right _in
> parallel_ with people using, breaking and reviewing FUSE a lot more.

The security measure in question is actually very simple (10 lines or
so).  So it's not the implementation that people have problems with
but the concept.  The concept itself is hard to swallow, because it
does something unexpected, but what it does is in fact very logical.

That's why I ask people to read the documentation, think about it and
_then_ argue.  Up till now the discussion with Christoph Hellwig about
this hasn't been on the level of rational arguments (and he's the only
definite naysayer).

Thanks,
Miklos
