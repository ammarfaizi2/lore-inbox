Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSHCOXX>; Sat, 3 Aug 2002 10:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSHCOXX>; Sat, 3 Aug 2002 10:23:23 -0400
Received: from mnh-1-16.mv.com ([207.22.10.48]:34564 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317572AbSHCOXW>;
	Sat, 3 Aug 2002 10:23:22 -0400
Message-Id: <200208031529.KAA01655@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@redhat.com>, mingo@elte.hu
Cc: rz@linux-m68k.org (Richard Zidlicky), linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Sat, 03 Aug 2002 08:33:30 -0400."
             <200208031233.g73CXUB02612@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 10:29:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@redhat.com said:
> Which would argue UML ought to have a positively microkernel view of
> syscalls - sending a message ? 

Indeed.  Ingo's mail got me thinking that

alan@redhat.com said:
> the alternatives like a seperate process and ptrace are not pretty either

might not be so bad after all.

All I would need to make this work is for one process to be able to change
the mm of another.

Then, the current UML tracing thread would handle the kernel side of things
and sit in its own address space nicely protected from its processes.

				Jeff

