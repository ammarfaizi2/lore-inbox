Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbSIZLcT>; Thu, 26 Sep 2002 07:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbSIZLcS>; Thu, 26 Sep 2002 07:32:18 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22657 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262436AbSIZLcS>;
	Thu, 26 Sep 2002 07:32:18 -0400
Date: Thu, 26 Sep 2002 13:37:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20020926133725.A8851@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet> <20020926105853.A168142@ucw.cz> <1033039991.708.6.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033039991.708.6.camel@chevrolet>; from liste@jordet.nu on Thu, Sep 26, 2002 at 01:32:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 01:32:59PM +0200, Stian Jordet wrote:

> > > Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
> > > out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
> > > it's dead. I have a Logitech cordless keyboard. 
> > > 
> > > Anyone else experienced this?
> > 
> > I fixed this in about 2.5.36. Please #define ATKBD_DEBUG in
> > drivers/input/keyboard/atkbd.c, and send me the kernel output just
> > before the crash, please. I'll try to reproduce it here meanwhile.
> 
> I'm added #define ATKBD_DEBUG right below all the other define's in
> atkbd.c, did a make clean; make dep; make bzImage and tried again. I
> can't see any difference. It still just prints "input: AT Set 2 keyboard
> on isa0060/serio0".

Hmm, have you looked into 'dmesg'? It prints the information with
KERN_DEBUG priority, which often won't make it on the screen or into the
logs ...

> I did, however, find out that if I press SHIFT+what
> ever of the buttons arrows, insert, home, page up/down, delete and end,
> I get just the same behaviour. It does not happen with CTRL or ALT.

Can you try passing 'i8042_direct' on the kernel command line to see if
it cures the problem? It looks like your keyboard is doing some very
strange 84-key-at-emulation, stranger than others do ...

> Thank you very much.

-- 
Vojtech Pavlik
SuSE Labs
