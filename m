Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbSLLMM7>; Thu, 12 Dec 2002 07:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbSLLMM7>; Thu, 12 Dec 2002 07:12:59 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:20866 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267473AbSLLMM6>;
	Thu, 12 Dec 2002 07:12:58 -0500
Date: Thu, 12 Dec 2002 13:20:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@ucw.cz>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Four function buttons on DELL Latitude X200
Message-ID: <20021212132017.A20122@ucw.cz>
References: <m3d6ocjd81.fsf@Janik.cz> <E18LBeK-00046y-00@calista.inka.de> <at2r5v$fib$1@cesium.transmeta.com> <20021210213444.GA451@elf.ucw.cz> <20021212094334.A1403@ucw.cz> <m3fzt35uh7.fsf@lugabout.jhcloos.org> <20021212125114.A10134@ucw.cz> <m3znrb4ejx.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3znrb4ejx.fsf@lugabout.jhcloos.org>; from cloos@jhcloos.com on Thu, Dec 12, 2002 at 07:17:22AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 07:17:22AM -0500, James H. Cloos Jr. wrote:
> >>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> Vojtech> Do they by any chance produce a kernel warning when pressed?
> 
> Yes, the two keys that do not generate an event in X syslog these errors:
> 
> atkbd.c: Unknown key (set 2, scancode 0x176, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x176, on isa0060/serio0) released.
> atkbd.c: Unknown key (set 2, scancode 0x11e, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x11e, on isa0060/serio0) released.
> 
> where 0x176 is the PLAY key and 0x11e is the PREV key.

You can edit atkbd.c, and at the beginning there is a big table, add
some reasonable keycodes (KEY_PLAY, KEY_PREV), to entries 0x11e and
0x176 in the table.

> Incidently, the FORWARD key is giving the same keycode as the main
> kb's Pause key.

Should be possible to fix at the same place.

(You can try to use 'setkeycode' for the same purpose in 2.5, but it
might and might not work.)

-- 
Vojtech Pavlik
SuSE Labs
