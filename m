Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSJCIm0>; Thu, 3 Oct 2002 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbSJCIm0>; Thu, 3 Oct 2002 04:42:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57554 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263204AbSJCImZ>;
	Thu, 3 Oct 2002 04:42:25 -0400
Date: Thu, 3 Oct 2002 10:47:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003104750.A37411@ucw.cz>
References: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>; from tori@ringstrom.mine.nu on Thu, Oct 03, 2002 at 08:59:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 08:59:30AM +0200, Tobias Ringstrom wrote:
> While 2.5 has worked better than I hoped for so far, I do have a problem 
> with the new input layer (I think) that is easily reproducible, and quite 
> irritating.
> 
> If I press and hold my left Alt key, press and release the right AltGr
> key, and then release the left Alt key, I get one of the following
> messages in dmesg:
> 
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> 
> The left Alt key is now stuck until I press and release it again.
> 
> The same thing happens for a few other combinations as well. I happens 
> both in X and in the console.
> 
> Please let me know if you need more info.

Yes, please try with #I8042_DEBUG_IO enabled, try all the suspicious key
combinations and add comments to the log file which is which. This will
allow me to fix it properly.

Thanks in advance. :)

-- 
Vojtech Pavlik
SuSE Labs
