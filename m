Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266106AbRF2PkA>; Fri, 29 Jun 2001 11:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266104AbRF2Pju>; Fri, 29 Jun 2001 11:39:50 -0400
Received: from dsl-64-128-37-73.telocity.com ([64.128.37.73]:56327 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S265997AbRF2Pjl>; Fri, 29 Jun 2001 11:39:41 -0400
Message-Id: <4.3.2.7.2.20010629112805.00bfbb30@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 29 Jun 2001 11:39:35 -0400
To: szonyi calin <caszonyi@yahoo.com>
From: David Relson <relson@osagesoftware.com>
Subject: Re: gcc: internal compiler error: program cc1 got fatal signal
  11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010629142055.49246.qmail@web13907.mail.yahoo.com>
In-Reply-To: <200106291248.HAA02327@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:20 AM 6/29/01, you wrote:

>Almost always ?
>It seems like gcc is THE ONLY program which gets
>signal 11
>Why the X server doesn't get signal 11 ?
>Why others programs don't get signal 11 ?
>
>I remember that once Bill Gates was asked about
>crashes in windows and he said: It's a hardware
>problem.
>It was also a joke on that subject:
>Winerr xxx: Hardware problem (it's not our fault, it's
>not, it's not, it's not, it's not...)
>
>
>Seems to me like Micro$oft way of handling problems.
>
>We must agree that gcc is full of bugs (xanim does not
>run corectly if it is compiled with gcc 2.95.3
>and other programs which use floating point
>calculations do the same (spice 3f5))

All versions of gcc have bugs.  They generally show up as incorrect 
complaints about the source code, as generated code that is less than 
optimal or that is flat out wrong.  With this kind of bug, if you compile 
the program twice you'll get the same (buggy) result.

Sig 11 is a bit different.  With a compiler bug causing the sig 11, the 
problem will happen EVERY time you compile the given file - because the 
compiler is busted.  This kind of problem is detected early in the 
compiler's life cycle and gets fixed.

Then there are the intermittent sig 11 errors.  If the software was broken, 
the sig 11 would happen whenever you do the same thing.  Being able to 
compile a bunch of files, get a sig 11, compile a bunch more, sig 11, a 
bunch more ... is a sign that the problem isn't the compiler.  Peoples' 
experience over the years has shown that symptoms of this type are cause by 
(intermittent) hardware problems.

Why does this affect gcc more than other programs?  Because gcc uses 
gazillions of pointers and bad memory causes bad pointers causes sig 11.

Hope this helps.

David

P.S.  Years ago, installing OS/2 on an apparently 100% working system would 
show similar problems.  OS/2 was the first widely used 32 bit operating 
system on Intel hardware.  It exercised the hardware differently from DOS, 
Windows, etc and flaky memory would make itself known.  The usual reaction 
was "But my system worked fine before OS/2...."  The response was 
"different software exercises the hardware differently and may reveal 
unsuspected problems".
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

