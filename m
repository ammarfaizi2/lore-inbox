Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311281AbSCLQmI>; Tue, 12 Mar 2002 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311282AbSCLQl6>; Tue, 12 Mar 2002 11:41:58 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24585 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311281AbSCLQl4>; Tue, 12 Mar 2002 11:41:56 -0500
Date: Tue, 12 Mar 2002 11:40:06 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D4D12.90606@mandrakesoft.com>
Message-ID: <Pine.LNX.3.96.1020312113712.31421C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Jeff Garzik wrote:

> And IMO, we should have some basic validation of taskfile requests in 
> the kernel...
> Reason 1: Standard kernel convention.  In other ioctls, we check basic 
> arguments and return EINVAL when they are wrong, even for privieleged 
> ioctls.

If we assume that this path is for commands the kernel doesn't understand,
how do we validate them?

> Reason 2: If you have multiple programs issuing ATA commands, you would 
> want a decent amount of synchronization, provided by the kernel, for the 
> multiple user processes and multiple kernel processes issuing requests. 
>  Having the userspace commands come down a single spot in the kernel 
> code makes this job a lot easier, if not making the impossible possible :)

Linus addressed this, I agree with his proposed three part implementation.
AFAIK he said the same thing in a different way.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

