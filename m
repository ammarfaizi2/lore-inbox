Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423230AbWJTVIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423230AbWJTVIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946514AbWJTVIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:08:43 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:11382 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423232AbWJTVIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:08:42 -0400
Date: Fri, 20 Oct 2006 14:08:22 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
Message-ID: <20061020210822.GH10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <20061020010715.GF10128@ca-server1.us.oracle.com> <45387090.7020509@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45387090.7020509@drzeus.cx>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 08:45:36AM +0200, Pierre Ossman wrote:
> Hmm.. What is the gain of having two tree instead of just more branches?
That way I have my own private playground where I can mess around with
patches, prototype new ideas, etc. It also serves as my local repository of
patches I got from other folks. I treat ocfs2.git as a 'public' repository,
so I don't want to pollute it with junk branches, etc.


> > Once I'm ready to send an upstream pull request, I'll update the master
> > branch of ocfs2.git. I then make a for-linus branch based off of it, and
> > git-cherry-pick each individual patch into that branch and send my request.
> >   
> 
> This should be equivalent of just keeping the "for-linus" branch around
> as it will just fast-forward along with Linus' tree when it doesn't
> contain any local changes. Or am I missing something?
Yeah. I just remove it after the merge and re-create later, but I could just
fast-forward it if I wanted to. I guess it's personal preference - it
doesn't really cost me much to re-create the for-linus branch.

 
> In other words, you destroy all the old history of your ALL branch and
> create a new one? So you couldn't continuously pull from that branch?
Yep. ALL is essentially a throwaway branch. Keep in mind that the topic
branches don't get thrown out until they've been merged upstream.

Typically people aren't pulling continuously from ALL. Most patches are
against Linus' tree - I take it as part of my "job" to handle merging stuff
into ALL.

 
> On questions related to that though. Previously, I've always sent plain
> patches to Andrew. After they have simmered a bit in -mm, he usually
> pushes them on to Linus, even though they do not qualify as being just
> bug fixes. As I will now be the one moving stuff from "from-andrew" to
> "for-linus", will the decision of what to move now fall on me? I would
> probably be more inclined to wait for the next merge window than Andrew is.
Yes, generally you now have the responsibility of deciding what patches in
your git tree are appropriate to be pushed upstream at any given time :)
There are rules that people should follow of course, which Linus outlined
earlier in this thread.

Good Luck!
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
