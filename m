Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUFFUqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUFFUqm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFFUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:46:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40084 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264131AbUFFUqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:46:40 -0400
Date: Sun, 6 Jun 2004 22:46:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040606204606.GC20267@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de> <200406041534.48688.bzolnier@elka.pw.edu.pl> <20040604152347.GD1946@suse.de> <40C0B191.2040201@pobox.com> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606161827.GC28576@bounceswoosh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2004, Eric D. Mudama wrote:
> On Sat, Jun  5 at 11:24, Jens Axboe wrote:
> >I did suggest this a few years ago. The comment I received was that
> >they didn't take suggestions from OS people, if I didn't have a drive
> >implementation to go with the proposal they couldn't use it for
> >anything. Which was interesting, since that seemed to suggest that t13
> >had little steering in ata development, they mainly put into the ATA
> >specs what drive manufacturers shoved at them. Of course this isn't 100%
> >true, but it does explain a lot of things :-)
> 
> If it helps, I'm listening.
> 
> Suggestions/proposals for new features etc, if they're a good idea, I
> can help push inside via our SATA/T13 reps.  Note that as per all
> long-lived specs with multiple revisions, changing the behavior of an
> existing feature to something incompatible is virtually never
> feasable.

Of course not, you cannot change the way the command works now. This was
at the time when the proposal was being added, however.

There are still the feature register which is reserved for write fua,
that could be used. For some odd reason t13 prefers to add seperate
opcode for the identical command, instead of just using option bits. But
you could just flag an ordered bit for WRITE_DMA_EXT_FUA, that would
work wonders.

> >Andre even tried getting FUA to do what we needed, no such luck there.
> >Some other bigger OS wanted it differently, the rest is history.
> 
> Lo siento, I wasn't around when that occurred.  Of course, that other
> bigger OS has a very large installed base, and selling a drive that
> breaks it is corporate suicide.

I don't think anyone in their right mind would expect that. Of course in
10 years time we can all laugh at this when the tables have turned :-)

-- 
Jens Axboe

