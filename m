Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263041AbSJBLAP>; Wed, 2 Oct 2002 07:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263045AbSJBLAO>; Wed, 2 Oct 2002 07:00:14 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:18837 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S263041AbSJBLAN>; Wed, 2 Oct 2002 07:00:13 -0400
Message-Id: <200210021101.g92B18mI000182@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 2 Oct 2002 07:01:00 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Krishnakumar B <kitty@cse.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard problems with Linux-2.5.40
References: <15770.24570.170414.576715@samba.doc.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15770.24570.170414.576715@samba.doc.wustl.edu>; from kitty@cse.wustl.edu on Tue, Oct 01, 2002 at 09:54:50PM -0500
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Wed, 2 Oct 2002 06:05:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krishnakumar B wrote:
> 
> I am using a MS Natural Pro Keyboard with a PS/2 adapter (if I use it as a
> USB keyboard I am not able to use it to select the kernel to load i.e use
> the keyboard before the kernel is loaded, anybody know how to get around
> this ? ) under Linux-2.5.40. I have mapped the multimedia keys available

Have you enabled USB Keyboard Support in your BIOS?

> under this keyboard to start some applications under X. I am having
> problems with a couple of keys being unrecognized and one key producing
> duplicate behaviour as another. Specifically, I have the following in my
> .xmodmaprc file:
> 
> /----[ .xmodmap-samba ]
>
> | keycode 174 = XF86AudioLowerVolume

> | keycode 178 = XF86HomePage

> | keycode 231 = XF86Refresh

> | keycode 237 = XF86AudioMedia
> \----
> 
> I get the following in my kernel logs when I press XF86AudioMedia or
> XF86Refresh. And the window manager doesn't do anything i.e it doesn't
> start XMMS or reload the page under the browser
> 
> atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
> atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
> atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
> atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
> 
> Also when I press XF86AudioLowerVolume, I get the same behaviour as
> XF86HomePage i.e another instance of the browser is started. All other keys
> work fine.
> 
> Can someone help me with this annoying problem ? Is there any package that
> I should upgrade ? Have the keycodes for this keyboard changed with the new
> kernel or have I miscompiled the kernel ? None of these problems occur with
> Linux-2.4.19.

The scancodes have changed.  Try adding keycode 336 = XF86AudioMedia and
keycode 288 = XF86Refresh.  If that works then remove any others you have
problems with, press the buttons to see the unknown scancode reported as
above to find out what it is, then add it back correctly with the new
code.

-- 
Skip
