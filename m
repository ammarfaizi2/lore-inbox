Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270022AbTHOQzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270148AbTHOQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:12:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267724AbTHOQJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:02 -0400
Subject: Re: Trying to run 2.6.0-test3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0daa01c36330$50e76d70$1aee4ca5@DIAMONDLX60>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
	 <1060937593.604.14.camel@teapot.felipe-alfaro.com>
	 <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60>
	 <1060948426.589.3.camel@teapot.felipe-alfaro.com>
	 <0daa01c36330$50e76d70$1aee4ca5@DIAMONDLX60>
Content-Type: text/plain
Message-Id: <1060959729.744.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 17:02:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 15:20, Norman Diamond wrote:

> > > Guess why I compiled it without ACPI support and with APM support.  Guess
> > > why my kernel command line has acpi=off apm=on.  (Although the command line
> > > options are redundant with the self-compiled kernel configuration, they are
> > > necessary when booting a generic kernel.  Yes I know that the machine has
> > > just enough ACPI hooks to cause problems when anyone other than Windows 98
> > > tries to use ACPI.  It's not even recommended to force ACPI on when
> > > installing Windows 98 on this machine.  Windows 2000 blue screens if ACPI is
> > > forced on.  Linux doesn't panic when its default ACPI takes over, but it
> > > does prevent APM from working.)
> >
> > If you turn ACPI on, you won't need APM support.
> 
> WRONG.  ACPI DOESN'T WORK ON THE MACHINE I'M DOING THIS ON.  DID
> YOU TRY READING WHAT YOU QUOTED THERE?  Yes I know you volunteer
> more effort on Linux than I do, but you're asking me to flame you anyway.
> How many times do you need to be told?

Yes, I tried reading. You said Linux doesn't panic while using ACPI, so
I supposed ACPI just worked but the problem was you wanted APM support.

> > To be sincere, I don't know exactly why "pci=usepirqmask" needs to be
> > used. I'm no hardware expert. But I know that I needed it when I wasn't
> > using ACPI.
> 
> Hmm.  Then some dependency seems to be broken in kernel compilation.  When
> ACPI is not compiled in, it should know that the effect of "pci=usepirqmask"
> should be compiled in (whatever that effect is).

It's not a problem with dependencies. On ACPI-enabled kernels, you using
ACPI routing. If you boot using "acpi=off", then you're using standard
PCI routing and that, in turn, on same machines, it warns you to use
"pci=usepirqmask". Don't know why, on some machines using standard PCI
routing, you don't need to boot with "pci=usepirqmask". I suppose it
will be some kind of hardware incompatibility or a bad implementation.


