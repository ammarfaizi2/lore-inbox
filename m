Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269200AbUIHX46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbUIHX46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbUIHX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:56:58 -0400
Received: from netblock-66-159-231-38.dslextreme.com ([66.159.231.38]:21425
	"EHLO mail.cavein.org") by vger.kernel.org with ESMTP
	id S269200AbUIHXxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:53:11 -0400
Date: Wed, 8 Sep 2004 16:51:35 -0700 (PDT)
From: Richard A Nelson <cowboy@debian.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
In-Reply-To: <1094685396.1362.245.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
  <20040908020402.3823a658.akpm@osdl.org>  <1094635403.1985.12.camel@sisko.scot.redhat.com>
  <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet> 
 <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
 <1094685396.1362.245.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Lee Revell wrote:

> On Wed, 2004-09-08 at 19:07, Richard A Nelson wrote:
> > On Wed, 8 Sep 2004, Richard A Nelson wrote:
> >
> > > On Wed, 8 Sep 2004, Stephen C. Tweedie wrote:
> > >
> > > > On Wed, 2004-09-08 at 10:04, Andrew Morton wrote:
> > > >
> > > > > >   Unable to handle kernel paging request at virtual address 6b6b6b93
> > > > > > ...
> > > > > >   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
> > > > >
> > > > > This might have been caused by a fishy latency-reduction patch.  I today
> > > > > dropped that patch so could you please test next -mm and let me know?
> > > >
> > > > That, or preempt.  If the next -mm still breaks, time to hunt for the
> > > > preempt problem, I guess.
> > >
> > > Ok, if it still fails (I'll have to wait until this afternoon for the
> > > true test - dpkg breaks it everytime), I'll check out preempt.
> >
> > Well, it looks like backing out the patch was sufficient, I've made it
> > through the torture that is a dpkg install (70+meg).
> >
> > So we needn't (at this time) look to preempt.
>
> Hmm, I have been running this patch for weeks as part of the voluntary
> preemption patches, and put it through every torture test I can think
> of, with nary an Oops.  None of the other VP testers have reported
> problems either.  Maybe this is some interaction between that patch and
> something else in -mm.

Interestingly, I notice Zwane had a very similiar oops, posted on the
7th: Oops in __journal_clean_checkpoint_list
He also had preempt enabled...

I've found upgrading my Debian system using dselect to be a *very* good
stress test of the filesystem...

If you have candidates, I'll try to test them - I've typically had no
problem reproducing the issue :)

-- 
Rick Nelson
 * Equivalent code is available from RSA Data Security, Inc.
 * This code has been tested against that, and is equivalent,
 * except that you don't need to include two pages of legalese
 * with every copy.
        -- public domain MD5 source
