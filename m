Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQLHWp7>; Fri, 8 Dec 2000 17:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQLHWpt>; Fri, 8 Dec 2000 17:45:49 -0500
Received: from frogger.telerama.com ([205.201.1.48]:26897 "EHLO
	frogger.telerama.com") by vger.kernel.org with ESMTP
	id <S129855AbQLHWpn>; Fri, 8 Dec 2000 17:45:43 -0500
Date: Fri, 8 Dec 2000 17:15:15 -0500 (EST)
From: Peter Berger <peterb@telerama.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
In-Reply-To: <F1BEC884C26@vcnet.vc.cvut.cz>
Message-ID: <Pine.BSI.4.02.10012081708350.130-100000@frogger.telerama.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

Thanks for testing this and finding a working counterexample!  I am still
professionally interested to know if the difference is that you are
running a 2.4 kernel, or the glibc.  Anyone running a 2.2 kernel with
glibc 2.2 want to drop me a line?

-Peter

(gdb) run  
...
[New Thread 25452]
threads_test: thread #210 created...done.
[New Thread 25453]
threads_test: thread #211 created...done.
[New Thread 25454]
threads_test: thread #212 created...done.
Cannot access memory at address 0xa4dffe8c
(gdb)

[3]+  Stopped                 gdb ./thread
[peterb@deedee src]$ ps axuw
bash: fork: Resource temporarily unavailable
[peterb@deedee src]$

[kill a process]

[peterb@deedee src]$ ps axuw

peterb   25679  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25680  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25681  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25682  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25683  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25684  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
....several hundred lines later...
peterb   25889  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25890  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25891  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25892  0.0  0.0     0    0 ttya0    Z    17:12   0:00 [thread
<defunct>]
peterb   25893  0.0  0.2  2704 1060 ttya0    R    17:12   0:00 ps axuw
[2]-  Done                    netscape http://www.slashdot.org  (wd:
/home/peterb/p4base/tests/common)
(wd now: ~/src)
[

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
