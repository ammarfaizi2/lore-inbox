Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVBQOVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVBQOVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVBQOVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:21:02 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11165 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S262154AbVBQOUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:20:52 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050216213508.GD3001@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz>
	 <1108578892.2994.2.camel@localhost>  <20050216213508.GD3001@ucw.cz>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 15:19:53 +0100
Message-Id: <1108649993.2994.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 16.02.2005, 22:35 +0100 schrieb Vojtech Pavlik:
> On Wed, Feb 16, 2005 at 07:34:52PM +0100, Kenan Esau wrote:
> 
> > > > +
> > > > +        /* 
> > > > +           Enable absolute output -- ps2_command fails always but if
> > > > +           you leave this call out the touchsreen will never send
> > > > +           absolute coordinates
> > > > +        */ 
> > > > +        param = 0x07;
> > > > +        ps2_command(ps2dev, &param, PSMOUSE_CMD_SETRES);
> > > 
> > > Have you checked whether really the touchscreen sends a 0xfe error back,
> > > or some other value, or timeout? i8042.debug=1 is your friend here.
> > 
> > Yes the answer is 0xfe. 
> 
> Would you be so kind to post the 'dmesg' log?

Shure -- here you are...

...
input: LBPS/2 Fujitsu Lifebook TouchScreen on isa0060/serio1
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78488524]
drivers/input/serio/i8042.c: f5 -> i8042 (parameter) [78488524]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78488532]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78488753]
drivers/input/serio/i8042.c: ff -> i8042 (parameter) [78488753]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78488759]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux, 12) [78488822]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [78488823]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489004]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [78489004]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489009]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489009]
drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [78489009]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [78489014]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489014]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [78489014]
drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12) [78489018]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489216]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [78489216]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489218]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489219]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [78489219]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489223]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489223]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [78489223]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489228]
drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489229]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [78489229]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux, 12) [78489233]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, kbd, 1) [78494505]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, kbd, 1) [78494603]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [78494680]
...


