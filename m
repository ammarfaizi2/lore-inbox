Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWCVAeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWCVAeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWCVAeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:34:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751875AbWCVAeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:34:13 -0500
Date: Tue, 21 Mar 2006 16:33:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Barkalow <barkalow@iabervon.org>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <Pine.LNX.4.64.0603211829430.6773@iabervon.org>
Message-ID: <Pine.LNX.4.64.0603211630140.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org> 
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>  <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
  <1142962995.4749.39.camel@praia>  <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
  <1142965478.4749.58.camel@praia>  <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
 <1142968537.4749.96.camel@praia> <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
 <Pine.LNX.4.64.0603211829430.6773@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Daniel Barkalow wrote:
> 
> Isn't this what you'd get if you accidentally removed .git/MERGE_HEAD 
> while trying to resolve a merge, and then absent-mindedly described what 
> you'd done in the commit message (forgetting that it ought to have 
> generated the commit message for you in this situation)?

Yes, exactly. But the point is, that if anybody does something like that, 
they should be
 (a) shot
 (b) told that they should never ever do that again

(Not necessarily in that order).

The thing is, the above workflow generates a _buggy_ repository. It will 
be entirely "correct" in the sense that it passes all git self-consistency 
checks, but it's not really any different from doing

	dd if=/dev/urandom of=Makefile count=2
	git commit Makefile

and then asking me to pull from the result. 

> I expect the source of the bad commit is losing that, although I don't 
> know any obvious way to lose it (and still have the index contents which 
> you're merging).

Something like "git reset HEAD" + "git commit" might do it.

		Linus
