Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTHONYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275926AbTHONYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:24:03 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:21195 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263738AbTHONXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:23:31 -0400
Message-ID: <0daa01c36330$50e76d70$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <1060937593.604.14.camel@teapot.felipe-alfaro.com> <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60> <1060948426.589.3.camel@teapot.felipe-alfaro.com>
Subject: Re: Trying to run 2.6.0-test3
Date: Fri, 15 Aug 2003 22:20:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> replied to me:

> > "seems to be a result of compiling the new modules packages manually at a
> > time when I could not persuade the rpm --rebuild command to target the
> > correct cpu."  Yes, "the new modules packages" meant the new modules
> > packages.  I did have to ask about this at the beginning of -test1 days.  (I
> > never had time to try testing a 2.5 kernel but the appearance of 2.6.0-test1
> > made it look like testing would become valuable.)
>
> I can't understand why manually compiling modules (make modules) could
> cause you problems that "rpm --rebuild" couldn't.

Manually compiling the two items that are contained in the rpm (modutils and
module-init-tools) did indeed give different problems from "rpm --rebuild".
I reported them around two weeks ago or so.  "make modules" has nothing to
do with this.

> > > > Kernel command line: acpi=off apm=on root=/dev/hda8
> > >
> > > I suggest you to recompile your kernel with ACPI support to see if it
> > > works correctly. Else, recompile it disabling ACPI support and enabling
> > > APM support.
> >
> > Guess why I compiled it without ACPI support and with APM support.  Guess
> > why my kernel command line has acpi=off apm=on.  (Although the command line
> > options are redundant with the self-compiled kernel configuration, they are
> > necessary when booting a generic kernel.  Yes I know that the machine has
> > just enough ACPI hooks to cause problems when anyone other than Windows 98
> > tries to use ACPI.  It's not even recommended to force ACPI on when
> > installing Windows 98 on this machine.  Windows 2000 blue screens if ACPI is
> > forced on.  Linux doesn't panic when its default ACPI takes over, but it
> > does prevent APM from working.)
>
> If you turn ACPI on, you won't need APM support.

WRONG.  ACPI DOESN'T WORK ON THE MACHINE I'M DOING THIS ON.  DID
YOU TRY READING WHAT YOU QUOTED THERE?  Yes I know you volunteer
more effort on Linux than I do, but you're asking me to flame you anyway.
How many times do you need to be told?

> Well, ACPI has still some broken functionality, like S3 states,

S3 has nothing to do with it.  Whether and how much ACPI functionality the
vendor put in the BIOS has everything to do with it.  If you read what you
quoted from me, you might reach the same opinion I have, that it would have
been better for the vendor to include no ACPI functionality at all instead
of some experiments at partial ACPI support.  But even if you don't agree,
ACPI still doesn't work on that machine.

> To be sincere, I don't know exactly why "pci=usepirqmask" needs to be
> used. I'm no hardware expert. But I know that I needed it when I wasn't
> using ACPI.

Hmm.  Then some dependency seems to be broken in kernel compilation.  When
ACPI is not compiled in, it should know that the effect of "pci=usepirqmask"
should be compiled in (whatever that effect is).

> Probably, if you disable APM support and enable ACPI, you won't need to
> boot using "pci=usepirqmask".

Could be, but then I'll have no power management at all because ACPI doesn't
work but APM will disable itself when APM thinks that ACPI looks like it's
running.  How many times do you need to be told, guess why I did "acpi=off
apm=on".

