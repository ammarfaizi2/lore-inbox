Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTJCARJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 20:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263559AbTJCARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 20:17:09 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63688 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263556AbTJCARH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 20:17:07 -0400
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
From: Albert Cahalan <albert@users.sf.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F7C60C9.1090108@redhat.com>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
	 <3F7B9CF9.4040706@redhat.com> <1065067968.741.75.camel@cube>
	 <3F7BB073.60509@redhat.com> <1065102539.741.94.camel@cube>
	 <3F7C60C9.1090108@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1065139380.736.109.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Oct 2003 20:03:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 13:30, Ulrich Drepper wrote:
> Albert Cahalan wrote:
> 
> > To the user, maybe. To the admin, no. The admin uses
> > fuser and/or lsof to find out why he can't umount.
> > If those programs were thread-aware (they are not),
> > then they could take many minutes to run.
> > 
> > In other words, stuff runs faster if we can ban this.
> > If not, please suggest a way to make fuser and lsof fast.
> 
> Don't you see the flaw in your argumentation?

No. I mean "ban" like we ban CLONE_THREAD w/o CLONE_DETACHED.
Remember, the last stable release of the kernel (2.4.xx)
didn't have the ability to do CLONE_THREAD at all. So it
isn't as if real-world apps are depending on the ability
to do CLONE_THREAD w/o sharing file descriptors.

Got a legitimate must-have real-world use for it?


