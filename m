Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310596AbSCGXaB>; Thu, 7 Mar 2002 18:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310594AbSCGX3v>; Thu, 7 Mar 2002 18:29:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44550 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310595AbSCGX3e>; Thu, 7 Mar 2002 18:29:34 -0500
Subject: Re: Performance issue on dual Athlon MP
To: gyro@zeta-soft.com (Scott L. Burson)
Date: Thu, 7 Mar 2002 23:44:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15494.32860.773969.762627@kali.zeta-soft.com> from "Scott L. Burson" at Mar 07, 2002 03:20:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16j7Yh-0004CL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, this doesn't seem like a preemption issue, considering that throughput
> is very definitely affected as well as latency.
> 
> Anyway, please let me know if there's anything I can do, within my
> constraints, to help.  (As you can guess, though, I don't have any kernel
> debugging experience.)

It sounds like the hit you are taking is from highmem and I/O (having to
copy pages lower into memory so the I/O subsystem can use them). Some of
that is in the hard to fix for 2.4 category with the x86. There are some
experimental patches around but they are experimental.
