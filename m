Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUEXDdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUEXDdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 23:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUEXDdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 23:33:24 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:20391 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S263865AbUEXDbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 23:31:36 -0400
Date: Mon, 24 May 2004 05:31:33 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
In-Reply-To: <Pine.LNX.4.44.0405240325180.15205-100000@hubble.stokkie.net>
Message-ID: <Pine.LNX.4.44.0405240509320.16974-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> procs memory swap io system cpu
>
> r b swpd free    buff  cache si so bi bo  in   cs   us sy id wa
> 1 0 0    8153848 17000 82348 0  0  0  0   4568 4028 6  16 78 0
> 0 1 0    8154168 17008 82340 0  0  0  160 4596 4079 7  17 76 1
> 1 0 0    8153848 17008 82340 0  0  0  0   4511 3998 7  16 76 0
> 1 0 0    8153912 17008 82340 0  0  0  0   4460 3952 7  14 79 0
> 1 0 0    8153784 17016 82332 0  0  0  0   4437 3962 7  16 77 0
> 1 0 0    8153528 17016 82332 0  0  0  0   4444 3927 7  14 78 0
> 1 1 0    8153784 17024 82392 0  0  0  144 4399 3895 7  15 77 1
> 0 0 0    8153592 17024 82392 0  0  0  0   4367 3821 7  15 78 0
> 1 0 0    8153848 17024 82392 0  0  0  0   4393 3926 6  16 78 0
> 1 0 0    8153528 17024 82460 0  0  0  0   4438 3960 8  14 78 0
> 1 0 0    8154040 17024 82460 0  0  0  0   4415 3912 6  15 78 0
> 1 1 0    8153720 17032 82452 0  0  0  140 4457 3953 7  15 77 1
> 1 0 0    8153784 17032 82452 0  0  0  0   4437 3889 7  14 79 0
> 0 0 0    8153784 17040 82444 0  0  0  0   4398 3903 8  15 77 0
> 1 0 0    8153464 17040 82444 0  0  0  0   4398 3902 7  14 79 0
> 0 0 0    8153528 17040 82444 0  0  0  0   4447 3922 6  17 77 0
> 0 1 0    8153720 17052 82432 0  0  0  144 4490 3960 6  16 77 1
> 0 0 0    8153656 17056 82428 0  0  0  0   4449 3954 7  15 78 0

FIELD DESCRIPTION FOR VM MODE
   Procs
       r: The number of processes waiting for run time.
       b: The number of processes in uninterruptible sleep.

During the 18 seconds of displayed stats, you have 12 seconds in which
1 process is waiting for run time. Which process is that, and where is
it waiting for ?

Is your custom excecutable compile project causing this or does a simple
compile task display the same slowdowns? As a small bench test with a source
we all can download, try to compile bison-1.75.tar.bz2 :

# ./configure ; time make
...
make[1]: Leaving directory `/home/stock/tmp/src/bison-1.75'
37.33user 3.64system 0:40.66elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (121059major+64165minor)pagefaults 0swaps

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

