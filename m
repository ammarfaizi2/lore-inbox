Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318938AbSH1T75>; Wed, 28 Aug 2002 15:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSH1T74>; Wed, 28 Aug 2002 15:59:56 -0400
Received: from kim.it.uu.se ([130.238.12.178]:8610 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318938AbSH1T7y>;
	Wed, 28 Aug 2002 15:59:54 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.11451.335811.149069@kim.it.uu.se>
Date: Wed, 28 Aug 2002 22:04:11 +0200
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.32 doesn't beep?
In-Reply-To: <20020828150522.A13090@ucw.cz>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
	<15724.51593.23255.339865@kim.it.uu.se>
	<20020828150522.A13090@ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik writes:
 > On Wed, Aug 28, 2002 at 03:00:56PM +0200, Mikael Pettersson wrote:
 > 
 > > Linus Torvalds 2.5.32 announcement:
 > >  > ... The input layer switch-over may also end up being a bit painful
 > >  > for a while, since that not only adds a lot of config options that you
 > >  > have to get right to have a working keyboard and mouse (we'll fix that
 > >  > usability nightmare), but the drivers themselves are different and there
 > >  > are likely devices out there that depended on various quirks.
 > > 
 > > I've noticed that in 2.5.32 with CONFIG_KEYBOARD_ATKBD=y, the kernel no
 > > longer beeps via the PC speaker. Both (at the console) hitting DEL or BS
 > > at the start of input or doing a simple echo ^G are now silent.
 > > 
 > > Call me old-fashioned, but I want those beeps back :-)
 > 
 > 2.5.32 still has quite complex input core config options - sorry, my
 > fault, and I'll fix it soon. You have to enable CONFIG_INPUT_MISC and
 > CONFIG_INPUT_PCSPKR.

That worked. Thanks.

Another issue: I enabled CONFIG_INPUT_MOUSEDEV_PSAUX, but /dev/psaux
gave an ENODEV when opened. Turns out CONFIG_INPUT_MOUSEDEV is
also required, but for some reason 'make config' let me set the
former without also setting the latter. A bug in input's config.in?

/Mikael
