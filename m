Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132900AbQLJVHm>; Sun, 10 Dec 2000 16:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbQLJVHc>; Sun, 10 Dec 2000 16:07:32 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:40722 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S132900AbQLJVHT>; Sun, 10 Dec 2000 16:07:19 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Sun, 10 Dec 2000 13:36:37 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
MIME-Version: 1.0
Message-Id: <00121013363704.01067@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:
>| 2.2.18-pre26 was compiled with gcc 2.91.66 (kgcc).
>| 2.4.0-test12-pre7 was compiled with gcc 2.95.3.
>
>That's your answer right there.
>GCC 2.95.3 compiles much slower than kgcc.
>
>Rerun the 2.4.0 with kgcc to be fair. :)

Actually, it is fair.  There are really two results,

1) 309 sec for 2.2.18p26 vs  318 sec for 2.4.0t12p7 where the
   task was building 2.2.18p26 using kgcc.

2) 444 sec for 2.2.18p26 vs  457.3 sec for 2.4.0t12p7 where the
   task was building 2.4.0t12p7 using gcc.

In each case, the task and the tools used are the same.  The
only difference was the kernel used. In both cases, 2.2.18 won by 3%.  Its 
comparing apples to apples and oranges to oranges. Granted 3% isn't
very much, but I would have guessed that 2.4.0 would have been the
winner.  It wasn't, at least for this single processor machine.

Now, if you're saying that 2.4.0-test12 will get the job done faster when 
compiled using kgcc, that's something else.  I'll try that out to see if it 
makes a difference.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
