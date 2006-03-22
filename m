Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932795AbWCVVcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbWCVVcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932797AbWCVVcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:32:54 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:9105 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932795AbWCVVcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:32:53 -0500
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
References: <20060320150819.PS760228000000@infradead.org>
	<Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
	<Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
	<1142962995.4749.39.camel@praia>
	<Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
	<1142965478.4749.58.camel@praia>
	<Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
	<1142968537.4749.96.camel@praia>
	<Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
	<Pine.LNX.4.64.0603211829430.6773@iabervon.org>
	<Pine.LNX.4.64.0603211630140.3622@g5.osdl.org>
cc: Daniel Barkalow <barkalow@iabervon.org>, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Wed, 22 Mar 2006 13:32:50 -0800
In-Reply-To: <Pine.LNX.4.64.0603211630140.3622@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 21 Mar 2006 16:33:54 -0800 (PST)")
Message-ID: <7vmzfi6u7x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> The thing is, the above workflow generates a _buggy_ repository. It will 
> be entirely "correct" in the sense that it passes all git self-consistency 
> checks, but it's not really any different from doing
>
> 	dd if=/dev/urandom of=Makefile count=2
> 	git commit Makefile

It would be more like

	$ dd if=/dev/urandom of=Makefile count=2
	$ git commit Makefile
        $ git checkout HEAD^ Makefile
        $ git commit Makefile

> and then asking me to pull from the result. 

... because the point is that the end-result tree being what is
desired is not the only thing that matters, but the history to
get there should not have unnecessary garbage.

I am curious how you found it initially.  After you pulled but
before you did further work on top of the updated HEAD, I am
suspecting that there is some sanity check done by you to detect
that you pulled a faulty tree and decide to discard the merge.
It might help to share that with your subsystem maintainers, so
that they can do the same when merging from their feeders.


