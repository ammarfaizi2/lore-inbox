Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbSKKQ6k>; Mon, 11 Nov 2002 11:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSKKQ6j>; Mon, 11 Nov 2002 11:58:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22290 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265800AbSKKQ6j>; Mon, 11 Nov 2002 11:58:39 -0500
Date: Mon, 11 Nov 2002 12:03:57 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andy Pfiffer <andyp@osdl.org>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: kexec (was: [lkcd-devel] Re: What's left over.)
In-Reply-To: <1036697556.10457.254.camel@andyp>
Message-ID: <Pine.LNX.3.96.1021111115948.18680A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Nov 2002, Andy Pfiffer wrote:

> Just an idea:
> 
> Could a new, unrunnable process be created to "hold" the image?
> 
> <hand-wave>
> Use a hypothetical sys_kexec() to:
> 1. create an empty process.
> 2. copy the kernel image and parameters into the processes' address
> space.
> 3. put the process to sleep.
> </hand-wave>
> 
> If it's floating out there for weeks or years, the data could get paged
> out and not wired down.  It would show up in ps, so you'd have at least
> some visibility into the allocation.

  The only problem is that if you wanted it to run on panic, you really
couldn't trust the burning embers of a dying kernel to pull in the pages
and run them. I'd actually hope the init (and some cleanup??) code would
be there to get the new kernel going. Where kernel could be something
other than another kernel, hopefully.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

