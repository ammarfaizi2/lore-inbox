Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311275AbSCLQiS>; Tue, 12 Mar 2002 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311280AbSCLQiJ>; Tue, 12 Mar 2002 11:38:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24073 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311275AbSCLQiD>; Tue, 12 Mar 2002 11:38:03 -0500
Date: Tue, 12 Mar 2002 11:36:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Erik Andersen <andersen@codepoet.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020312044112.GA18857@codepoet.org>
Message-ID: <Pine.LNX.3.96.1020312113327.31421B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Erik Andersen wrote:

> On Mon Mar 11, 2002 at 10:10:36PM -0500, Jeff Garzik wrote:
> > 1) There should be a raw device command interface (not ATA or SCSI specific)
> 
> Hmm.  If such a generic low-level raw device layer were to be
> implemented (presumably as the foundation for the block layer), I
> expect the interface would be somthing like the cdrom layer, and
> would abstract out all the normal things that raw mass-storage
> devices can do.
> 
> But the minute such a layer is in place, people will begin going
> straight to the sub-low-level raw device layers so they can use
> all the exciting new extended features of their XP370000 quantum
> storage array which needs the special frob-electrons command to
> make it work...

Given that this has not happened with sg, nor with people using the
sg+ide-scsi, I think you would have to provide a good reason why this
would happen. The most likely path would be a separate driver or enhanced
IDE driver patch. User programs generally do read, write and seek, not
ioctl level hacking.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

