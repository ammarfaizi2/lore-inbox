Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUDEVOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUDEVOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:14:00 -0400
Received: from mail.shareable.org ([81.29.64.88]:8600 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263228AbUDEVMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:12:51 -0400
Date: Mon, 5 Apr 2004 22:12:36 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, bero@arklinux.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching SIGSEGV with signal() in 2.6
Message-ID: <20040405211236.GD21649@mail.shareable.org>
References: <Pine.LNX.4.58.0404050824310.13367@build.arklinux.oregonstate.edu> <20040405181707.GA21245@mail.shareable.org> <4071B093.9030601@nortelnetworks.com> <20040405204028.GA21649@mail.shareable.org> <Pine.LNX.4.53.0404051644440.2948@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404051644440.2948@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Are you using a longjump to get out of the signal handler?
> You may find that you can trap SIGSEGV, but you can't exit
> from it because it will return to the instruction that
> caused the trap!!!

Thanks for stating the obvious! :)

No, actually I'm changing memory protection with mprotect() inside the
handler, so when it returns the program can continue.

But that's not relevant to the OpenOffice problem.  They have a
program which traps SIGSEGV with 2.4 and terminates suddenly with 2.6.
Obviously they aren't just returning else it wouldn't work with 2.4.

-- Jamie
