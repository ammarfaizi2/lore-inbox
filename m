Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757730AbWKXNHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730AbWKXNHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 08:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757732AbWKXNHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 08:07:04 -0500
Received: from mpemail.mpe-garching.mpg.de ([130.183.137.110]:63109 "EHLO
	mpemail.mpe.mpg.de") by vger.kernel.org with ESMTP id S1757731AbWKXNHD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 08:07:03 -0500
From: "Martin A. Fink" <fink@mpe.mpg.de>
Organization: MPE
To: linux-kernel@vger.kernel.org
Subject: SATA Performance with Intel ICH6
Date: Fri, 24 Nov 2006 14:07:01 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611241407.01210.fink@mpe.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I found out, that writing to a SATA harddisk costs around 20% of the
computers cpu time. I write blocks of 1MB size to a file. Write performance
is around 51MB/s what I think is really good. My computer has an Intel ICH6
chipset and a 3.2GHz Pentium 4 processor.
If I understand the design of this chipset correctly, then I would have
expected, that the CPU needs to do only few work, instead I found out, that
writing to disk seems to be really hard work for the CPU.

Can I do anything to optimize writing from memory to disk?

My final aim is to get around 140MB/s of data from 3 different Gigabit
Ethernet cards and store it on 3 harddisk drives that perform 50MB/s.
>From the SATA bus side there should be no problem. Each of the 4 SATAs on
this ICH6 chipset are capable of 150MB/s.

So what makes my CPU that slow? Is it a hardware problem or a problem of
SATA driver of my operating system?

time dd if=/dev/zero of=test.zero bs=1M count=1000
results in

real 0m52.561s
user 0m0.003s
sys  0m7.407s

and strace dd... gives among other information
6.84s 1004calls syscall: write

So I spend 45s of 52s within the kernel. Why so long?


By the way: I'm working with SuSE Linux 9.2 on a Dell Desktop PC, 1GB RAM

Thank you for answers,

Martin
