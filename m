Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQLLUur>; Tue, 12 Dec 2000 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbQLLUug>; Tue, 12 Dec 2000 15:50:36 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:519 "EHLO tstac.esa.lanl.gov")
	by vger.kernel.org with ESMTP id <S129518AbQLLUuR>;
	Tue, 12 Dec 2000 15:50:17 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 12 Dec 2000 13:19:35 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012121031200.2239-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012121031200.2239-100000@penguin.transmeta.com>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
MIME-Version: 1.0
Message-Id: <00121213193501.00861@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 December 2000 11:40, Linus Torvalds wrote:
> On Tue, 12 Dec 2000, Steven Cole wrote:
> > Executive summary: SMP 2.4.0 is 2% faster than SMP 2.2.18.
>
> > I ran X and KDE 2.0 during the tests to provide a greater though
> > reproducable load on the tested kernel.
>
> You might want to do the same in 32-64MB of RAM. And actually move your
> mouse around a bit to keep KDE/X from just being paged out, at which point
> it turns un-interesting again. I don't know how to do that repeatably,
> though, but one thing I occasionally do is to read my email (which is not
> very CPU-intensive, but it does keep the desktop active and also gives me
> a feel for interactive behaviour).
>

Keeping the memory the same, I repeated the kernel builds
while moving the mouse in a similar way, and switching the
desktop 3 times, same desktops for each test. Yes, I know,
this doesn't test much more, since nothing was swapped out.

These results are even closer. The differences are so slight,
that they are not statistically significant. Hmmm, maybe no
news is good news in this case.

Perhaps if anything is interesting from this test,
it is the negative result: No significant performance
difference for this particular CPU-intensive task on only
two processors.  

I'm sure it would be fun to try this test on a GS320 32-CPU Wildfire.  
I believe a 24-CPU Sun E10000 built a 2.4.0-test7 kernel in about 20 seconds.
Fun, but maybe not too meaningful. Sigh.

Task: make -j3 bzImage for 2.4.0-test12-pre7 kernel tree.
Numbers are seconds to build.

New results (with fiddling with the desktop):

 1       2       3      ave.
143     142     142     142.3   Running 2.2.18 SMP
141     141     142     141.3   Running 2.4.0-test12-pre7 SMP

Steven

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
