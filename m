Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275754AbRJFWWC>; Sat, 6 Oct 2001 18:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275759AbRJFWVx>; Sat, 6 Oct 2001 18:21:53 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:45079 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275754AbRJFWVp>; Sat, 6 Oct 2001 18:21:45 -0400
Subject: Re: low-latency patches
From: Robert Love <rml@tech9.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011006150024.C2625@mikef-linux.matchmail.com>
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu>
	<3BBEA8CF.D2A4BAA8@zip.com.au> 
	<20011006150024.C2625@mikef-linux.matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 06 Oct 2001 18:22:09 -0400
Message-Id: <1002406931.1911.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 18:00, Mike Fedyk wrote:
> And exactly how is low latency going to hurt the majority?

The problem is people argue that a preemptible kernel lowers throughput
since I/O is now interrupted.  Of course, if they fear that, maybe we
should switch to cooperative multitasking!

Anyhow, tests show the preemptible kernel has a negligible effect on
throughput -- in fact in some cases we improve it since overtime we
better distribute system load.  This is one reason why I ask for dbench
or bonnie benchmarks from the preemption users.  Results are good.

The other concern is that added complexity is a Bad Thing, and I agree,
but the complexity of preemption is insanely low.  In fact, since we use
so many preexisting constructs (such as SMP locks), its practically
nothing.

> This reminds me of when 4GB on ia32 was enough, or 16 bit UIDs, or...
>
> Should those have been left out too just because the people who needed them
> were few?

Agreed.

> If the requirements for manufacturing control, or audio processing, or etc
> will make my home box, or my server work better then why not include it?

That is my thought process, too.

	Robert Love

