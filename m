Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbVICFcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbVICFcA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbVICFcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:32:00 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:54791 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161141AbVICFb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:31:59 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
       torvalds@osdl.org
In-reply-to: <20050902153440.309d41a5.akpm@osdl.org> (message from Andrew
	Morton on Fri, 2 Sep 2005 15:34:40 -0700)
Subject: Re: FUSE merging?
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu> <20050902153440.309d41a5.akpm@osdl.org>
Message-Id: <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 03 Sep 2005 07:31:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Haven't thought about it all much.  Have spent most of my time in the last
> month admiring the contents of kernel bugzilla, and the ongoing attempts to
> increase them.

A penal system could be created, for example if someone is caught
introducing a bug, he will have to choose three additional reports
from bugzilla and analyze/fix them ;)

> >  - number of language bindings: 7 (native: C, java, python, perl,
> >  - C#, sh, TCL)

8 now, someone just sent a private mail about bindings for the Pliant
(never heard of it) language.

> I agree that lots of people would like the functionality.  I regret that
> although it appears that v9fs could provide it,

I think you are wrong there.  You don't appreciate all the complexity
FUSE _lacks_ by not being network transparent.  Just look at the error
text to errno conversion muck that v9fs has.  And their problems with
trying to do generic uid/gid mappings.

> there seems to be no interest in working on that.

It would mean adding a plethora of extensions to the 9P protocol, that
would take away all it's beauty.  I think you should realize that
these are different interfaces for different purposes. There may be
some overlap, but not enough to warrant trying to massage them into
one big ball.

> The main sticking point with FUSE remains the permission tricks around
> fuse_allow_task().  AFAIK it remains the case that nobody has come up with
> any better idea, so I'm inclined to merge the thing.

Do you promise?  I can do a resplit and submit to Linus, if that takes
some load off you.

Thanks,
Miklos
