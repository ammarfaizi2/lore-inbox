Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbULLQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbULLQUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbULLQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 11:20:11 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:16771 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262085AbULLQUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 11:20:04 -0500
Date: Sun, 12 Dec 2004 17:19:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Adam Heath <doogie@debian.org>,
       Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041212161950.GA6286@elf.ucw.cz>
References: <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org> <20041210182804.GT8876@waste.org> <20041210212815.GB25409@thunk.org> <20041210222306.GV8876@waste.org> <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com> <20041211173317.GA28382@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211173317.GA28382@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually, I think this is a security issue.  Since any plain old program can
> > read from /dev/urandom at any time, an attacker could attempt to read from
> > that device at the same moment some other program is doing so, and thereby
> > gain some knowledge as to the other program's state.
> 
> It could be a potential exploit, but....
> 
> 	(a) it only applies on SMP machines
> 	(b) it's not a remote exploit; the attacker needs to have
> 		the ability to run arbitrary programs on the local
> 		machine
> 	(c) the attacker won't get all of other programs' reads of
> 		/dev/urandom, and
> 	(d) the attacker would have to have a program continuously
> 		reading from /dev/urandom, which would take up enough
> 		CPU time that it would be rather hard to hide.  
> 
> That's not to say that we shouldn't fix it at our earliest
> convenience, and I'd urge Andrew to push this to Linus for 2.6.10 ---
> but I don't think we need to move heaven and earth to try to
> accelerate the 2.6.10 release process, either.


"Johanka, you really need to generate your own gpg key"

(Starts monitoring johanka by ps -aux, and when time is right,
attempts to read /dev/urandom to get same random seed Johanka got.

And BTW it could be made remote expoit if some application sends data
from urandom to the net. I'd not be surprised if some authentication
program generated challenges from /dev/urandom.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
