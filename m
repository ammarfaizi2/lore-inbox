Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSJZKj7>; Sat, 26 Oct 2002 06:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbSJZKj7>; Sat, 26 Oct 2002 06:39:59 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:9487 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262194AbSJZKjz>; Sat, 26 Oct 2002 06:39:55 -0400
Message-ID: <Q2V7OBAeBnu9Ewt1@n-cantrell.demon.co.uk>
Date: Sat, 26 Oct 2002 11:37:18 +0100
To: linux-kernel@vger.kernel.org
From: robert w hall <bobh@n-cantrell.demon.co.uk>
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
 <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
 <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
 <m18z0os1iz.fsf@frodo.biederman.org> <007501c27b37$144cf240$6400a8c0@mikeg>
 <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
 <5.1.0.14.2.20021026073915.00b55008@pop.gmx.net>
 <m1vg3plfi7.fsf@frodo.biederman.org>
In-Reply-To: <m1vg3plfi7.fsf@frodo.biederman.org>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 4.02 U <ZNyPpF8T4habUIG8OkVoLRXKJZ>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m1vg3plfi7.fsf@frodo.biederman.org>, Eric W. Biederman
<ebiederm@xmission.com> writes
>Mike Galbraith <efault@gmx.de> writes:
>
>> At 11:20 PM 10/25/2002 -0600, Eric W. Biederman wrote:
>> >Mike Galbraith <efault@gmx.de> writes:
>> >
>> > > I went back and double-checked my loadlin version, and it turned out I was
>> > > actually using 1.6a due to a fat finger.  Version 1.6c booted fine (only 
>one
>> 
>> > > kernel tested) without Eric's help.  1.6a definitely needs Eric's help to
>> > boot.
>> >
>> >Darn.  I guess the arguments for my patch may not be quite as good,
>> >but I still think it may be worth while.
>> 
>> Well, cleanup is always a pretty fine argument.  Since there only seem to be 
>two
>> 
>> of us loadlin users, you probably didn't loose much argument wise ;-) The 
>other
>> 
>> loadlin user reported failure at .38, so maybe your patch is needed sometimes
>> even with loadlin-1.6c.  (other loadlin user listening?)
>
>Robert thanks for your reply.
(oops this thread is a bit messy now - sorry, I originally intended to
post  off-list, [so as not to parade my ignorance in this august forum
:-) ], and made a cockup of withdrawing a post to LK)
>
>I just looked at what the loadlin 1.6c code does, and it's heuristic
>is just slightly more reliable.  It assumes %ds is %cs+8.... 

well that relationship has held for about 9 years, so it was a fairly
safe bet when Hans was trying to fix 1.6a for win4lin :-)

> That
>happens to work but there is nothing in the kernel keeping that from
>being broken.  So in practice it looks to be worthwhile to stabilize 
>this interface.

agreed - 
/ignorant query/
but if you aim for too much generality are you not eventually going to
need Hans Lermen to revisit his loadlin version of the startup code
(which is based in part on old code from head.S & misc.c of course)?
//
>  So loadlin, and other bootloaders can work by design
>and not by chance.

might also be worth checking out linlod (which still is only a beta I
think) needs to run
>
>Eric
Bob
-- 
robert w hall
