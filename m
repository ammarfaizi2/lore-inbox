Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946583AbWJSWZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946583AbWJSWZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946585AbWJSWZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:25:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946583AbWJSWZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:25:14 -0400
Date: Thu, 19 Oct 2006 15:25:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
Message-Id: <20061019152503.217a82aa.akpm@osdl.org>
In-Reply-To: <4537EB67.8030208@drzeus.cx>
References: <4537EB67.8030208@drzeus.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 23:17:27 +0200
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Hi guys,
> 
> In an effort to change my work flow into a manner that is more suitable
> for upstream merging and publishing my trees, I though I could ask for
> some input from the more experienced.
> 
> 
> My intended work flow is to work on stuff on temporary topic branches,
> and cherry-pick or diff|patch them into other trees when they are mature
> enough.
> 
> Stuff that need a bit more testing will be put in a public "for-andrew"
> branch. From what I gather, Andrew does a pull and a diff of these kinds
> of branches before putting together a -mm set. So this should be
> sufficient for your needs? Do you also prefer getting "[GIT PULL]"
> requests, or do you do the pull periodically anyway?

Just send me the url&branch-name for a tree which you want included in -mm.
I typically pull all the trees once per day.  I usually won't even look at
the contents of what I pulled from you unless it breaks.

IOW, -mm is like a tree to which 70-odd people have commit permissions,
except it's 70 separate trees and I independently jam them all into one
tree daily.

> Patches that are considered stable, either directly or by virtue of
> being in -mm for a while, will be moved into a "for-linus" tree and a
> "[GIT PULL]" sent to herr Torvalds.

yup.

> Now, the patch in "for-linus" will be a duplicate of one or several
> commits in "for-andrew". Will I get any problems from git once I do a
> new pull from Linus' tree into "for-andrew"?

git will sort that out.

> Another concern is all the merges. As I have modifications in my tree,
> every merge should generate at least one commit and one tree object. Is
> this kind of noise in the git history something that needs concern?

I'll leave that question to a gittier responder.  But yes, you'll get
shouted at if Linus's final commit contains irrelevant commit and merge
stuff.

