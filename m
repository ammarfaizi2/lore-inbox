Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130319AbRACWtt>; Wed, 3 Jan 2001 17:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131854AbRACWt1>; Wed, 3 Jan 2001 17:49:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32134 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131659AbRACWtT>;
	Wed, 3 Jan 2001 17:49:19 -0500
Date: Wed, 3 Jan 2001 17:49:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mark Zealey <mark@itsolve.co.uk>
cc: Dan Hollis <goemon@anime.net>, Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032238540.1139-100000@sunbeam.itsolve.co.uk>
Message-ID: <Pine.GSO.4.21.0101031740340.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Mark Zealey wrote:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> 
> > 
> > 
> > On Wed, 3 Jan 2001, Dan Hollis wrote:
> > 
> > > On Wed, 3 Jan 2001, Alexander Viro wrote:
> > > > On Wed, 3 Jan 2001, Dan Aloni wrote:
> > > > > without breaking anything. It also reports of such calls by using printk.
> > > > Get real.
> > > 
> > > Why do you always have to be insulting alex? Sheesh.
> > 
> > Sigh... Not intended to be an insult. Plain and simple advice. Idea is
> > broken for absolutely obvious reasons (namely, every real-life program
> 
> This doesnt stop syscalls, only syscalls from writable areas.

And? Syscall is a couple of bytes. 0xcd and 0x80. Find one in non-writable
area, put whatever you want into registers and jump to the address where
these two bytes sit. Voila. If all such places are in writable areas -
there you go, the process you've attacked could not perform any
system calls itself.

Come on, folks, you can't be serious - think for a couple of minutes and
you'll come up with a trivial way to work around such protection. In a
dozen bytes or so.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
