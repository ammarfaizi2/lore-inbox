Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267483AbRGSIsR>; Thu, 19 Jul 2001 04:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267486AbRGSIsI>; Thu, 19 Jul 2001 04:48:08 -0400
Received: from grobbebol.xs4all.nl ([194.109.248.218]:28767 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267483AbRGSIsA>; Thu, 19 Jul 2001 04:48:00 -0400
Date: Thu, 19 Jul 2001 08:47:40 +0000
From: "Roeland Th. Jansen" <bengel@grobbebol.xs4all.nl>
To: bug-sh-utils@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: who command misses tty1..kernel or sh-utils ?
Message-ID: <20010719084740.A3717@grobbebol.xs4all.nl>
Reply-To: roel@grobbebol.xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


who (GNU sh-utils) 2.0
Written by Joseph Arceneaux and David MacKenzie.

Copyright (C) 1999 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


who seems to loose interest in the fact that tty1 is also being used.

initially i's shown after a restart but after a while it is missed.
maybe a kernel problem, maybe not :

grobbebol:~ $ w
  8:42am  up 4 days,  4:42,  6 users,  load average: 0.34, 0.18, 0.06
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
root     tty2     -                Mon 9am 38.00s  0.82s  0.69s  -bash
bengel   tty3     -                Sun10pm  0.00s  7.21s  0.04s  w
bengel   tty4     -                Sun 4am 11.00s  0.45s  0.12s  mutt
bengel   tty5     -                Sun11pm  1:59  26.06s 25.88s  tin
bengel   tty6     -                Mon 9am  7:24   0.24s  0.15s  -bash
roel     tty8     -                Sun10pm 23:39m  4.33s  4.17s  mutt

grobbebol:~ $ who
root     tty2     Jul 16 09:01
bengel   tty3     Jul 15 22:46
bengel   tty4     Jul 15 04:13
bengel   tty5     Jul 15 23:01
bengel   tty6     Jul 16 09:19
roel     tty8     Jul 15 22:31

I have seen this with many, if not all 2.4 kernels. this is 2.4.6.
tty1 _is_ active :

[....]
root      3857  0.0  0.4  2812 1120 tty1     R    08:46   0:00 ps aux

so.. kernel problem or sh-utils ?

Linux grobbebol 2.4.6 #1 SMP Wed Jul 4 18:13:45 GMT 2001 i686 unknown

-- 
Grobbebol's Home                     |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel         | Use your real e-mail address   /\
Linux 2.4.6.(apic) SMP 466MHz/256 MB |        on Usenet.             _\_v  
