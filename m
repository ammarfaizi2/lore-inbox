Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130572AbQK1D7I>; Mon, 27 Nov 2000 22:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130575AbQK1D67>; Mon, 27 Nov 2000 22:58:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33348 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S130572AbQK1D6q>; Mon, 27 Nov 2000 22:58:46 -0500
Date: Tue, 28 Nov 2000 04:28:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128042850.A29908@athlon.random>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net> <20001127182113.A15029@athlon.random> <20001127123655.A16930@munchkin.spectacle-pond.org> <20001127200618.A19980@athlon.random> <200011280310.MAA27358@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011280310.MAA27358@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Tue, Nov 28, 2000 at 12:10:33PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
> If you have two files:
> test1.c:
> int a,b,c;
> 
> test2.c:
> int a,c;
> 
> Which is _stronger_?

Those won't link together as they aren't declared static.

If they would been static they could be ordered file-per-file (note: I'm not
suggesting anything like that and I'm more than happy the compiler is allowed
to do sane optimizations with none downside :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
