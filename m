Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUAaVky (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUAaVky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:40:54 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:35489 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265100AbUAaVkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:40:53 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 22:11:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131211109.GC2160@kiste>
References: <20040131104606.GA25534@kiste> <Pine.LNX.4.58.0401311052180.2105@home.osdl.org> <20040131200050.GA2160@kiste> <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds:
> The strace case I'm more than willing to pass off as a strace problem. 
> I find it quite common that strace doesn't detach from processes, leaving 
> some of them in a stopped state. So I assumed that the particular trace 
> wasn't very interesting.
> 
Hmm. "Unfortunately", the test program which bert posted DOES work
correctly under strace.

So there's definitely something fishy going on here.

> The bugs seems to be something totally different: you create a 
> "CLONE_DETACHED" child, and then you expect to be able to wait for it. 

That's not "me", that's "the fork() in the NPTL library".

Besides, bert's test program exhibits exactly the same clone()
arguments, yet it works ...

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
