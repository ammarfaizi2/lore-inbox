Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUHaVRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUHaVRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUHaVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:15:31 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:65479 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S269227AbUHaVNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:13:35 -0400
Date: Tue, 31 Aug 2004 23:13:31 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Vier <tmv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040831211331.GA27746@janus>
References: <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <1093949876.32682.1.camel@localhost.localdomain> <Pine.LNX.4.58.0408311006340.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311006340.2295@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 10:15:25AM -0700, Linus Torvalds wrote:
> 
> Admins absolutely _hate_ that. They will ban an OS if it sends out packets
> that cause troublem. You should remember that - we used to do strange
> things on the net (long long time ago), and we brought down servers by
> mistake, and nobody ever considered it a server bug: it was a Linux bug
> that it wouldn't do the right thing.
> 
> Things like not sending FIN-packets when a program suddenly goes away is 
> NOT acceptable behaviour! Neither is it acceptable behaviour to allow user 
> programs to make up their own packets.

The user/kernel distinction is not always (heck, maybe almost never)
present in the embedded world (a large world). The notion of a "regular
user" does not apply at all in such a case. This is not a bug but merely
the state of technology. It will slowly go away I think because embedded
software becomes more complex and hardware becomes cheaper.

To implement multiple TCP clients _and_ the TCP/IP stack in one space is
perfectly possible and it's actually done in practice. It has advantages
(speed, when done properly) and disadvantages (complexity/bug-prone).

> 
> NOTE! This is totally ignoring the fact that you can't be called "UNIX" 
> any more. You _need_ to have sequence numbers etc be shared between 
> multiple programs that all write to the stream. Again, that _does_ mean 
> that you have another protection domain (aka "kernel" or "TCP deamon") 
> that keeps track of the sequence number. 

There is nothing in the networking or UNIX standards that prescibe another
protection domain for this. Would be insane to leave that out in a hosted
environment but it _can_ be done without.

-- 
Frank
