Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTEXOXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTEXOXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:23:40 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:2564 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261328AbTEXOXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:23:38 -0400
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
From: James Bottomley <James.Bottomley@steeleye.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, gibbs@scsiguy.com
In-Reply-To: <20030524064340.GA1451@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave> 
	<20030524064340.GA1451@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 May 2003 10:36:35 -0400
Message-Id: <1053786998.1793.31.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-24 at 02:43, Willy Tarreau wrote:
> > I think there's some misunderstanding about what a release candidate
> > is.  It's an attempt to see if a particular set of code is viable as the
> > released product.  Any bugs reported against a rc that are deemed
> > problems to the release need to be fixed, either by adding a simple and
> > easily verifiable bug fix or by reverting the problem code.
> 
> That's also my point. People were reporting problems till -rc1 which included
> driver version 6.2.28. So Marcelo reverted to 6.2.8 for -rc2 (74500 lines of
> code reverted, not including doc nor aic79xx which was kept). Then, people were
> still reporting problems with -rc2 which they claim are fixed by updating
> to last driver updates, which were 16000 lines forward from -rc1, so less than
> one fourth of what Marcelo accepted to change from -rc1 to -rc2. Although I
> find this big, it's less than the change in fusion/mpt* that has gone from
> -rc2 to -rc3. So I think it's not a matter of size here.

It is a question of size and provenance.  Alan Cox descriped the mpt
fusion update as "assorted small fixes" and deletions exceed additions
in the patch set by 40%.  It's also about user base:  aic7xxx is by far
the most widely used SCSI chip, I'm not sure how many 2.4 fusion users
there are but I speculate its probably orders of magnitude fewer.

> Most of this is a 1 MB Changelog, files going back to their original place
> (Marcelo moved aic79xx to a proper directory to keep it), documentation, and
> initialization code which was exploded in more little functions, then bug fixes.

The argument isn't about size, it's about safety.  No company that wants
to stay in business accepts code into release stabilisation unless it's
clearly justifiable.  Trying to buck the system by including five
features plus one critical bug fix is one of the oldest tricks in the
Software Engineers book---do this and you get hauled before the release
committee whose job will be to pare the addition back to just the bug
fix (and send you away with a flea in your ear to boot).

> I wish Justin would have proposed a little patch to fix only the locking bugs
> in -rc1, but honnestly, why should he fix only these bugs when he knows about
> others that must be fixed too ? I can understand he gives up. -rc is for bug
> fixes, and his bug fixes are reverted !

Marcelo reacted exactly as the release committee would at Adaptec:
either provide the bug fix for assessment or we'll push it out into the
next release.  This is industry standard practice, so I don't see any
problem.

> As I said, I really hope that we'll have a quick 2.4.22 with bug fixes taken
> as a priority. The current pre-releases are as frequent and as big as what
> used to be full releases in the past.

I agree.  One of the necessary things for a fast release is a good
release manager (and thus one prepared to make unpopular decisions--and
ones you don't necessarily agree with).

James


