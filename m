Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTDRNKg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 09:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTDRNKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 09:10:36 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1408 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263033AbTDRNKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 09:10:35 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304181325.h3IDPN2G000129@81-2-122-30.bradfords.org.uk>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: helgehaf@aitel.hist.no (Helge Hafting)
Date: Fri, 18 Apr 2003 14:25:23 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20030418130144.GA14042@hh.idb.hist.no> from "Helge Hafting" at Apr 18, 2003 03:01:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is the basic assumption that lower block numbers are generally located
> > in zones nearer the outside of the disk still true, though?  I.E. do
> > you know of any disks that 'start from the middle'?  I usually
> > recommend that people place their swap and /var partitions near the
> > beginning of the disk, (for a _slight_ improvement), but maybe there
> > is a good reason not to do this for some disks?
> 
> I generally put swap in the middle of the disk, not on the
> "fastest" end.  The "fast" end is faster for large transfers,
> but that isn't what swap is about.

Well, I was thinking of machines that are really starved of physical
RAM, 32 MB or less, even down to 4 MB.  I generally run swapless on
'real' machines :-).

Also, the higher capcity tracks mean less seeks, so the chance of not
having to seek at all increases slightly.

> Swap tends to have lots of small transfers now and then, in between
> other io.  So you want a short seek from wherever the
> access arm is to keep latency down, and the middle of the
> disk has short way both from inner and outer tracks.

Yeah, that would probably be a better idea for machines which are only
really hitting swap on occasions, instead of all the time :-).

John.
