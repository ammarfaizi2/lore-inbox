Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbRFKDaQ>; Sun, 10 Jun 2001 23:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbRFKDaH>; Sun, 10 Jun 2001 23:30:07 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263375AbRFKD3x>; Sun, 10 Jun 2001 23:29:53 -0400
Date: Sun, 10 Jun 2001 20:29:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aron Lentsch <lentsch@nal.go.jp>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: IRQ problems on new Toshiba Libretto
In-Reply-To: <Pine.LNX.4.21.0106111107270.1065-100000@triton.nal.go.jp>
Message-ID: <Pine.LNX.4.21.0106102026290.2599-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Jun 2001, Aron Lentsch wrote:
> 
> dump_irq returns the following:
> -----------------------------------------------------------------------
> No PCI interrupt routing table was found.

Hey, you don't have a pirq table, no wonder Linux cannot find the
information.

It's probably an ACPI-only system - rather uncommon, but I bet it will
become fairly common especially in laptops with WindowsME and higher only.

There's a ACPI dump utility in the ACPI tools, that might give people some
idea on what's up. Right now Linux ACPI only does irq routing on ia64, if
I remember correctly, so ACPI per se won't fix the problem, but it would
definitely be the next thing to look at.

Oh, well..

		Linus

