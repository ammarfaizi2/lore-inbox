Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283740AbRK3SGl>; Fri, 30 Nov 2001 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283741AbRK3SGb>; Fri, 30 Nov 2001 13:06:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17926 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S283740AbRK3SGT>; Fri, 30 Nov 2001 13:06:19 -0500
Message-ID: <3C07C82D.A70BA43@evision-ventures.com>
Date: Fri, 30 Nov 2001 18:55:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: dalecki@evision.ag, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <E169rqb-0004G7-00@the-village.bc.nu> <3C07C4F9.A52C07F6@evision-ventures.com> <20011130180029.C19193@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Nov 30, 2001 at 06:42:17PM +0100, Martin Dalecki wrote:
> > serial.c should be hooked at the misc char device interface sooner or
> > later.
> 
> Please explain.  Especially contentrate on justifing why serial interfaces
> aren't a tty device.

No problem ;-).

There is the hardware: in esp. the serial controller itself - this
belongs
to misc, becouse a mouse for example doesn't have to interpret any tty
stuff
This animal belongs to the same cage as the PS/2 variant of it.
And then there is one abstraction level above it: the tty interface -
this belongs to a line discipline.

We have this split anyway already there /dev/ttyS0 and /dev/cua0 somehow
emulated on one level.

Understood?
