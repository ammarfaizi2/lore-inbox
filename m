Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUIHXQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUIHXQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269199AbUIHXQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:16:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40077 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269196AbUIHXQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:16:34 -0400
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
From: Lee Revell <rlrevell@joe-job.com>
To: Richard A Nelson <cowboy@debian.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	 <20040908020402.3823a658.akpm@osdl.org>
	 <1094635403.1985.12.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
	 <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
Content-Type: text/plain
Message-Id: <1094685396.1362.245.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 19:16:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 19:07, Richard A Nelson wrote:
> On Wed, 8 Sep 2004, Richard A Nelson wrote:
> 
> > On Wed, 8 Sep 2004, Stephen C. Tweedie wrote:
> >
> > > On Wed, 2004-09-08 at 10:04, Andrew Morton wrote:
> > >
> > > > >   Unable to handle kernel paging request at virtual address 6b6b6b93
> > > > > ...
> > > > >   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
> > > >
> > > > This might have been caused by a fishy latency-reduction patch.  I today
> > > > dropped that patch so could you please test next -mm and let me know?
> > >
> > > That, or preempt.  If the next -mm still breaks, time to hunt for the
> > > preempt problem, I guess.
> >
> > Ok, if it still fails (I'll have to wait until this afternoon for the
> > true test - dpkg breaks it everytime), I'll check out preempt.
> 
> Well, it looks like backing out the patch was sufficient, I've made it
> through the torture that is a dpkg install (70+meg).
> 
> So we needn't (at this time) look to preempt.

Hmm, I have been running this patch for weeks as part of the voluntary
preemption patches, and put it through every torture test I can think
of, with nary an Oops.  None of the other VP testers have reported
problems either.  Maybe this is some interaction between that patch and
something else in -mm.

Lee

