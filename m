Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272329AbTG3XVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272331AbTG3XVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:21:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8631 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272329AbTG3XVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:21:09 -0400
Date: Thu, 31 Jul 2003 01:20:46 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pavel Machek <pavel@suse.cz>
cc: <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
In-Reply-To: <20030730225500.GC144@elf.ucw.cz>
Message-ID: <Pine.SOL.4.30.0307310058580.17352-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003, Pavel Machek wrote:

> Hi!
>
> > > I had some strange fs corruption, and andi suggested that it probably
> > > is TASKFILE-related. Perhaps this is good idea?
> >
> > Idea is good.
> >
> > Did corruption go away after disabling taskfile?
>
> Not sure, it took week for corruption to creep in, and it might have
> been loop-related or swsusp-related. I'm not at all sure it was
> TASKFILE, but I'm turning it off for now.

I doubt it was taskfile, your /dev/hda is using UDMA so taskfile's impact
is minimal.  I've checked this codepath once again today and can't
see anything which has (possibly) caused Andi's problems.

I think if it is taskfile related it might be caused by some timing issues
(races) and should be visible (less frequently) with non-taskfile code too
and this is not happening.

If you are not sure if it was taskfile why do you want to warn about it?
[ Because Andi is spreading FUD about taskfile? ;-) ]

> At least it is strange to have option that says both "experimental"
> and "it is safe to say Y". What are those "most cases"?

Using (U)DMA should be 100% safe, using single-sector PIO should
also be safe, using multi-sector PIO might be less safe...
--
Bartlomiej

