Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbULBSn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbULBSn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbULBSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:43:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:40881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261718AbULBSnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:43:49 -0500
Date: Thu, 2 Dec 2004 10:43:30 -0800
From: cliff white <cliffw@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, jgarzik@pobox.com, torvalds@osdl.org, clameter@sgi.com,
       hugh@veritas.com, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041202104330.4938fb11.cliffw@osdl.org>
In-Reply-To: <179540000.1101972418@[10.10.2.4]>
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
	<20041201230217.1d2071a8.akpm@osdl.org>
	<179540000.1101972418@[10.10.2.4]>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Dec 2004 23:26:59 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> --Andrew Morton <akpm@osdl.org> wrote (on Wednesday, December 01, 2004 23:02:17 -0800):
> 
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> >> 
> >> Andrew Morton wrote:
> >> > We need to be be achieving higher-quality major releases than we did in
> >> > 2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
> >> > stabilisation periods.
> >> 
> >> 
> >> I'm still hoping that distros (like my employer) and orgs like OSDL will 
> >> step up, and hook 2.6.x BK snapshots into daily test harnesses.
> > 
> > I believe that both IBM and OSDL are doing this, or are getting geared up
> > to do this.  With both Linus bk and -mm.
> 
> I already run a bunch of tests on a variety of machines for every new 
> kernel ... but don't have an automated way to compare the results as yet, 
> so don't actually look at them much ;-(. Sometime soon (quite possibly over 
> Christmas) things will calm down enough I'll get a couple of days to write 
> the appropriate perl script, and start publishing stuff.

We've had the most success when one person has an itch to scratch, and works
with us to scratch it. We (OSDL) worked with Sebastien at Bull, and we're very 
glad he had the time to do such excellent work. We worked with Con Kolivas, likewise.

We've done tools to automate LTP comparisons ( bryce@osdl.org  has posted results )
and reaim, we've been able to post some regression to lkml, and tied in with developers
to get bugs fixed. But OSDL has been limited by manpower.
 
One of the issues with the performance tests is the amount of data produced - 
 for example, the deep IO tests produce ton's o'  numbers, but the developer community wants
a single "+/- 5%" type response-  we need some opinions and help on how to do the data reduction 
necessary. 

What would be really kewl is some test/analysis code that could be re-used, so the Martin's of the future
have a good starting place. 
cliffw
OSDL




> 
> > However I have my doubts about how useful it will end up being.  These test
> > suites don't seem to pick up many regressions.  I've challenged Gerrit to
> > go back through a release cycle's bugfixes and work out how many of those
> > bugs would have been detected by the test suite.
> > 
> > My suspicion is that the answer will be "a very small proportion", and that
> > really is the bottom line.
> 
> Yeah, probably. Though the stress tests catch a lot more than the 
> functionality ones. The big pain in the ass is drivers, because I don't
> have a hope in hell of testing more than 1% of them.
> 
> M.
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
