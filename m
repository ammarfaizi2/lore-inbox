Return-Path: <linux-kernel-owner+w=401wt.eu-S1761701AbWLIOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761701AbWLIOEX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761702AbWLIOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:04:23 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:42196 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761700AbWLIOEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:04:22 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 09:00:33 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to
 kcalloc().
In-Reply-To: <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain>
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
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

On Sat, 9 Dec 2006, Pekka Enberg wrote:

> On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> > @@ -705,7 +705,7 @@ static int uss720_probe(struct usb_inter
> >         /*
> >          * Allocate parport interface
> >          */
> > -       if (!(priv = kcalloc(sizeof(struct parport_uss720_private), 1,
> > GFP_KERNEL))) {
> > +       if (!(priv = kcalloc(1, sizeof(struct parport_uss720_private),
> > GFP_KERNEL))) {
>
> This one should be kzalloc
>
> You really ought to send these cleanups to akpm@osdl.org with LKML
> cc'd to get them merged.

good point, and argh.  good point in that any further patches that are
primarily stylistic and/or aesthetic like the above will be sent to
akpm, and CC'ed to list.

argh, in that i've already mentioned that, following the guidelines in
"SubmittingPatches", i prefer that each of my patches have one logical
purpose.  once the order of the kcalloc() args is corrected, that
would be followed by a single subsequent patch that did the
kcalloc->kzalloc transformation all at once.

if that's *not* the way folks on this list wish to see patches, then
that advice should be removed from "SubmittingPatches."

as captain hollister once said to dave lister, "choose."

rday
