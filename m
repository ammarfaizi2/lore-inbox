Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWDHDIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWDHDIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 23:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWDHDIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 23:08:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8853 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965003AbWDHDIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 23:08:40 -0400
Date: Sat, 8 Apr 2006 05:09:36 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [PATCH] Script for automated historical Git tree grafting
Message-ID: <20060408030936.GN27631@pasky.or.cz>
References: <20060407004728.GA16588@pasky.or.cz> <20060406175246.3bd1c972.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406175246.3bd1c972.akpm@osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Apr 07, 2006 at 02:52:46AM CEST, I got a letter
where Andrew Morton <akpm@osdl.org> said that...
> Petr Baudis <pasky@suse.cz> wrote:
> >
> > This script enables Git users to easily graft the historical Git tree
> >  (Bitkeeper history import) to the current history.
> 
> What impact will that have on the (already rather poor) performance of
> git-whatchanged, gitk, etc?

Negative. ;-)

I didn't try gitk myself, but according to Nick Riviera it eats 1.6G...
Otherwise, assuming that you have at least git-1.2.5, git-whatchanged on
the whole tree should be roughly equally fast as it was before grafting,
but git-whatchanged on individual paths is _significantly_ slower.

That said, 1.3.0rc2 should already have Linus' optimization which should
fix or at least mitigate the performance hit on narrowed-down
git-whatchanged.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
