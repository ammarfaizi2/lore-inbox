Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160159AbQGaWUp>; Mon, 31 Jul 2000 18:20:45 -0400
Received: by vger.rutgers.edu id <S160115AbQGaWTf>; Mon, 31 Jul 2000 18:19:35 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:1488 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160159AbQGaWSw>; Mon, 31 Jul 2000 18:18:52 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 31 Jul 2000 22:39:15 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m4v6j$dkn$1@enterprise.cistron.net>
References: <8m4q9v$871$1@enterprise.cistron.net> <Pine.LNX.3.95.1000731173215.4111A-100000@chaos.analogic.com>
X-Trace: enterprise.cistron.net 965083155 13975 195.64.65.200 (31 Jul 2000 22:39:15 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >Pine.LNX.3.95.1000731173215.4111A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>On 31 Jul 2000, Miquel van Smoorenburg wrote:
>> No. Even Linus himself has been saying for years (and recently even
>> in this thread) that /usr/include/linux and /usr/include/asm should
>> NOT EVER be symlinks to /usr/src/linux
>
>I don't think Linus said that at all.

That is the problem. Linus has been saying that for years, but
as I said, for some reason people refuse to listen. You're proving
my point.

>In fact, the first trees that
>Linus made and distributed were done this way and have become the
>de-facto standard as a result of this.

Read <8lop07$2ee$1@penguin.transmeta.com> in which Linus says:

  >/usr/include/asm is a symlink to /usr/src/linux/include/asm, as in the
  >original distribution but /usr/src/linux is a 2.4.0-testX tree.
  >With a 2.2.X source tree, it does not produce any warning.
  
  I've asked glibc maintainers to stop the symlink insanity for the last
  few years now, but it doesn't seem to happen.
  
  Basically, that symlink should not be a symlink.  It's a symlink for
  historical reasons, none of them very good any more (and haven't been
  for a long time), and it's a disaster unless you want to be a C library
  developer.  Which not very many people want to be. 
  
  The fact is, that the header files should match the library you link
  against, not the kernel you run on. 

Also read <Pine.LNX.4.10.10007270728480.2768-100000@penguin.transmeta.com>
for more enlightenment. If you want to join a thread, please make sure
that you have read all messages in it.

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
