Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278361AbRJMS4q>; Sat, 13 Oct 2001 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278364AbRJMS4g>; Sat, 13 Oct 2001 14:56:36 -0400
Received: from [212.21.93.146] ([212.21.93.146]:55427 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278361AbRJMS4W>; Sat, 13 Oct 2001 14:56:22 -0400
Date: Sat, 13 Oct 2001 20:54:45 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013205445.A24854@kushida.jlokier.co.uk>
In-Reply-To: <20011013165332.A20499@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Oct 13, 2001 at 10:13:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 13 Oct 2001, Jamie Lokier wrote:
> > I can think of an efficiency-related use for MAP_COPY, and it has
> > nothing to do with shared libraries:
> >
> >  - An editor using mmap() to read a file.
> 
> No, you're thinking the wrong way.
...
> People who think MAP_COPY is a good idea are people who cannot think about
> the implications of it, and cannot think about the alternatives.
:-)
> In particular, you claim that you could use "mmap()" for "read()", and
> speed up the application that way. Ok, fair enough.
> 
> Now, somebody who _isn't_ stupid (and that, of course, is me), immediately
> goes "well, _duh_, why don't you speed up read() instead?".

Thanks Linus.  You are right, speeding up read() is the right thing to do.

In fact it was proposed here on this list years ago, and I think you
argued against it (TLB flush costs).  The costs and kernel
infrastructure have changed and maybe the idea could be revisited now.

Sometimes one has to be an idiot and explore an application of MAP_COPY
to get someone looking at sensible old ideas again :-)

have a nice day,
-- Jamie
