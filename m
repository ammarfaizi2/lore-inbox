Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbTIOVom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIOVom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:44:42 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:44676 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261658AbTIOVol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:44:41 -0400
Date: Mon, 15 Sep 2003 23:44:33 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: Olaf Hering <olh@suse.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
In-Reply-To: <20030915213430.GA1833@suse.de>
Message-ID: <Pine.LNX.4.44.0309152336110.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Sep 2003, Olaf Hering wrote:

> This is in the device tree, not very helpful. I'm not sure where XFree86
> gets the value 50. It seems to poke some regs here and there, havent
> looked too closely.

XFree86 uses backcalculation. So if Atyfb programs the chip at 50 MHz,
XFree86 will read 50 MHz back. So, 50 MHz is not necessary the right
frequency for your chip.

> [open firmware data]

Hmmm. No clocks here at the first sight.

> All I see is that 50 works, 125 gives black/white stripes and a large
> blinking cursor.

Hmmm. Catch-22; Geert's VAIO malfunctions at 50 MHz :/

We can do two things:

- Check the PLL registers at startup and determine your frequency.
- Ask ATi again.

I propose to do both. Please enable the debug define in atyfb_base.c, so
it will print PLL registers.

I'm going to write an e-mail to ATi devrel now, I will cc to all except
linux-kernel.

Greetings,

Daniël Mantione

