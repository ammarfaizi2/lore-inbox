Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268965AbRG0UoQ>; Fri, 27 Jul 2001 16:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRG0UoH>; Fri, 27 Jul 2001 16:44:07 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:9228 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S268962AbRG0Unx> convert rfc822-to-8bit; Fri, 27 Jul 2001 16:43:53 -0400
Date: Fri, 27 Jul 2001 22:41:31 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Tape corruption - update
In-Reply-To: <Pine.LNX.4.05.10107270943580.620-100000@callisto.of.borg>
Message-ID: <20010727221848.F1554-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 27 Jul 2001, Geert Uytterhoeven wrote:

> On Fri, 20 Jul 2001, Gérard Roudier wrote:
> > On Fri, 20 Jul 2001, Geert Uytterhoeven wrote:
> > > The problem is indeed introduced by the changes to the Sym53c8xx in 2.2.18-pre1.
> > > I managed to find some intermediate versions in the 2.3.x series, and here are the
> > > results:
> > >   - sym53c8xx-1.3g (from BK linuxppc_2_2): OK
> > >   - sym53c8xx-1.5e: crash in SCSI interrupt during driver init
> > >   - sym53c8xx-1.5f: lock up during driver init
> > >   - sym53c8xx-1.5g: random 32-byte error bursts when writing to tape
> >
> > That's an interesting result. But 1.5g - 1.3g diffs are probably very
> > large. Patches available from ftp.tux.org should allow to resurrect
> > driver versions 1.4, 1.5, 1.5a, 1.5b, 1.5c, 1.5d.
> >
> > ftp://ftp.tux.org/pub/roudier/drivers/linux/sym53c8xx/README
> >
> > You may, for example, apply incremental patches that address kernel 2.2.5
> > to a fresh kernel 2.2.5 tree and extract driver files accordingly.
>
> Thanks!
>
> With some small modifications, I made 1.5a to work fine. No error burst. So the
> problem is introduced between 1.5a and 1.5g.

Fine! But diffs between 1.5a and 1.5g are still large. :(
Results with 1.5c would have divided the diffs by about 2. :(

> Unfortunately my DDS-1 drive seems to have died for real after this test :-(
> I don't know yet whether I will replace it with a new tape drive or with a
> CD-RW. Which means I may never find out which change caused the problem...

I expect the problem to pong again to me. For now, I plan to look into the
1.5g-1.5a source diffs and inspect each change. But as I will be in
vacation for the next two weeks, I will not be able to work on this
problem immediately.

> I assume other people suffer from the same error burst problem, but they never
> notice until they really want to restore data. Me myself only notived it by
> accident, too.

Thanks for your testings and results.

Regards,
  Gérard.

