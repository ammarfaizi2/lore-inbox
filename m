Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSAMCKX>; Sat, 12 Jan 2002 21:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287945AbSAMCKD>; Sat, 12 Jan 2002 21:10:03 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:47369 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S287940AbSAMCJ4>;
	Sat, 12 Jan 2002 21:09:56 -0500
Date: Sun, 13 Jan 2002 03:10:09 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Erik Andersen <andersen@codepoet.org>,
        Felix von Leitner <felix-dietlibc@fefe.de>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020113021009.GA1682@codeblau.de>
In-Reply-To: <20020112122152.GA24994@codepoet.org> <Pine.GSO.4.21.0201122038480.24774-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0201122038480.24774-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Alexander Viro (viro@math.psu.edu):
> > Lets look at it the other way...  Suppose you start making a
> > separate klibc.  You skip/eliminate a ton of stuff and next week
> > someone complains that it's missing, say, the pivot_root syscall.
> > So you add it.  Then the week after, someone complains that you
> > are missing varargs.  So you add that too.  Pretty soon, someone
> > will complain about how printf feature foo is missing, and they
> > just _need_ SuS2 wordexp compatibility, etc, etc.  Trust me when
> ... at which point you tell them to bugger off.  If they refuse -
> man procmailrc.  Problem solved.

I guess the point here is that you don't save anything over the diet
libc.  I went to great lengths to make sure not using printf would not
incur any overhead.  So if klibc is diet libc without printf, then using
klibc won't produce smaller binaries than using diet libc (unless you
use printf, of course, in which case klibc won't work at all).

By the way: one more architecture is now supported by the diet libc:
hp pa-risc.  Someone surprised me by sending a patch.

Felix
