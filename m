Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSGaSy1>; Wed, 31 Jul 2002 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318458AbSGaSy1>; Wed, 31 Jul 2002 14:54:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7950 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318455AbSGaSy1>; Wed, 31 Jul 2002 14:54:27 -0400
Date: Wed, 31 Jul 2002 14:52:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mark Lord <mlord@pobox.com>
cc: Mukesh Rajan <mrajan@ics.uci.edu>, linux-kernel@vger.kernel.org
Subject: Re: IDE, putting HD to sleep causes "lost interrupt"
In-Reply-To: <3D47D59B.6B8CFED7@pobox.com>
Message-ID: <Pine.LNX.3.96.1020731144911.10066F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Mark Lord wrote:

> Well, the answer is very simple, then:  DON'T DO THAT.
> 
> When an ATA (IDE) drive is put to sleep (-Y),
> it *requires* a reset to revive it for any future commands.
> 
> The IDE driver doesn't know about the -Y, so it just attempts
> I/O a few times before digging out the BIG hammer and doing a reset.

Would it be a reasonable thing to include the -Y information in the device
status so that the driver could know a reset was required? Since the
driver sends the command it has the chance to notice there, or might read
a status, or ??? Or is this undesirable for some other reason?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

