Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULBH1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULBH1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 02:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbULBH1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 02:27:32 -0500
Received: from jade.aracnet.com ([216.99.193.136]:17335 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261151AbULBH1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 02:27:25 -0500
Date: Wed, 01 Dec 2004 23:26:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc: torvalds@osdl.org, clameter@sgi.com, hugh@veritas.com,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <179540000.1101972418@[10.10.2.4]>
In-Reply-To: <20041201230217.1d2071a8.akpm@osdl.org>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org><Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org><Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com><Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org><41AEB44D.2040805@pobox.com><20041201223441.3820fbc0.akpm@osdl.org><41AEBAB9.3050705@pobox.com> <20041201230217.1d2071a8.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Wednesday, December 01, 2004 23:02:17 -0800):

> Jeff Garzik <jgarzik@pobox.com> wrote:
>> 
>> Andrew Morton wrote:
>> > We need to be be achieving higher-quality major releases than we did in
>> > 2.6.8 and 2.6.9.  Really the only tool we have to ensure this is longer
>> > stabilisation periods.
>> 
>> 
>> I'm still hoping that distros (like my employer) and orgs like OSDL will 
>> step up, and hook 2.6.x BK snapshots into daily test harnesses.
> 
> I believe that both IBM and OSDL are doing this, or are getting geared up
> to do this.  With both Linus bk and -mm.

I already run a bunch of tests on a variety of machines for every new 
kernel ... but don't have an automated way to compare the results as yet, 
so don't actually look at them much ;-(. Sometime soon (quite possibly over 
Christmas) things will calm down enough I'll get a couple of days to write 
the appropriate perl script, and start publishing stuff.

> However I have my doubts about how useful it will end up being.  These test
> suites don't seem to pick up many regressions.  I've challenged Gerrit to
> go back through a release cycle's bugfixes and work out how many of those
> bugs would have been detected by the test suite.
> 
> My suspicion is that the answer will be "a very small proportion", and that
> really is the bottom line.

Yeah, probably. Though the stress tests catch a lot more than the 
functionality ones. The big pain in the ass is drivers, because I don't
have a hope in hell of testing more than 1% of them.

M.
