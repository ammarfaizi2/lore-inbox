Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbULBHDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbULBHDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbULBHDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:03:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:17576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261566AbULBHCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:02:55 -0500
Date: Wed, 1 Dec 2004 23:02:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041201230217.1d2071a8.akpm@osdl.org>
In-Reply-To: <41AEBAB9.3050705@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
	<20041201223441.3820fbc0.akpm@osdl.org>
	<41AEBAB9.3050705@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > We need to be be achieving higher-quality major releases than we did in
> > 2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
> > stabilisation periods.
> 
> 
> I'm still hoping that distros (like my employer) and orgs like OSDL will 
> step up, and hook 2.6.x BK snapshots into daily test harnesses.

I believe that both IBM and OSDL are doing this, or are getting geared up
to do this.  With both Linus bk and -mm.

However I have my doubts about how useful it will end up being.  These test
suites don't seem to pick up many regressions.  I've challenged Gerrit to
go back through a release cycle's bugfixes and work out how many of those
bugs would have been detected by the test suite.

My suspicion is that the answer will be "a very small proportion", and that
really is the bottom line.

We simply get far better coverage testing by releasing code, because of all
the wild, whacky and weird things which people do with their computers. 
Bless them.

> Something like John Cherry's reports to lkml on warnings and errors 
> would be darned useful.  His reports are IMO an ideal model:  show 
> day-to-day _changes_ in test results.  Don't just dump a huge list of 
> testsuite results, results which are often clogged with expected 
> failures and testsuite bug noise.
> 

Yes, we need humans between the tests and the developers.  Someone who has
good experience with the tests and who can say "hey, something changed
when I do X".  If nothing changed, we don't hear anything.

It's a developer role, not a testing role.   All testing is, really.
