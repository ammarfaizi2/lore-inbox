Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUHQU0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUHQU0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268419AbUHQUZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:25:53 -0400
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:21213 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S268416AbUHQUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:24:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
	<m37jrxk024.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 17 Aug 2004 22:24:43 +0200
In-Reply-To: <m37jrxk024.fsf@telia.com>
Message-ID: <m33c2ljywk.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Frediano Ziglio <freddyz77@tin.it> writes:
> 
> > Il lun, 2004-08-16 alle 21:09, Peter Osterlund ha scritto:
> > ...
> > > 
> > > The second problem is in the dvdrw-support patch in the -mm kernel.
> > > (This patch is also included in the patch you are using.)
> > > 
> > > The problem is that some drives fail the "GET CONFIGURATION" command
> > > when asked to only return 8 bytes. This happens for example on my
> > > drive, which is identified as:
> > > 
> > >         hdc: HL-DT-ST DVD+RW GCA-4040N, ATAPI CD/DVD-ROM drive
> > > 
> > > Since the cdrom_mmc3_profile() function already allocates 32 bytes for
> > > the reply buffer, this patch is enough to make the command succeed on
> > > my drive.
> > > 
> > 
> > I'm forgetting... 
> > 
> > mounting devices it reports that disk was CD-RW and speed was 15
> > (DVD-RW) and 31 (DVD+RW).
> 
> That shouldn't cause any real problems, but since it's quite
> confusing, here is a patch to fix it.  With this change, both DVD+RW
> and DVD-RW media is correctly identified in the kernel log, and DVD
> speeds are printed in kB/s.

I forgot to say:

Signed-off-by: Peter Osterlund <petero2@telia.com>

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
