Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTEFQLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTEFQLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:11:04 -0400
Received: from mail2.ewetel.de ([212.6.122.20]:16857 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S263857AbTEFQKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:10:15 -0400
Date: Tue, 6 May 2003 18:22:40 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506152543.GX905@suse.de>
Message-ID: <Pine.LNX.4.44.0305061816490.1310-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

> No, but clearly something is wrong. At least that you should agree on.

Yes, I would guess the MO drive doesn't like most commands that are
used for DVD/CD-ROMs and writers.

> And knowing hardware, there are probably drives out there that just wont
> work because of the various "weird" commands it gets sent.

Okay, I was assuming those errors don't do harm, but that might
be wrong, yeah.

> Just because it happens to work for you doesn't make it a viable
> solution.

Agreed.

> Shouldn't matter, the drive has to check for that particular bit (and it
> obviously does not). Are we still talking 2.5 or 2.4?

2.5
The solution with ide-scsi is good enough for me on 2.4, but since CD
burning also doesn't need ide-scsi any more on 2.5, I'd like to use a
kernel without any SCSI code in it.

> You can play with the c code, you've demonstrated that much so far. So
> play some more, find out which commands are aborted and why. The log
> messages even tell you which ones.

Okay. I'll try to find a way to pass the information that the drive
was originally detected as ide_optical down to ide-cd.c so I can skip
the commands that don't make sense on an MO drive.

> Now find out if these are necessary
> for proper MO functionality or not. Or maybe some vital commands are
> even missing, lots of fun there :). But it really should not be very
> hard.

I'll go play with the code some more, then.

-- 
Ciao,
Pascal

