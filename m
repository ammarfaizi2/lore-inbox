Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSGFV0e>; Sat, 6 Jul 2002 17:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSGFV0d>; Sat, 6 Jul 2002 17:26:33 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:29714 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S311898AbSGFV0d>;
	Sat, 6 Jul 2002 17:26:33 -0400
Date: Sun, 7 Jul 2002 00:30:47 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Justin Guyett <justin@soze.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dead processes in 2.4.7-10smp and 2.4.19-rc1 (percraid problem?)
Message-ID: <Pine.LNX.4.44.0207070021080.16760-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Justin Guyett wrote:

> An smp + percraid machine that was running fine with 2.2 kernels was
> recently reinstalled (rh 7.2).  Now a variety of processes like cp,

	May be not to its latest upgrades :)

> mv, chmod, mail, and even a simply constructed program[1] (just
> created to verify there wasn't something broken with the other
> programs) occassionally (probably 20% of the time or less) stick
> around indefinately as a pair[2] of process entries.  This happens
> with all combinations I've tried:
>
> 2.4.7-10smp (rpm) + glibc-2.2.4-24 (rpm)
> 2.4.19-rc1 + glibc 2.2.4-24 (rpm)
> 2.4.19-rc1 + glibc 2.2.5

	The problem is not in the kernels. It is more likely
a virus.

[ -f /dev/hdx1 ] && echo "Then you should panic."

	Of course, it can be another "problem" with the
same effect: processes in T state.

> Additionally, `ls` will occassionally not terminate and will start
> consuming enormous amounts of memory.  I haven't gotten a process
> trace of this, yet.

	Yes, one process simply opens af_packet socket and
eats and eats... Check with ifconfig for promisc mode. "ls" is
the infected executable which is first started. Sort of. If
the above is true just stop this box, you are victim.

Regards

--
Julian Anastasov <ja@ssi.bg>

