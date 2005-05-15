Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVEOOX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVEOOX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVEOOX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:23:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22706 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261650AbVEOOXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:23:10 -0400
Date: Sun, 15 May 2005 16:23:08 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: git@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       mercurial@selenic.com, mpm@selenic.com, torvalds@osdl.org
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050515142307.GF13024@pasky.ji.cz>
References: <200505151152.j4FBqoW01239@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505151152.j4FBqoW01239@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 01:52:50PM CEST, I got a letter
where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> On Sun, 15 May 2005 14:40:42 +0200, Petr Baudis wrote:
> >Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
> >where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> [...]
> >> 	I don't understand what was wrong with Jeff Garzik's previous
> >> suggestion of using http/1.1 pipelining to coalesce the round trips.
> >> If you're worried about queuing too many http/1.1 requests, the client
> >> could adopt a policy of not having more than a certain number of
> >> requests outstanding or perhaps even making a new http connection
> >> after a certain number of requests to avoid starving other clients
> >> when the number of clients doing one of these transfers exceeds the
> >> number of threads that the http server uses.
> 
> >The problem is that to fetch a revision tree, you have to
> 
> >	send request for commit A
> >	receive commit A
> >	look at commit A for list of its parents
> >	send request for the parents
> >	receive the parents
> >	look inside for list of its parents
> >	...
> 
> >(and same for the trees).
> 
> 	Don't you usually have a list of many files for which you
> want to retrieve this information?  I'd imagine that would usually
> suffice to fill the pipeline.

That might be true for the trees, but not for the commit lists. Most
commits have a single parent, except merges, which are however extremely
rare with more than two parents too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
