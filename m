Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275092AbTHRVSQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275102AbTHRVSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:18:16 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:59922 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S275092AbTHRVSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:18:14 -0400
Date: Mon, 18 Aug 2003 17:18:09 -0400 (EDT)
From: Hank Leininger <hlein@progressive-comp.com>
X-X-Sender: Hank Leininger <hlein@progressive-comp.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
In-Reply-To: <20030818210238.GG10320@matchmail.com>
Message-ID: <010308181705350.18362-100000@timmy.spinoli.org>
X-Marks-The: Spot
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 18 Aug 2003, Mike Fedyk wrote:

> On Mon, Aug 18, 2003 at 04:50:49PM -0400, Hank Leininger wrote:
> > ..So not *all* such cases are cause for alarm.  However, if you run one of
> > the patches enabling logging of this, you quickly learn what's normal for
> > the apps you run, and can teach your log-auditing tools and/or your brain
> > to ignore them.
>
> And why not just catch the ones sent from the kernel?  That's the one that
> is killing the program because it crashed,

Well, in my case at least, because if a network-listening daemon fell
over with sigsegv, sigill, etc I most definitely wanted to know about
it.  But, you certainly could make a patch to do only that; it'd be
lower impact, less contraversial but probably still not accepted into
mainline (just a guess).

> and that's the one the origional poster wants logged...

Hm, I see Thar Filipau bringing that up specifically, and it does seem
like something that ought to generate some logs.  (But I thought they
should already generate oops's?  Apparently not.)  The OP seemed to be
concerned with any SIGSEGV and SIGILL signals, not just in-kernel ones?

Hank Leininger <hlein@progressive-comp.com>
E407 AEF4 761E D39C D401  D4F4 22F8 EF11 861A A6F1
-----BEGIN PGP SIGNATURE-----

iD8DBQE/QUKRIvjvEYYapvERAn28AJ9ELPYOXKOfcIjvzV88BRzOfde1mACfRbOx
zngdpycDsO4FZgcrilGRMQU=
=X+3w
-----END PGP SIGNATURE-----

