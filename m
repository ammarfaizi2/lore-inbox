Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUHBQb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUHBQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUHBQb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:31:58 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61846 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266611AbUHBQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:31:30 -0400
Date: Mon, 2 Aug 2004 18:31:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20040802163113.GR6295@dualathlon.random>
References: <20040801155128.GG6295@dualathlon.random> <200408020317.i723HJbp007491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408020317.i723HJbp007491@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 11:17:19PM -0400, Horst von Brand wrote:
> Andrea Arcangeli <andrea@suse.de> said:
> 
> [...]
> 
> > note this isn't a build number (the features in 2.6.10 don't matter at
> > all, the only thing it matters is that all security bugs up to 3503 are
> > included).
> 
> Pray tell, how do you know if a random "compiler warning fix" isn't a plug
> for an exploitable hole, and if a "security fix" really does fix a real
> security problem that can be abused?
> 
> Truth is, you can never know. So, this degenerates into sequential patch
> numbering, which is completely hopeless.

nothing is perfect. keeping track of a few sporadic kernel builds with
unsafe compiler with `uname -r` is quite easy compared to keeping track
of every security `uname -r` out there. It's about the common case
working well (common case is like fnclex), corner cases will have to be
handled with a db anyways, but it'll be much simpler to single out a few
spoardic `uname -r` than to keep track of everything in the common cases
too.

For example if a new bug triggers only on a certain buggy future cpu, I
don't want to shutdown the whole thing but I'll have a db that will
single out only such specific cpu if the security_sequence is lower than
N.

But anyways I start to think I should probably rename it to
seccomp_security_sequence, so that it's not going to degenerate in the
sequential patch numbering and it'll really work well for the common
case since there's a seccomp relevant bug less than once every 2 years
or less (and half the time they're hardware related and not a software
issues).
