Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbTIPA3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTIPA3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:29:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20240 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261690AbTIPA3W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:29:22 -0400
Date: Mon, 15 Sep 2003 20:20:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: richard.brunner@amd.com
cc: alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <99F2150714F93F448942F9A9F112634C0638B1E3@txexmtae.amd.com>
Message-ID: <Pine.LNX.3.96.1030915200107.22907A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 richard.brunner@amd.com wrote:

> My concern is trying to prevent 
> the flood of emails where someone thinks they built 
> a "standard" kernel only to  discover that they forgot 
> to select the various suboptions
> and it doesn't work on their processor. I'd like
> to simplfy what the majority of folks need to do
> to get a broadly working kernel.
> 
> I'd prefer that some set of options "take away"
> rather than "add" features/work-arounds. In the case below,
> I'd prefer a "don't support Athlon Prefetch Errata".

If that's what it takes I could be content to add it to the "delete
features" menu, or whatever it's called. It certainly could be on by
default if it were up in the features with F.P. emulation. As long as
non-Athlon users can make it go away with config, it's a useful solution.

But I really like having a single option which builds ONLY support for the
target CPU, with no other support which can be removed. And I'm sure the
embedded folks would help identify sections to be covered by that
definition.

> 
> I think you can argue that some features are going to 
> be common enough for the majority of users that they
> should be in the "take-away" category.
> 
> Others are uncommon enough that they fall into
> the "add" category.

I doubt anyone would disagree with that, until you start deciding which
falls where. If F.P. emulation and SMP can go in the features menu I would
think "use prefetch if available" could as well, but if it would bring
concensus to this discussion I would support putting prefetch fixup on the
takeaway menu. It solves what I see as a size problem for the future, and
continues to address the and that's valuable. Now if a few other people can agree...
> 
> If you stick with consistent nomenclature 
> (e.g. add_feature_TBD & sub_default_feature_TBD) 
> and put these options in one common config file, 
> I think the embedded folks and the 
> "optimize every last bit" folks get 
> what they want.

I think in the long run there are too many tiny features to justify a
config option for each. I would hope people would like the idea of having
a single flag (not to replace individual options) to drop support for
every architecture but the stated target. It need not do much initially,
but would be a good hook so when someone identifies code like that there's
a simple flag to use.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

