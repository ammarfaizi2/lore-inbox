Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131453AbQLLStk>; Tue, 12 Dec 2000 13:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131493AbQLLSta>; Tue, 12 Dec 2000 13:49:30 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:60434 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S131453AbQLLStM>; Tue, 12 Dec 2000 13:49:12 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 12 Dec 2000 11:18:26 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E145Xy6-0008HA-00@the-village.bc.nu>
In-Reply-To: <E145Xy6-0008HA-00@the-village.bc.nu>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
MIME-Version: 1.0
Message-Id: <00121211182600.11576@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 December 2000 11:46, Alan Cox wrote:
>
> Its an interesting demo that 2.4 has some performance problems since 2.2
> is slower than 2.0 although nowdays not much.

Results for SMP 2.2.18 vs SMP 2.4.0-test12 are in.
I repeated my earlier tests on a much faster dual P-III machine.

Executive summary: SMP 2.4.0 is 2% faster than SMP 2.2.18.

Although I made the following changes in the test procedure, these
tests for 2.2.18 and 2.4.0-test12 were held under identical conditions.

I used make -j3 bzImage for these tests on this SMP machine.
The test machine is a dual P-III (733 Mhz), 256MB, IDE.

I ran X and KDE 2.0 during the tests to provide a greater though
reproducable load on the tested kernel.  

The 2.2.18 kernel used was the final 2.2.18.

The 2.4.0-test12 is still 2.4.0-test12-pre7 since test12(final)
does not yet build with reiserfs. Team Reiser is working on this.

Here are the numbers I got.  Again, three runs each were done.
Task: make -j3 bzImage for 2.4.0-test12-pre7 kernel tree.
Numbers are seconds to build.

 1       2       3      ave.
143     143     143     143     Running 2.2.18 SMP
140     140     140     140     Running 2.4.0-test12-pre7 SMP

The numbers are very repeatable, as you can see.

This time, 2.4.0-test12 wins by 2%.  Recounts can be performed
by anyone, anytime.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
