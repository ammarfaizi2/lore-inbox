Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTF1JW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 05:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTF1JW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 05:22:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:27836 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265125AbTF1JW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 05:22:56 -0400
Date: Sat, 28 Jun 2003 11:37:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?Terje_F=E5berg?= <terje_fb@yahoo.no>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73 - keyboard failure, repost no. 3
Message-ID: <20030628113711.A18633@ucw.cz>
References: <20030627210346.C11454@ucw.cz> <20030628091154.78663.qmail@web12903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030628091154.78663.qmail@web12903.mail.yahoo.com>; from terje_fb@yahoo.no on Sat, Jun 28, 2003 at 11:11:54AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 11:11:54AM +0200, Terje Fåberg wrote:
> Vojtech Pavlik <vojtech@suse.cz> skrev:
> 
> > When I was saying drivers/input/serio/i8042.c, I
> > meant that. NOT atkbd.c. Although that also does
> > provide some info,  it's not all of it.
> 
> Please excuse me, if was wasting your time here.
> Indeed I had defined DEBUG in i8042.c but not
> _before_ the inclusion of i8024.h.  Damn.
> 
> Unfortunately scrolling is of course not possible, so
> to see as much of the debug output from i8042 as
> possible I had to undefine ATKBD_DEBUG in atkbd 
> again. This is what I can get now.  Unfortunately this
> device does not have a serial port, so serial console 
> is not an option.
> 
> I won't be able to get my hands on a USB keyboard 
> until Tuesday, but then I can send you the whole 
> output.

Thanks for this dump. I hope you didn't have to copy it all by hand,
though it seems so ...

> ...
> i8042.c: 60 -> i8042 (command) [18]
> i8042.c: 02 -> i8042 (parameter) [18]
> i8042.c: 92 -> i8042 (command) [18]
> i8042.c: f2 -> i8042 (parameter) [18]
> i8042.c: fa <- i8042 (interrupt, aux2, 12) [31]
> i8042.c: 00 <- i8042 (interrupt, aux2, 12) [32]
> i8042.c: 60 -> i8042 (command) [35]
> i8042.c: 00 -> i8042 (parameter) [33]
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> i8042.c: 60 -> i8042 (command) [33]
> i8042.c: 00 -> i8042 (parameter) [33]
> i8042.c: 60 -> i8042 (command) [34]
> i8042.c: 02 -> i8042 (parameter) [34]
> i8042.c: 93 -> i8042 (command) [34]
> i8042.c: f2 -> i8042 (parameter) [34]
> i8042.c: fe <- i8042 (interrupt, aux3, 12) [36]
> i8042.c: 93 -> i8042 (command) [36]
> i8042.c: ed -> i8042 (command) [36]
> i8042.c: fe <- i8042 (interrupt, aux3, 12) [37]
> i8042.c: 60 -> i8042 (command) [37]
> i8042.c: 00 -> i8042 (parameter) [37]
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> i8042.c: 60 -> i8042 (command) [37]
> i8042.c: 00 -> i8042 (parameter) [37]
> i8042.c: 60 -> i8042 (command) [38]
> i8042.c: 01 -> i8042 (parameter) [38]
> i8042.c: f2 -> i8042 (kbd-data) [38]
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [40]
> i8042.c: ab <- i8042 (interrupt, kbd, 1) [45]
> i8042.c: 83 <- i8042 (interrupt, kbd, 1) [46]
> i8042.c: ed -> (kbd-data) [46] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [47]
> i8042.c: 00 -> (kbd-data) [47] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [49]
> i8042.c: f8 -> (kbd-data) [49] 
> i8042.c: fe <- i8042 (interrupt, kbd, 1) [49]
> i8042.c: f4 -> (kbd-data) [49] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [50]
> i8042.c: f0 -> (kbd-data) [50] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [51]
> i8042.c: 02 -> (kbd-data) [51] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [51]
> i8042.c: f0 -> (kbd-data) [51] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [52]
> i8042.c: 00 -> (kbd-data) [52] 
> i8042.c: fa <- i8042 (interrupt, kbd, 1) [53]
> i8042.c: 02 <- i8042 (interrupt, kbd, 1) [54]
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> ...

So, no more interrupts no more log lines, nothing when you try to press
keys after the last line?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
