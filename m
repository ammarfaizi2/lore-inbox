Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWI3Ah5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWI3Ah5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWI3Ah5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:37:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34220 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161048AbWI3Ah4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:37:56 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 28] ipath patches for 2.6.19
References: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Fri, 29 Sep 2006 18:36:25 -0600
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com> (Bryan O'Sullivan's
	message of "Thu, 28 Sep 2006 08:59:56 -0700")
Message-ID: <m1irj6gph2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> writes:

> Hi, Roland -
>
> This patch series brings the ipath driver almost up to date with what's
> in our internal tree.  The only substantial thing missing is the
> memcpy_cachebypass patch that I sent out a while back and haven't had
> time to rework.
>
> These patches have seen a lot of testing, including on a git snapshot
> as of yesterday afternoon.  Please apply.

Have you tested your driver against the -mm tree?

To the best of my knowledge the irq handling of your hypertransport card
is a complete and total hack that works only by chance.

In the -mm tree I have added a first pass at proper support for the
hypertranport interrupt capability.  As this code is slated to go into
2.6.19 could you please test against that?

I would have tested it myself except when I mentioned this earlier I was told
that your card does not actually implement the hypertransport interrupt
capability properly.  

The practical reason for pathscale to work on this is the genirq work
in 2.6.19 changes the internal implementation detail your
hypertransport card has been relying on to work so your hypertranport
card will not work without fixes.

Thanks,
Eric
