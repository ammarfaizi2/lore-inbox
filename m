Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278017AbRJIWVP>; Tue, 9 Oct 2001 18:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278016AbRJIWVB>; Tue, 9 Oct 2001 18:21:01 -0400
Received: from [213.97.184.209] ([213.97.184.209]:128 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S278015AbRJIWUN> convert rfc822-to-8bit;
	Tue, 9 Oct 2001 18:20:13 -0400
Date: Wed, 10 Oct 2001 00:20:32 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Dan Hollis <goemon@anime.net>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
In-Reply-To: <Pine.LNX.4.30.0110091435540.17874-100000@anime.net>
Message-ID: <Pine.LNX.4.33.0110100011350.446-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Dan Hollis wrote:

> On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > On Tue, 9 Oct 2001, Dan Hollis wrote:
> > > On Tue, 9 Oct 2001, German Gomez Garcia wrote:
> > > > it appears in the /proc/cmdline that message stills apears.
> > > > Also I'm unable to get correct readings with lm_sensors (CVS), I've been
> > > > enable to detect the w83781d chip using the i2c-amd756 SMbus but half of
> > > > the times the kernel hangs up when loading this module.
> > > 1) You need to enable ACPI in bios for sensors to work.
> > 	What about the kernel? must I enable it there too?
>
> No. You don't need it in kernel.

	Well, I must include it in the kernel to make it work, if I don't
it detects a w83627hf instead of the w83782d, and it is unable to set it
up on the bus:

i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.6.1 (20010830)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83627HF chip] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 0).
i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 1).
i2c-core.o: client [W83627HF subclient] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 2).
i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 3).
w83781d.o: Subclient 0 registration at address 0x49 failed.

	then I get incorrect readings for the every sensors 1 goes up to
77º, 2 goes down to 12º, and 3 goes really down to 0º

	If I include it in the kernel I get the following:

i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.6.1 (20010830)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83782D chip] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 0).
i2c-core.o: client [W83782D subclient] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 1).
i2c-core.o: client [W83782D subclient] registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 2).

	And after changing the type of the sensor to 2 (3904 transistor)
it works perfectly, no temp offset, at least it reports the same than the
BIOS (well I cannot be sure of that, but it doesn't differ more than one
or two degrees).

	Yeaahh!! that's outstanding online support, anybody still think
that paid support is better than friendly penguins? :-D
	I'll start burn-testing this box now that I have some way to
check temperature.

	Regards and great thanks!

	- german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

