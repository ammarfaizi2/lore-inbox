Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUJYSER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUJYSER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbUJYSDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:03:42 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:27038 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261174AbUJYRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:25:18 -0400
Date: Mon, 25 Oct 2004 19:22:31 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joe Perches <joe@perches.com>, Larry McVoy <lm@work.bitmover.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041025172231.GG14325@dualathlon.random>
References: <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <Pine.LNX.4.58.0410250812300.3016@ppc970.osdl.org> <20041025154318.GA14325@dualathlon.random> <Pine.LNX.4.58.0410250904340.3016@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410250904340.3016@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:10:47AM -0700, Linus Torvalds wrote:
> I doubt arch is there today either, but hey, if it displaces CVS, I 
> certainyl won't complain. How are the gcc people doing with it?

gcc people are stuck with CVS AFIK. Apparently CVS is good enough for
them.

arch isn't ready for prime time with the kernel. It would be ready if we
were ok to limit it to say 5000 changesets and to obsolete the older
changesets once in a while. the backend needs a rewrite to handle that.

Thanks to various improvements we did (I only did one that allows
caching with hardlinked trees, Chris and others did more), probably arch
would be already way faster than BK in a daily checkout checkin and
cloning (nobody on the open source side can verify since we cannot use
BK, AFIK Miles tried to buy a copy of BK but Larry refused to sell it,
but I seriously doubt BK has such an advanced hardlinking cache
mechanism like arch), but the very first setup on a new machine would be
very inefficient (if compared to CVS) and the local copy of the
repository would take more space (again if compared to CVS).

The user interface isn't nice either, it'd be nicer at least to avoid
overlaps between commands.

I believe this all can be fixed, it just needs a critical mass of users
and some big initial pain.
