Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130401AbQLLPVA>; Tue, 12 Dec 2000 10:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131890AbQLLPUu>; Tue, 12 Dec 2000 10:20:50 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:47879 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S130401AbQLLPUi>; Tue, 12 Dec 2000 10:20:38 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 12 Dec 2000 07:49:48 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com
To: helgehaf@idb.hist.no
In-Reply-To: <Pine.LNX.4.10.10012111357430.21909-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.10.10012111357430.21909-100000@innerfire.net>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
MIME-Version: 1.0
Message-Id: <00121207494808.01067@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>Steven Cole wrote:
>[...]
>>Simple question here, and risking displaying great ignorance:
>>Does it make sense to use make -jN where N is much greater than the
>>number of CPUs?
>
>No, but it makes sense to have N at least one more than the number of
>cpus,
>if you have the memory.  This because your processes occationally
>will wait for disk io, and this time may then be utilized to
>run the "extra" task.  But don't overdo it, as you get less disk
>cache this way.  make -j3 seems to be fastest on my 2-cpu machine
>with 128M ram.

Thanks for the answer.  That makes a lot of sense.  When I get the time,
I'll verify that, at least for this fairly narrowly defined task of building 
a kernel.  

In order to minimize external and variable influences on the CPU load, I 
performed all these tests in console mode not connected to a network.  That 
may have been an unrealistic test, as that is not how I normally do kernel 
builds.  Having to juggle more work, like running X and KDE, could shift the 
results (2.2.18 vs 2.4.0-test12) around a bit.  I'll repeat the tests with a 
more normal work environment. If anything statistically significant is found, 
I'll mention it.  Thanks to all for their input.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
