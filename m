Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281412AbRKEWrc>; Mon, 5 Nov 2001 17:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281409AbRKEWrM>; Mon, 5 Nov 2001 17:47:12 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:7688 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281411AbRKEWrB>;
	Mon, 5 Nov 2001 17:47:01 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111052246.fA5MkxG288247@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 5 Nov 2001 17:46:59 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011105102724Z16315-18972+86@humbolt.nl.linux.org> from "Daniel Phillips" at Nov 05, 2001 11:28:27 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

> I've done quite a bit more kernel profiling and I've found that
> overhead for converting numbers to ascii for transport to proc is
> significant, and there are other overheads as well, such as the
> sprintf and proc file open.  These must be matched by corresponding
> overhead on the user space side, which I have not profiled.  I'll
> take some time and present these numbers properly at some point.

You said "top -d .1" was 18%, with 11% user, and konsole at 9%.
So that gives:

9% konsole
7% kernel
2% top
0% X server ????

If konsole is well-written, that 9% should drop greatly as konsole
falls behind on a busy system. For example, when scrolling rapidly
it might skip whole screenfuls of data. Hopefully those characters
are rendered in a reasonably efficient way.
