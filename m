Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136480AbRAMFIc>; Sat, 13 Jan 2001 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136490AbRAMFIV>; Sat, 13 Jan 2001 00:08:21 -0500
Received: from mailer.psc.edu ([128.182.58.100]:31242 "EHLO mailer.psc.edu")
	by vger.kernel.org with ESMTP id <S136480AbRAMFII>;
	Sat, 13 Jan 2001 00:08:08 -0500
Date: Sat, 13 Jan 2001 00:08:06 -0500 (EST)
From: John Heffner <jheffner@psc.edu>
To: Rob Landley <telomerase@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
In-Reply-To: <20010113035314.316.qmail@web5205.mail.yahoo.com>
Message-ID: <Pine.NEB.4.05.10101130001240.25129-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> dd says it completes happily even when copying from
> random.  0+100 records in, 0+100 records out.  It

This means that dd completed 100 reads, and none of them were of the
requested length (10000 bytes).

> takes about thirty seconds to finish on the dual
> gigahertz processor intel box I'm using to test it,
> which implies it's actually performing the truly
> impressive waste of CPU cycles I'm requesting from it.
>  I'm just not getting the data in my file.

/dev/random generates (hopefully) truly random values, and relies on
receiving interrupts.  It doesn't spend very many CPU cycles.  For most
purposes, /dev/urandom is adequate, and will be much faster for such large
quantities of data.

  -John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
