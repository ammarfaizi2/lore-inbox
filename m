Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSLLLoI>; Thu, 12 Dec 2002 06:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLLLoI>; Thu, 12 Dec 2002 06:44:08 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:64897 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262806AbSLLLoH>;
	Thu, 12 Dec 2002 06:44:07 -0500
Date: Thu, 12 Dec 2002 12:51:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@ucw.cz>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021212125114.A10134@ucw.cz>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz> <20021212094334.A1403@ucw.cz> <m3fzt35uh7.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3fzt35uh7.fsf@lugabout.jhcloos.org>; from cloos@jhcloos.com on Thu, Dec 12, 2002 at 06:48:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 06:48:04AM -0500, James H. Cloos Jr. wrote:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> Vojtech> The real question is, when we have these 16-bit (or more bit)
> Vojtech> keycodes, how do we export them to the userspace? In cooked
> Vojtech> mode, there is no problem, we can extend the keymaps. But
> Vojtech> both medium raw and raw modes are pretty much limited in the
> Vojtech> number of keys they can carry. See 2.5 keyboard.c for the
> Vojtech> current imperfect solution.
> 
> Vojtech> IMHO applications which now use raw mode should instead
> Vojtech> switch to using the event devices in /dev/input ...
> 
> In reference to this, until X is updated to do so, I'm curious about
> the changes in the multi-media keys on this i8100 between 2.4 and 2.5.
> 
> In 2.4, X sees these as the keycodes (in Xmodmap syntax):
> 
> ! the four keys at the top
> keycode 129 = XF86AudioPlay XF86AudioPause
> keycode 130 = XF86AudioStop
> keycode 131 = XF86AudioPrev
> keycode 132 = XF86AudioNext
> 
> ! the volume and mute keys;
> ! order is unknown because in 2.4 the smm system
> ! catches the keys before X or the kernel can.
> keycode 137 = F27
> keycode 138 = F28
> keycode 139 = F29
> 
> ! this happens when three keys are hit together
> ! it was causing my wm to open its menu, so I
> ! added the below line to force 135 to be ignored.
> keycode 135 = XF86Launch0
> 
> 
> In 2.5, those (as warned) change radically:
> 
> ! the four keys at the top
> keycode NONE = XF86AudioPlay XF86AudioPause
> keycode 162 = XF86AudioStop
> keycode NONE = XF86AudioPrev
> keycode 114 = XF86AudioNext
> ! the volume and mute keys;
> keycode 160 = XF86AudioMute
> keycode 174 = XF86AudioLowerVolume
> keycode 176 = XF86AudioRaiseVolume
> 
> It is cool that the volume keys become accessible, and no longer need
> to be run through the i8k kernel module.  But the loss of the play and
> prev buttons is curious.  Is there a way around that?

Do they by any chance produce a kernel warning when pressed?

-- 
Vojtech Pavlik
SuSE Labs
