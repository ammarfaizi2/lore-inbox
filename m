Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269708AbUJAFnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269708AbUJAFnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 01:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269712AbUJAFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 01:43:24 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:62842 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S269708AbUJAFnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 01:43:13 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Date: Fri, 1 Oct 2004 07:43:10 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
References: <20040929214637.44e5882f.akpm@osdl.org> <200409302346.35214.petkov@uni-muenster.de> <200410010130.51769.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200410010130.51769.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410010743.11154.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 01:30, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 30 September 2004 23:46, Borislav Petkov wrote:
> > On Thursday 30 September 2004 18:25, Bartlomiej Zolnierkiewicz wrote:
> > > On Thursday 30 September 2004 17:32, Borislav Petkov wrote:
> > > > On Thursday 30 September 2004 14:52, Bartlomiej Zolnierkiewicz wrote:
> > > > > On Thursday 30 September 2004 06:46, Andrew Morton wrote:
> > > > > > ide broke :(   Maybe Bart's bk tree?
> > > > >
> > > > > no, disk works just fine ;)  If it is my tree I will happilly fix
> > > > > it.
> > > > >
> > > > > Borislav, could you apply only these patches from -mm4 and retest?
> > > > >
> > > > > linus.patch
> > > > > bk-ide-dev.patch
> > > > >
> > > > > > Begin forwarded message:
> > > > > >
> > > > > > Date: Wed, 29 Sep 2004 12:43:35 +0200
> > > > > > From: Borislav Petkov <petkov@uni-muenster.de>
> > > > > > To: Andrew Morton <akpm@osdl.org>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Subject: Re: 2.6.9-rc2-mm4
> > > > > >
> > > > > >
> > > > > > <snip>
> > > > > >
> > > > > > Hello,
> > > > > >  I've already posted about problems with audio extraction but it
> > > > > > went unnoticed. Here's a recount: When I attempt to read an audio
> > > > > > cd into wavs with cdda2wav, the process starts but after a while
> > > > > > the completion meter freezes and klogd says "hdc: lost interrupt"
> > > > > > and cdda2wav hangs itself. Disabling DMA doesn't help as well as
> > > > > > the boot option "pci=routeirq" too. Older kernels like 2.6.7 do
> > > > > > not show such behavior and there audio extraction runs fine.
> > > > > > Sysinfo attached.
> > > > > >
> > > > > > Regards,
> > > > > > Boris.
> > > >
> > > > Hi people,
> > > >
> > > >  well, I've applied the above patches but no change - same "hdc: lost
> > > > interrupt" message. 2.6.9-rc3 behaves the same, as expected.
> > >
> > > Well, if 2.6.9-rc3 fails then it is not my tree...
> > >
> > > Please find kernel version which introduces this bug.
> >
> > Just compiled 2.6.8.1 and tested audio extraction. The bug is there.
> > After that, reran the test with 2.6.7. Everything went fine. So it must
> > have been between 2.6.7 and 2.6.8.1 when the bug got introduced. Any
> > additional debugging options in the ATA/IDE cd driver i could turn on so
> > that I could get more verbose messages while executing cdda2wav?
>
> I'm not aware of any.  Jens?
>
> Just a guess but maybe SG_IO filtering is involved?
> Does cdda2wav work for a root user?
>
Actually, I ran all the tests only as root...
Should I continue testing with the 2.6.7 -mm series?

Regards,
Boris.
