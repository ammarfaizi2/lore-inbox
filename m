Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129591AbQK1Qk1>; Tue, 28 Nov 2000 11:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129728AbQK1QkR>; Tue, 28 Nov 2000 11:40:17 -0500
Received: from Cantor.suse.de ([194.112.123.193]:14342 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129591AbQK1QkN>;
        Tue, 28 Nov 2000 11:40:13 -0500
Date: Tue, 28 Nov 2000 17:09:48 +0100
Message-Id: <200011281609.eASG9mP04909@hawking.suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>
        <200011280955.eAS9t6I22393@hawking.suse.de>
        <20001128161612.B14675@athlon.random>
X-Yow: Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP
 with the BROKEN PLASTIC FORKS in it!!
From: Andreas Schwab <schwab@suse.de>
In-Reply-To: <20001128161612.B14675@athlon.random>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.92
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

|> On Tue, Nov 28, 2000 at 10:55:06AM +0100, Andreas Schwab wrote:
|> > Alexander Viro <viro@math.psu.edu> writes:
|> > 
|> > |> On Tue, 28 Nov 2000, Andrea Arcangeli wrote:
|> > |> 
|> > |> > On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
|> > |> > > If you have two files:
|> > |> > > test1.c:
|> > |> > > int a,b,c;
|> > |> > > 
|> > |> > > test2.c:
|> > |> > > int a,c;
|> > |> > > 
|> > |> > > Which is _stronger_?
|> > |> > 
|> > |> > Those won't link together as they aren't declared static.
|> > |> 
|> > |> Try it. They _will_ link together.
|> > 
|> > Not if you compile with -fno-common, which should actually be the default
|> > some day, IMHO.
|> 
|> I thought -fno-common was the default behaviour indeed, and I agree it should
|> become the default since current behaviour can lead to sublte bugs. (better I
|> discovered this gcc "extension" this way than after some day of debugging :)

This is not really a gcc extension, but long Unix tradition.  If you make
-fno-common the default then many programs will not build any more,
including the Linux kernel. :-)

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
