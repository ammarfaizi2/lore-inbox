Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132820AbRA0LAa>; Sat, 27 Jan 2001 06:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132613AbRA0LAU>; Sat, 27 Jan 2001 06:00:20 -0500
Received: from [194.213.32.137] ([194.213.32.137]:37636 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132863AbRA0LAB>;
	Sat, 27 Jan 2001 06:00:01 -0500
Message-ID: <20010127111759.A163@bug.ucw.cz>
Date: Sat, 27 Jan 2001 11:17:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David L. Nicol" <david@kasey.umkc.edu>, linux-kernel@vger.kernel.org,
        chris.ricker@genetics.utah.edu
Subject: Re: "no such 386 instruction" with gcc 2.95.2
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu>; from David L. Nicol on Thu, Jan 25, 2001 at 03:46:48PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think I must need to upgrade my assembler, but:
> 2.4.0/Documentation/Changes does not list an assembler version.
> 
> 
> 
> 
> make[2]: Entering directory `/mnt/sdb2/src/linux-2.4.0/drivers/md'
> gcc -D__KERNEL__ -I/mnt/sdb2/src/linux-2.4.0/include -Wall -Wstrict-proto
> types -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-sta
> ck-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /mnt/sdb2/src/l
> inux-2.4.0/include/linux/modversions.h   -DEXPORT_SYMTAB -c xor.c
> {standard input}: Assembler messages:
> {standard input}:996: Error: no such 386 instruction: `movups'
> {standard input}:997: Error: no such 386 instruction: `movups'
> {standard input}:998: Error: no such 386 instruction: `movups'
> {standard input}:999: Error: no such 386 instruction: `movups'
> {standard input}:1001: Error: no such 386 instruction: `prefetcht0'
> {standard input}:1002: Error: no such 386 instruction: `prefetcht0'
> {standard input}:1005: Error: no such 386 instruction: `movaps'
> {sta...
> ...

Hmm, perhaps I understand: xor wants to have best routines for all
possible CPUs, so it has instructions beyond 386....
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
