Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVDSTje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDSTje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVDSTj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:39:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:27267 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVDSTjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:39:19 -0400
Date: Tue, 19 Apr 2005 12:40:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
In-Reply-To: <20050419185807.GA1191@kroah.com>
Message-ID: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> Nice, it looks like the merge of this tree, and my usb tree worked just
> fine.

Yup, it all seems to work out.

> So, what does this now mean?  Is your kernel.org git tree now going to
> be the "real" kernel tree that you will be working off of now?  Should
> we crank up the nightly snapshots and emails to the -commits list?

I'm not quite ready to consider it "real", but I'm getting there.

I'm still working out some performance issues with merges (the actual
"merge" operation itself is very fast, but I've been trying to make the
subsequent "update the working directory tree to the right thing" be much
better).

> Can I rely on the fact that these patches are now in your tree and I can
> forget about them? :)
> 
> Just wondering how comfortable you feel with your git tree so far.

Hold off for one more day. I'm very comfortable with how well git has 
worked out so far, and yes, mentally I consider this "the tree", but the 
fact is, git isn't exactly easy on "normal users".

I think my merge stuff and Pasky's scripts are getting there, but I want
to make sure that we have a version of Pasky's scripts that use the new
"read-tree -m" optimizations to make tracking a tree faster, and I'd like
to have them _tested_ a bit first.

In other words, I want it to be at the point where people can do

	git pull <repo-address>

and it will "just work", at least for people who don't have any local
changes in their tree. None of this "check out all the files again" crap.

But how about a plan that we go "live" tomorrow - assuming nobody finds
any problems before that, of course.

			Linus
