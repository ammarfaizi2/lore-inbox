Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262175AbSJAQsv>; Tue, 1 Oct 2002 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJAQrX>; Tue, 1 Oct 2002 12:47:23 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21647 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262173AbSJAQqb>;
	Tue, 1 Oct 2002 12:46:31 -0400
Date: Tue, 1 Oct 2002 18:51:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Skip Ford <skip.ford@verizon.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
Message-ID: <20021001185154.A13641@ucw.cz>
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz> <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Tue, Oct 01, 2002 at 12:49:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 12:49:08PM -0400, Skip Ford wrote:
> Vojtech Pavlik wrote:
> > On Tue, Oct 01, 2002 at 11:32:02AM -0400, Skip Ford wrote:
> > > Vojtech Pavlik wrote:
> > > 
> > > setkeycodes rejects it.
> > > 
> > > I changed setkeycodes.c to add 256 instead of 128 and bumped up the
> > > bounds checking, but it's still strange.  It now works for e063, but
> > > still doesn't work for e05e.  Many other keys in the same area as 0x5e
> > > don't work.  The only one that does work that I tried is e063.
> > 
> > There is another thing that has changed - the scancode numbers. So if
> > you're using the same commands as on 2.4, you're setting scancodes for
> > different keys. We now use 'at keyboard - set 2' scancodes as opposed to
> > 'xt keyboard - set 1' used by the older driver. See the 'dmesg' output
> > for keys ("unknown scancode ...") that are not known to the keyboard
> > driver.
> 
> showkey is still showing me the same scancodes.

The raw mode showkey -s is now using to show scancodes is completely
simulated by the kernel.

> The new AT driver
> doesn't log any 'unknown scancode' messages for the same buttons the
> old XT driver did.

That means it understands them. If it did not, showkey -s wouldn't work.

> > > Will you be releasing an updated kbd package?
> > 
> > Well, I'm not the maintainer of the kbd package, but I probably will
> > have to release a new tool to set the keycode table.
> 
> Sorry about that.  Didn't mean to volunteer you.  Thanks for all your
> help.  I'll try to verify the scancodes I'm using.

Just update the keymap - you don't need to change the scancode table if
the keys are working.

-- 
Vojtech Pavlik
SuSE Labs
