Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVJaUop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVJaUop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVJaUop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:44:45 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:16607 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964828AbVJaUoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:44:44 -0500
Subject: Re: [patch 1/14] s390: statistics infrastructure.
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF9C74DB95.E7B40CED-ONC12570AB.006DF2D4-C12570AB.007844F9@de.ibm.com>
From: Martin Peschke3 <MPESCHKE@de.ibm.com>
Date: Mon, 31 Oct 2005 21:44:39 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 31/10/2005 21:44:42
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> There is a patch in -mm which moves oprofile and kprobes into a new
> "instrumentation" menu.
>
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/broken-out/moving-kprobes-and-oprofile-to-instrumentation-support-menu.patch

>
> I held off on merging that because the oprofile guys asked "why bother".
> I guess the statistics infrastructure answers that question.  I'll send
> it on.

sounds reasonable

> > > (If we end up deciding to keep all this in arch/s390 then I
> > > guess we can live with s390 peculiarities though)
> >
> > I will be happy to see some feature like this included outside
> > arch/s390. What is about lib/, or kernel/?
>
> lib/, I guess.

fine

> It could concievably go in fs/debugfs, depending upon how tightly
> coupled it is to debugfs.

No, I don't think so. debufs has been my choice for the user interface.
But it is only one aspect of the statistics infrastructure, not even the
most important one, in my eyes. It's not an enhancement of debugfs,
but an exploitation. And the statistics code could be changed to use
something else than debugfs with moderate effort.

> > +        list_for_each_entry(seg, &rb->seg_lh, list)
> > +                    break;
...
> Yes, we do poke inside list_head a lot and yes, it does feel a bit wrong.
>
> Do whatever you think is best here.  A little explanatory comment would
> help.

Then I will opt for a comment, rather than touching tested code.

> I noticed that there was a /* in there somewhere where a kerneldoc /**
> was intended.

Looked for it without success.
I am not consistent as to */ or **/ at the end of kerneldoc comments, yet.

THanks for your comments,
Martin Peschke

