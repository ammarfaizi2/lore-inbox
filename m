Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVCFUI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVCFUI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 15:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVCFUI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 15:08:57 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:54707 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261487AbVCFUID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 15:08:03 -0500
Date: Sun, 6 Mar 2005 15:10:50 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050306151050.A29509@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <pan.2005.03.06.17.10.41.114607@voxel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon <dilinger@voxel.net> wrote:
> On Sat, 05 Mar 2005 11:43:05 +0100, Andries Brouwer wrote:
> > On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> >>  - It must fix a real bug that bothers people (not a, "This could be a
> >>    problem..." type thing.)
>
> An obvious fix is an obvious fix.  It shouldn't matter whether people have
> triggered a bug or not; why discriminate?

Because the sucker tree is purposely driven by real bug reports, not by
developers who happen across a theoretical problem while traversing the
code. If users aren't hitting it today, the fix can wait for 2.6.n+1.

> >>  - It must fix a problem that causes a build error (but not for things
> >>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
> >>  - No "theoretical race condition" issues, unless an explanation of how
> >>    the race can be exploited.
>
> I disagree w/ this; if it's an obvious fix, there should be no need for
> this.  Either it's a race that is clearly incorrect (after tracing through
> the relevant code), or it's not.

The sucker tree is not a dumping ground for every fix under the sun
(even obvious ones). It's for solving problems hit by real users, right
now.

> >>  - It can not contain any "trivial" fixes in it (spelling changes,
> >>    whitespace cleanups, etc.)
> 
> This and the "it must fix a problem" are basically saying the same
> thing.

No. There's an important distinction and the key word is "contain". This
rule specifically forbids patches that do fix a real problem but _also_
contain unrelated trivial changes. See "setup_per_zone_lowmem_reserve()
oops fix" for an example of a patch that could theoretically be rejected 
due to this rule.

--Adam

