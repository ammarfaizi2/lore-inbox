Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbREBTTY>; Wed, 2 May 2001 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbREBTTE>; Wed, 2 May 2001 15:19:04 -0400
Received: from gateway.sequent.com ([192.148.1.10]:31788 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S133088AbREBTTA>; Wed, 2 May 2001 15:19:00 -0400
From: Nivedita Singhvi <nivedita@sequent.com>
Message-Id: <200105021918.MAA10107@eng4.sequent.com>
Subject: netperf stream scaling; patches that help?
To: linux-kernel@vger.kernel.org
Date: Wed, 2 May 2001 12:18:56 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to run a simple test on a pair of Linux 2.4.2 
PC's that starts up simultaneous netperf tcp stream tests, 
and find that I cant invoke more that 800 without running 
into memory allocation failures. This wouldnt be strange 
except that I find on the same systems, FreeBSD seems to 
do twice as well (1600). I complete 500 concurrent netperf 
tcp stream tests sending 64 byte packets successfully, but 
again, FreeBSD completes a 1000 successfully. Also, Linux
appears to hog around 300MB on the server side, whereas
FreeBSD only appears to be using 3MB. Those are the bare
numbers, details available, of course, but what I'd like 
to do is repeat the Linux test with 2.4.4 and include some 
VM patches that might possibly alleviate any memory 
management issues I may be running into.

This is between a 500MHz PIII Katmai and 333MHz PII
Deschutes both with 512MB memory, over a 100Mb (3C905C)
private nw.
 
I'd appreciate any pointers to patches that might help,
or suggestions in general to improve the Linux numbers.
Especially any insight into whether this is a case of
apples/oranges or whether I'm missing some trivial element
here... 

I know of Ed Tomlinson's patch posted on this list on
4/12, are there any others? I know Jonathan Morton posted
some OOM patches, are those included in 2.4.4?

thanks,
Nivedita 

---
Nivedita Singhvi                        (503) 578-4580
Linux Technology Center                 nivedita@us.ibm.com
IBM Beaverton, OR                       nivedita@sequent.com
