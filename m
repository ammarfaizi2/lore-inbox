Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSDJFsH>; Wed, 10 Apr 2002 01:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312458AbSDJFsG>; Wed, 10 Apr 2002 01:48:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312453AbSDJFsG> convert rfc822-to-8bit; Wed, 10 Apr 2002 01:48:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: nanosleep
Date: 9 Apr 2002 22:47:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a90jlu$3ev$1@cesium.transmeta.com>
In-Reply-To: <20020410044243.2916.qmail@fastermail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g3A5lhN19588
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020410044243.2916.qmail@fastermail.com>
By author:    "mark manning" <mark.manning@fastermail.com>
In newsgroup: linux.dev.kernel
>
> thanx - how much of a difference should i expect - i know the
> syscall is asking for at least the required ammount but that the
> task switcher might not give me control back for a while after the
> requested delay but i was expecting to be a little closer to what i
> had asked for - this isnt critical of corse but i would like to know
> what to expect.
> 

Read the man page:

BUGS
       The current implementation of nanosleep is  based  on  the
       normal  kernel  timer mechanism, which has a resolution of
       1/HZ s (i.e, 10 ms on Linux/i386 and 1 ms on Linux/Alpha).
       Therefore, nanosleep pauses always for at least the speci­
       fied time, however it can take up to  10  ms  longer  than
       specified  until  the  process becomes runnable again. For
       the same reason, the value returned in case of a delivered
       signal  in *rem is usually rounded to the next larger mul­
       tiple of 1/HZ s.

       As some applications  require  much  more  precise  pauses
       (e.g.,  in  order to control some time-critical hardware),
       nanosleep is also capable of short high-precision  pauses.
       If  the process is scheduled under a real-time policy like
       SCHED_FIFO or SCHED_RR, then pauses of up to 2 ms will  be
       performed as busy waits with microsecond precision.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
