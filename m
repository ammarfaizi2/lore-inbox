Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbTCZIjE>; Wed, 26 Mar 2003 03:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbTCZIjE>; Wed, 26 Mar 2003 03:39:04 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59298 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261508AbTCZIjC>;
	Wed, 26 Mar 2003 03:39:02 -0500
Date: Wed, 26 Mar 2003 09:50:10 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Arne Koewing <ark@gmx.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] Synaptics touchpad with Trackpoint needs ps/2 reset
Message-ID: <20030326095010.A17442@ucw.cz>
References: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>; from ark@gmx.net on Tue, Mar 25, 2003 at 08:25:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:25:47AM +0100, Arne Koewing wrote:
> Hi!
> 
> I recently posted this to linux-kernel (with a different subject)
> I had included a wrong ptch there, i think this one is ok.

Do we really need RESET_BAT? Doesn't any other command help?

> As some people before I had the 'Dell trackpoint does not work' problem
> after upgrading to 2.5.XX:
> That was:
>      
> the trackpoint of your dell won't work until:
>     - hibernate and wake up the system again
>     - plug in an external mouse (you may remove it immediately)
> 
> it seems that dells hardware is disabling the trackpoint if you
> probed for the touchpad.
> A device reset after probing does help, but I've no idea how this
> would affect other synaptics touchpad devices although I think
> most devices will not complain about one extra reset.
> 
> 
>   Arne
> 
> 
> diff -bruN   linux-2.5.65-old/drivers/input/mouse/psmouse.c linux-2.5.65/drivers/input/mouse/psmouse.c 
> --- linux-2.5.65-old/drivers/input/mouse/psmouse.c      2003-03-05 04:29:03.000000000 +0100
> +++ linux-2.5.65/drivers/input/mouse/psmouse.c  2003-03-26 09:11:10.000000000 +0100
> @@ -345,6 +345,7 @@
>                    thing up. */
>                 psmouse->vendor = "Synaptics";
>                 psmouse->name = "TouchPad";
> +              psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
>                 return PSMOUSE_PS2;
>         }

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
