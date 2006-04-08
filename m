Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWDHUEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWDHUEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWDHUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:04:16 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:56266 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751416AbWDHUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:04:15 -0400
Subject: Re: [PATCH] Script for automated historical Git tree grafting
From: Nicholas Miell <nmiell@comcast.net>
To: Petr Baudis <pasky@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <20060408030936.GN27631@pasky.or.cz>
References: <20060407004728.GA16588@pasky.or.cz>
	 <20060406175246.3bd1c972.akpm@osdl.org>
	 <20060408030936.GN27631@pasky.or.cz>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 13:04:12 -0700
Message-Id: <1144526652.2337.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-08 at 05:09 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 07, 2006 at 02:52:46AM CEST, I got a letter
> where Andrew Morton <akpm@osdl.org> said that...
> > Petr Baudis <pasky@suse.cz> wrote:
> > >
> > > This script enables Git users to easily graft the historical Git tree
> > >  (Bitkeeper history import) to the current history.
> > 
> > What impact will that have on the (already rather poor) performance of
> > git-whatchanged, gitk, etc?
> 
> Negative. ;-)
> 
> I didn't try gitk myself, but according to Nick Riviera it eats 1.6G...
> Otherwise, assuming that you have at least git-1.2.5, git-whatchanged on
> the whole tree should be roughly equally fast as it was before grafting,
> but git-whatchanged on individual paths is _significantly_ slower.
> 
> That said, 1.3.0rc2 should already have Linus' optimization which should
> fix or at least mitigate the performance hit on narrowed-down
> git-whatchanged.

Actually, it ate more than 1.6G -- that was just the resident size, and
it likes to allocate more memory in between you closing the window and
it finally exiting (or, you killing it before it OOMs the box, whichever
comes first).

qgit has absolutely no problem with the grafted full history, though,
and those previously mentioned rev-list changes by Linus should fix
git-whatchanged.







Unfortunately, this does nothing to fix the disturbing lack of useless
Simpsons trivia knowledge in the git community. Keith Packard made the
same mistake last week.

-- 
Nicholas Miell <nmiell@comcast.net>

