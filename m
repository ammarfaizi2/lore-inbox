Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131735AbQK2UT0>; Wed, 29 Nov 2000 15:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131720AbQK2UTR>; Wed, 29 Nov 2000 15:19:17 -0500
Received: from u-code.de ([207.159.137.250]:8947 "EHLO u-code.de")
        by vger.kernel.org with ESMTP id <S131735AbQK2UTK>;
        Wed, 29 Nov 2000 15:19:10 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
Organization: u-code
To: Mike Dresser <mdresser@windsormachine.com>, e.jokisch@u-code.de,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 test10 error reading from HP colorado 7/14 Gb tape
Date: Wed, 29 Nov 2000 20:44:43 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <3A24DDD1.D4731F6C@winealley.com> <00112912565800.21358@eckhard> <3A2532E0.F72BFB02@windsormachine.com>
In-Reply-To: <3A2532E0.F72BFB02@windsormachine.com>
MIME-Version: 1.0
Message-Id: <00112920502100.02808@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:
> I  reported this a few weeks ago or so, it seems that HP 7/14's are not exactly
> standard.  First is the proprietory tape size.  Second is that the drive doesn't
> support locking the tape in, but reports it as possible.  At least, that's what i
> gather from Jens's posting.
> 

I'm very much interested in what is the cause for this error.
> > > # tar -tvf  /dev/ht0
> > > ide-tape: ht0: I/O error, pc = 8, key = 5, asc = 2c, ascq = 0
> > >
In my case the driver tries some error-recovery three or four times before it
gives up.
On of the problems is - that these errors occure after having written several
GB to the tape - and that takes some hours. It also happend that with a tar
-cvM the first tape was ok but the second was unreadeable.

> > I experience the same with OnStream DI30 - but these errors occure in 2.2.17 as
> > well. In my oppinion they show up in fewer cases with 2.4-test10.
> > The error is not quite"stable" because it occures on different tape positions
> > (filenames) when I retension the tape three aor four times befor writing to it.
> >
> > I checked the tapes on a Windows machine and they seem to be o.k..
> >
> > Eckhard Jokisch
> > -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
