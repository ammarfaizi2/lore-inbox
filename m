Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVBRMvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVBRMvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 07:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRMvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 07:51:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52594
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261352AbVBRMvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 07:51:00 -0500
Date: Fri, 18 Feb 2005 13:50:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>
Cc: Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050218125057.GE2071@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random> <845b6e8705021803533ba8cc34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <845b6e8705021803533ba8cc34@mail.gmail.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 12:53:09PM +0100, Erik Bågfors wrote:
> RCS/SCCS format doesn't make much sence for a changeset oriented SCM.

The advantage it will provide is that it'll be compact and a backup will
compress at best too. Small compressed tarballs compress very badly
instead, it wouldn't be even comparable. Once the thing is very compact
it has a better chance to fit in cache, and if it fits in cache
extracting diffs from each file will be very fast. Once it'll be compact
the cost of a changeset will be diminished allowing it to scale better
too.

Now it's true new disks are bigger, but they're not much faster, so if
the size of the repository is much larger, it'll be much slower to
checkout if it doesn't fit in cache. And if it's smaller it has better
chances of fitting in cache too.

The thing is, RCS seems a space efficient format for storing patches,
and it's efficient at extracting them too (plus it's textual so it's not
going to get lost info even if something goes wrong).

The whole linux-2.5 CVS is 500M uncompressed and 75M tar.bz2 compressed.

My suggestion is to convert _all_ dozen thousand changesets to arch or
SVN and then compare the size with CVS (also the compressed size is
interesting for backups IMHO). Unfortunately I know nothing about darcs
yet (except it eats quite some memory ;)
