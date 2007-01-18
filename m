Return-Path: <linux-kernel-owner+w=401wt.eu-S1751452AbXARKn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXARKn4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXARKn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:43:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:57744 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbXARKnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:43:55 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 05:38:14 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Introduce two new maturlty levels:  DEPRECATED and
 OBSOLETE.
In-Reply-To: <Pine.LNX.4.61.0701181116250.19740@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0701180532070.8331@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
 <45AE9B85.7090608@zytor.com> <Pine.LNX.4.64.0701171706330.4353@CPE00045a9c397f-CM001225dbafb6>
 <Pine.LNX.4.61.0701181116250.19740@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Jan Engelhardt wrote:

>
> >On Wed, 17 Jan 2007, H. Peter Anvin wrote:
> >
> >> DEPRECATED should presumably default to Y; OBSOLETE to n.
> >
> >crap, now i see what you were getting at -- i forgot to assign
> >defaults.  i'll resubmit, but i'll wait for anyone to suggest any
> >better help content if they have a better idea.
>
> Well... _maybe_ documentation/scheduled-removal.txt (or whatever it
> is called) could now be merged into the kconfig options and help
> text. Or maybe not, to keep it easy to track deprecated code.
>
> Well, even if scheduled-removal.txt stays, you could submit a 2nd
> patch putting OBSOLETE and DEPRECATED tags to the Kconfig options
> listed in scheduled-removal.txt, so that kconfig+sched are in sync.

i'm assuming you mean "Documentation/feature-removal-schedule.txt".
that would *seem* to make sense, after only a few seconds of thought.
once config options are tagged with either DEPRECATED or OBSOLETE,
surely it wouldn't be hard to be able to pull out a list of those from
the source tree, based on their Kconfig dependencies.

but, again, that's getting ahead of ourselves.  certainly, it's
something that *could* be done at some point, but not knowing exactly
how one would do that doesn't stop anyone from adding those two config
settings *now*, just to get the process rolling.

let's not over-analyze this too much.

rday

p.s.  it might be worth perusing the feature removal file, to see what
features are still listed there even though they were scheduled to be
removed some time ago.  just a thought.
