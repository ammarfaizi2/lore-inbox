Return-Path: <linux-kernel-owner+w=401wt.eu-S1751093AbXAQWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAQWJ5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXAQWJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:09:57 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50829 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXAQWJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:09:56 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 17:04:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Valdis.Kletnieks@vt.edu
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
In-Reply-To: <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0701171654480.4298@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
 <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_EV 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Valdis.Kletnieks@vt.edu wrote:

> On Wed, 17 Jan 2007 11:51:27 EST, "Robert P. J. Day" said:
> >
> >   in any event, what about introducing a new config variable,
> > OBSOLETE, under "Code maturity level options"?  this would seem to be
> > a quick and dirty way to prune anything that is *supposed* to be
> > obsolete from the build, to make sure you're not picking up dead code
> > by accident.
> >
> >   i think it would be useful to be able to make that kind of
> > distinction since, as the devfs writer pointed out above, the point of
> > labelling something "obsolete" is not to *discourage* someone from
> > using a feature, it's to imply that they *shouldn't* be using that
> > feature.  period.  which suggests there should be an easy, one-step
> > way to enforce that absolutely in a build.
>
> How much of the 'OBSOLETE' code should just be labelled 'BROKEN'
> instead?

the stuff that's actually "broken."  :-)

OBSOLETE is not (or at least *should not* be) equivalent to BROKEN.
"OBSOLETE" should denote code that, while it is no longer supported
and has a viable replacement, may very well still work.  and it may or
may not be slated for removal some day.  there may very well be
reasons to keep "obsolete" code in the kernel, for occasional backward
compatibility, but marking it as "obsolete" is a powerful indicator
that people should *really* try not to use it.

"BROKEN" code, OTOH, really should mean exactly that -- code that is
*known* to be broken.  that would include old code that has suffered
bit rot, but it might also include *new* code that, while it's now
part of the kernel, someone discovers a major flaw in it and no one's
got around to fixing it yet.  so even bleeding-edge code can
technically be "broken" until someone gets around to debugging it.

thoughts?

rday


