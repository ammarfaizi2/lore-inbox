Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVDJX4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDJX4f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVDJX4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:56:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:737 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261498AbVDJX4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:56:22 -0400
Date: Mon, 11 Apr 2005 01:56:17 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410235617.GE18661@pasky.ji.cz>
References: <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org> <20050410222737.GC5902@pasky.ji.cz> <Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org> <20050410232637.GC18661@pasky.ji.cz> <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 11, 2005 at 01:46:50AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Mon, 11 Apr 2005, Petr Baudis wrote:
> > 
> > (BTW, it would be useful to have a tool which just blindly takes what
> > you give it on input and throws it to an object of given type; I will
> > need to construct arbitrary commits during the rebuild if I'm to keep
> > the correct dates.)
> 
> Hah. That's what "COMMITTER_NAME" "COMMITTER_EMAIL" and "COMMITTER_DATE" 
> are there for.
> 
> There's two things to commits: when (and by whom) it was committed to a
> tree, and when the changes were really done.
> 
> So set the COMMITTER_xxx things to the person/time you want to consider 
> the _original_ one, and let "commit-tree" author you as the creator of the 
> commit itself. The regular "ChangeLog" thing should only show the author 
> and original time, but it's nice to see who created the commit itself.

I already use those - look at my ChangeLog. (That's because for certain
reasons I'm working on git in a half-broken chrooted environment.)

When rebuilding the tree from scratch, I wanted like to do it
transparently - that is, so that noone could notice that I rebuilt it,
since it effectively still _is_ the original tree from the data
standpoint, just the history flow is actually correct this time.

> Btw, the "COMMITTER_xxxx" environment variables are very confusingly
> named. They actually go into the _author_ line in the commit object. I'm a
> total retard, and I really don't know why I called it "COMMITTER_xxx"  
> instead of "AUTHOR_xxx".

So, who will fix it in his tree first! ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
