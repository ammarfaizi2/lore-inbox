Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131934AbQL3CyZ>; Fri, 29 Dec 2000 21:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132787AbQL3CyP>; Fri, 29 Dec 2000 21:54:15 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:56272 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S131934AbQL3CyG>; Fri, 29 Dec 2000 21:54:06 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5
Date: Sat, 30 Dec 2000 03:25:51 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="ISO-8859-1"
In-Reply-To: <Pine.LNX.4.21.0012291138380.1403-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0012291138380.1403-100000@duckman.distro.conectiva>
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <00123003255100.01043@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. Dezember 2000 14:38 schrieben Sie:
> On Fri, 29 Dec 2000, Dieter Nützel wrote:
> > your patch didn't apply clean.
> > Have you another version?
>
> It should apply just fine. What error messages did
> patch give ?
>
Applied #2 against my running 2.4.0-test13-pre5 + ReiserFS 3.6.23 tree and
a clean test13-pre5 (test12 + test13-pre5). Same for both of them:

SunWave1>patch -p0 -E -N <patches/2.4.0-test13-pre5-VM-fix
patching file `linux-2.4.0-test13-pre5/mm/filemap.c'
Hunk #1 FAILED at 1912.
Hunk #2 FAILED at 2438.
Hunk #3 FAILED at 2448.
Hunk #4 FAILED at 2493.
4 out of 4 hunks FAILED -- saving rejects to 
linux-2.4.0-test13-pre5/mm/filemap.c.rej
patching file `linux-2.4.0-test13-pre5/mm/memory.c'
Hunk #1 FAILED at 1198.
1 out of 1 hunk FAILED -- saving rejects to 
linux-2.4.0-test13-pre5/mm/memory.c.rej
patching file `linux-2.4.0-test13-pre5/mm/vmscan.c'
Hunk #1 FAILED at 49.
Hunk #2 FAILED at 59.
Hunk #3 FAILED at 92.
Hunk #4 FAILED at 108.
Hunk #5 FAILED at 159.
Hunk #6 FAILED at 200.
Hunk #7 FAILED at 271.
Hunk #8 FAILED at 290.
Hunk #9 FAILED at 310.
Hunk #10 succeeded at 390 with fuzz 2.
Hunk #11 FAILED at 430.
Hunk #12 FAILED at 575.
Hunk #13 FAILED at 586.
Hunk #14 FAILED at 618.
Hunk #15 FAILED at 932.
Hunk #16 FAILED at 944.
Hunk #17 FAILED at 953.
Hunk #18 FAILED at 972.
Hunk #19 succeeded at 1007 with fuzz 2.
Hunk #20 succeeded at 1182 with fuzz 2.
17 out of 20 hunks FAILED -- saving rejects to 
linux-2.4.0-test13-pre5/mm/vmscan.c.rej
patching file `linux-2.4.0-test13-pre5/include/linux/mm.h'
Hunk #1 succeeded at 460 with fuzz 2.
patching file `linux-2.4.0-test13-pre5/include/linux/swap.h'

filemap.c : offset of 3 lines needed
memory.c : dito
vmscan.c : dito

Now, I hacked it by 'hand' and got it running.
I did dbench and saw nearly same results then Daniel Phillips
But my disk is to small. Some writes failed...:-(

Test machine: 256 MB, Athlon 550 SlotA, SCSI, ReiserFS 3.6.23, Blocksize=4K
Test: dbench 48

Throughput:	10.89 MB/sec
Elapsed Time:	9 min 47 secs

"Guten Rutsch in's neue Jahr!" :-)

-Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
