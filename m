Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269178AbRHLN02>; Sun, 12 Aug 2001 09:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269179AbRHLN0S>; Sun, 12 Aug 2001 09:26:18 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:65377 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S269178AbRHLN0G>;
	Sun, 12 Aug 2001 09:26:06 -0400
Message-ID: <20010812152625.A15275@win.tue.nl>
Date: Sun, 12 Aug 2001 15:26:25 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: marekm@amelek.gda.pl, linux-kernel@vger.kernel.org (kernel list)
Subject: Re: PC keyboard unknown scancodes (Power, Sleep, Wake)
In-Reply-To: <200108120721.JAA05389@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200108120721.JAA05389@green.mif.pg.gda.pl>; from Andrzej Krzysztofowicz on Sun, Aug 12, 2001 at 09:21:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 09:21:02AM +0200, Andrzej Krzysztofowicz wrote:
> > On Sat, Aug 11, 2001 at 08:51:46PM +0200, Marek Michalkiewicz wrote:
> > 
> > > these three keys (on a cheap no-name "Designed for Win*" keyboard ;)
> > > produce "unknown scancode" kernel messages when pressed or released.
> > > 
> > > Power - e0 5e
> > > Sleep - e0 5f
> > > Wake  - e0 63
> > 
> > You can use the setkeycodes command to tell the kernel about them.
> 
> It doesn't seem to fix the problem:
> 
> # dmesg -c
> # setkeycodes e05f 127
> # setkeycodes e05e 127
> # dmesg -c
> [ pressing some keys here ]
> # dmesg -c
> keyboard: unknown scancode e0 5e
> keyboard: unknown scancode e0 5e
> keyboard: unknown scancode e0 5f
> keyboard: unknown scancode e0 5f
> 
> Am I doing something wrong ?

Maybe you are using console-tools instead of kbd?
Check with strace that it does the KDSETKEYCODE ioctl.
