Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSEYSjh>; Sat, 25 May 2002 14:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEYSjh>; Sat, 25 May 2002 14:39:37 -0400
Received: from mark.mielke.cc ([216.209.85.42]:45573 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S315207AbSEYSjf>;
	Sat, 25 May 2002 14:39:35 -0400
Date: Sat, 25 May 2002 14:33:58 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Karim Yaghmour <karim@opersys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020525143358.A4481@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com> <3CEFD65A.ED871095@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 02:22:18PM -0400, Karim Yaghmour wrote:
> Linus Torvalds wrote:
> >  - I think the microkernel approach is fundamentally broken. Karim claims
> >    there is no priority inversion, but he must have his blinders on. Every
> >    single spinlock in the kernel assumes that the kernel isn't preempted,
> >    which means that user apps that can preempt the kernel cannot use them.
> Blinders ehh... Well, if you would care to ask I would answer.
> In reality, what you point out is actually a non-issue since the hard-rt
> user-land tasks are not allowed to call on normal Linux services. They
> can only call on RTAI services which are exported by an extra soft-int.
> These services are hard-rt, so there's no problem there.
> Please, download the thing and play with it. Or, at the very least, ask
> about how it works and we'll be glad to explain.

None of which proves that it is the right way to do things.

>From what I understand, Linux _is_ being considered for RT applications
by quite a few heavy-weights in the field including IBM, Intel and
quite a few others. The patent issue that you present does not seem to be
discouraging them in any way.

My limited observations suggest that the primary reasons people do not
use Linux for their RT applications are:

    1) They don't trust it for 'high availability'.

    2) They already have their application mostly written, or
       completely written, for some other RT operating system, and
       it would cost too much to switch.

Issues such as patents are quite common place and extremely regular
for any serious company that produces RT applications. They *expect*
to have to pay for a good operating system. In fact, if they didn't
have to pay, they become suspicious, usually with good reason.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

