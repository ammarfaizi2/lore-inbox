Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSG3QpA>; Tue, 30 Jul 2002 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318350AbSG3QpA>; Tue, 30 Jul 2002 12:45:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4950 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318344AbSG3Qo7>; Tue, 30 Jul 2002 12:44:59 -0400
Date: Tue, 30 Jul 2002 18:49:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730164935.GI1181@dualathlon.random>
References: <20020730054111.GA1159@dualathlon.random> <Pine.LNX.4.44.0207300633140.2599-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207300633140.2599-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 06:34:53AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
> >
> > this patch against 2.5.29 adds the async-io API as from latest Ben's
> > patch.
> 
> Why not make the io_submit system call number 251 like it apparently is
> already in 2.4.x? We're really close to it anyway, so if you just re-order
> the system calls a bit (and leave 250 as sys_ni_syscall), you're basically
> there.
> 
> Other than that it looks good.

thank you very much for checking it. Since Ben asked for waiting his
patch you can reject may patch, that's really fine with me as far as it
doesn't take months for his patch to showup. my patch is in perfect sync
with his latest code on the web.

as said I never claimed current API is stupid as Christph understood, I
said I'd preferred a sys_aio_read/write/fsync etc... but I could live
fine with sys_io_submit too, it wasn't too bad enough to make me rewrite
it.

With my patch I mainly wanted to raise eyes on this issue so we can
hopefully get an API registered in a few weeks in mainline. I'm
completely flexbile to rewrite the API too if anybody find good reasons
for it (or if you say, sys_io_submit is too ugly please change to
sys_aio_read/write/etc..).

As Ben said the API is the only thing that is been mostly stable so far,
this is one more reason I felt this is the right way to proceed instead
of building the dynamic syscall slowdown overhead layer that as best
(unsure for sys_io_sumbit 250) is forward binary compatible with 2.5 by
pure luck.

thanks,

Andrea
