Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbULBS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbULBS2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbULBS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:28:35 -0500
Received: from palrel13.hp.com ([156.153.255.238]:3717 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261286AbULBS2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:28:25 -0500
Date: Thu, 2 Dec 2004 10:27:16 -0800
From: Grant Grundler <iod00d@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, clameter@sgi.com,
       hugh@veritas.com, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041202182716.GE25359@esmail.cup.hp.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201223441.3820fbc0.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 10:34:41PM -0800, Andrew Morton wrote:
> Of course, nobody will test -rc3 and a zillion people will test final
> 2.6.10, which is when we get lots of useful bug reports.  If this keeps on
> happening then we'll need to get more serious about the 2.6.10.n process.
> 
> Or start alternating between stable and flakey releases, so 2.6.11 will be
> a feature release with a 2-month development period and 2.6.12 will be a
> bugfix-only release, with perhaps a 2-week development period, so people
> know that the even-numbered releases are better stabilised.

No matter what scheme you adopt, I (and others) will adapt as well.
When working on a new feature or bug fix, I don't chase -bk releases
since I don't want to find new, unrelated issues that interfere with
the issue I was originally chasing. I roll to a new release when
the issue I care about is "cooked". Anything that takes longer than
a month or so is just hopeless since I fall too far behind.

(e.g. IRQ handling in parisc-linux needs to be completely rewritten
to pickup irq_affinity support - I just don't have enough time to get
it done in < 2 monthes. We started on this last year and gave up.)

I see "2.6.10.n process" as the right way to handle bug fix only releases.
I'm happy to work on 2.6.10.0 and understand the initial release was a
"best effort".

2.6.odd/.even release described above is a variant of 2.6.10.n releases
where n = {0, 1}. The question is how many parallel releases do people
(you and linus) want us keep "alive" at the same time?
odd/even implies only one vs several if 2.6.X.n scheme is continued
beyond 2.6.8.1.

Also need to think about how well any scheme align's with what distro's
need to support releases. Like the "Adopt-a-Highway" program in
California to pickup trash along highways, I'm wondering if distros
would be willing/interested in adopting a particular release
and maintain it in bk.  e.g. SuSE clearly has interest in some sort
of 2.6.5.n series for SLES9. ditto for RHEL4 (but for 2.6.9.n).
The question of *who* (at respective distro) would be the release
maintainer is a titanic sized rathole. But there is a release manager
today at each distro and perhaps it's easier if s/he remains invisible
to us.

hth,
grant
