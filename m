Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310590AbSCGXUW>; Thu, 7 Mar 2002 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310587AbSCGXUC>; Thu, 7 Mar 2002 18:20:02 -0500
Received: from w197.z066088144.sjc-ca.dsl.cnc.net ([66.88.144.197]:47298 "EHLO
	kali.zeta-soft.com") by vger.kernel.org with ESMTP
	id <S310585AbSCGXUA>; Thu, 7 Mar 2002 18:20:00 -0500
From: "Scott L. Burson" <gyro@zeta-soft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu,  7 Mar 2002 15:20:48 -0800 (PST)
To: linux-kernel@vger.kernel.org
Subject: Re: Performance issue on dual Athlon MP
In-Reply-To: <200203062028.25738.Dieter.Nuetzel@hamburg.de>
In-Reply-To: <200203062028.25738.Dieter.Nuetzel@hamburg.de>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15494.32860.773969.762627@kali.zeta-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Scott L. Burson" <gyro@zeta-soft.com>
> Date: Wed,  6 Mar 2002 10:47:02 -0800 (PST)
> 
> I have a dual Athlon MP box (Tyan S2460 Tiger MP, 1.53 GHz, 2.5 GB Corsair
> PC2100).  The initial installation was of SuSE 7.3, but I have upgraded to
> 2.4.17 with Andrea's 3.5 GB userspace patch.
> 
> Mostly the machine works fine, but when it does a lot of disk I/O, it starts 
> to bog down badly.
-----

> From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
> Date: Wed, 6 Mar 2002 20:28:25 +0100

> Try 2.4.19-pre2-ac2 or 2.4.19pre1aa1+O(1). Maybe preemption can help, too.
-----

> From: John Jasen <jjasen1@umbc.edu>
> Date: Wed, 6 Mar 2002 15:49:16 -0500
> 
> I have not seen this in either 2.4.17, 2.4.17-preempt-kdb, or
> 2.4.18-preempt-hedrick-ide-kdb.
> 
> Running a dual Athlon MP with the same board, two 1500+ processors, but
> with only 512MB ram.
-----

> From: rwhron@earthlink.net
> Date: Wed, 6 Mar 2002 17:09:51 -0500
> 
> The configuration I would try first on 2.4.19pre1aa1 with 2.5 GB of RAM is 
> CONFIG_3GB=y and CONFIG_NOHIGHMEM=y.  If that causes some other problem,
> I'd go with CONFIG_2GB, then finally CONFIG_1GB.

Thanks for the replies.

The entire purpose of this machine is to run big honking Lisp jobs (which,
BTW, it does very well).  I need as much user address space as I can get.
So `CONFIG_3GB' and `CONFIG_2GB' are out of the question.  I might be able
to live with `CONFIG_1GB', but I can also live with the problem.

Also, given that the machine is in service, I hesitate to try prereleased
kernels.  If it's thought that 2.4.19 will fix or ameliorate the problem,
I'd rather just wait for that.

But if the problem is not a known one, I am happy to do whatever I can do to
help diagnose it, as long as I can do that without more than an occasional
reboot.  For instance, is there some way to get a statistical profile of
where the kernel is spending its time?  Even something very rough like a
handful of samples of the PC might be revealing -- particularly if, as I
suspect, the CPUs are stuck in spinlocks a lot of the time.

BTW, this doesn't seem like a preemption issue, considering that throughput
is very definitely affected as well as latency.

Anyway, please let me know if there's anything I can do, within my
constraints, to help.  (As you can guess, though, I don't have any kernel
debugging experience.)

Please CC: replies to me, as I am not on the list.

-- Scott
