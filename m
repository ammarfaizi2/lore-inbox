Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130282AbQKOLrh>; Wed, 15 Nov 2000 06:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbQKOLrS>; Wed, 15 Nov 2000 06:47:18 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:20389 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130282AbQKOLrQ>; Wed, 15 Nov 2000 06:47:16 -0500
Message-ID: <3A1270B9.1A38133@uow.edu.au>
Date: Wed, 15 Nov 2000 22:17:13 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawe³ Kot <pkot@linuxnews.pl>
CC: lkml <linux-kernel@vger.kernel.org>, smp-linux-kernel@vger.kernel.org
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A1115C5.4C04CD6A@uow.edu.au> <Pine.LNX.4.30.0011141659020.29502-600000@tfuj.ahoj.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pawe³ Kot" wrote:
> 
> Hi,
> 
> The whole oops produced by the 2.4.0-test11pre4 with this patch is in the
> attachment. Other system info is tehere as well.
> 
> Oops is produced when runnning big-tables test from mysql sql-bench.
> It's reproducable. The machine is running only mysqld.

Thank you.  Quad 700 meg Xeons?  Nice machine, that.

The NMI oops changes are working well. We can see three CPUs are
stuck in different places spinning on the same lock with interrupts
disabled, but unfortunately something went wrong with your `ksymoops'
run.

Could you please rerun ksymoops, and make sure that you use the
correct symbol file?  Take the `System.map' from the directory
where you built the kernel and run

	ksymoops -m System.map < log_file

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
