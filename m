Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbSJAQqF>; Tue, 1 Oct 2002 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbSJAQpC>; Tue, 1 Oct 2002 12:45:02 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:58604 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S262160AbSJAQoA>; Tue, 1 Oct 2002 12:44:00 -0400
Message-Id: <200210011649.g91GnDfG000953@pool-141-150-241-241.delv.east.verizon.net>
Date: Tue, 1 Oct 2002 12:49:08 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDSETKEYCODE work with new input layer?
References: <200209301440.g8UEeBOp000435@pool-141-150-241-241.delv.east.verizon.net> <20021001115413.B9131@ucw.cz> <200210011231.g91CVCdG000289@pool-141-150-241-241.delv.east.verizon.net> <20021001151722.A11750@ucw.cz> <200210011532.g91FW4fG000308@pool-141-150-241-241.delv.east.verizon.net> <20021001174129.A12995@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021001174129.A12995@ucw.cz>; from vojtech@suse.cz on Tue, Oct 01, 2002 at 05:41:29PM +0200
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop017.verizon.net from [141.150.241.241] at Tue, 1 Oct 2002 11:49:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 01, 2002 at 11:32:02AM -0400, Skip Ford wrote:
> > Vojtech Pavlik wrote:
> > 
> > setkeycodes rejects it.
> > 
> > I changed setkeycodes.c to add 256 instead of 128 and bumped up the
> > bounds checking, but it's still strange.  It now works for e063, but
> > still doesn't work for e05e.  Many other keys in the same area as 0x5e
> > don't work.  The only one that does work that I tried is e063.
> 
> There is another thing that has changed - the scancode numbers. So if
> you're using the same commands as on 2.4, you're setting scancodes for
> different keys. We now use 'at keyboard - set 2' scancodes as opposed to
> 'xt keyboard - set 1' used by the older driver. See the 'dmesg' output
> for keys ("unknown scancode ...") that are not known to the keyboard
> driver.

showkey is still showing me the same scancodes.  The new AT driver
doesn't log any 'unknown scancode' messages for the same buttons the
old XT driver did.

> > Will you be releasing an updated kbd package?
> 
> Well, I'm not the maintainer of the kbd package, but I probably will
> have to release a new tool to set the keycode table.

Sorry about that.  Didn't mean to volunteer you.  Thanks for all your
help.  I'll try to verify the scancodes I'm using.

-- 
Skip
