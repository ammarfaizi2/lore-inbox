Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSGMJ3y>; Sat, 13 Jul 2002 05:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318134AbSGMJ3x>; Sat, 13 Jul 2002 05:29:53 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43970 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318133AbSGMJ3x>;
	Sat, 13 Jul 2002 05:29:53 -0400
Date: Sat, 13 Jul 2002 11:32:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Ed Sweetman <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020713113236.A29227@ucw.cz>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode> <20020713090702.GA1094@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020713090702.GA1094@wizard.com>; from tyketto@wizard.com on Sat, Jul 13, 2002 at 02:07:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 02:07:02AM -0700, A Guy Called Tyketto wrote:

> On Sat, Jul 13, 2002 at 04:45:56AM -0400, Ed Sweetman wrote:
> > Nope, failure.  I'm not getting any reaction from the kernel at all
> > about the keyboard.  I'm including my config 
> 
>         You have network support compiled in. Are you able to get into the box 
> remotely (ssh, telnet, etc)? If so, get onto the box, and mail me the output 
> of `cat /proc/interrupts. I'd like to confirm something that's on my end as 
> well. my guess is that  IRQ 1 is not listed. Another thing I should mention: 
> I'm encountering this problem with 2.5.25, though I reported this in the 
> 2.5.20-dj tree. Vanilla 2.5.25 still has the legacy API there, so I'm able to 
> fall back on that.

Vanilla 2.5.25 still uses the original driver even if the new one was
enabled. It isn't removed there. If both are enabled, they won't work.

-dj trees have the old driver removed, so the new one can work. In
2.5.26 (or http://linux-input.bkbits.net:8080/linux-input) the new
driver config option will disable the old one.

> I haven't run a -dj kernel since 2.5.20-dj3. 
> 
> > CONFIG_INPUT=y
> > #
> > # Userland interfaces
> > #
> > CONFIG_INPUT_KEYBDEV=y
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_EVDEV=y
> > # CONFIG_INPUT_EVBUG is not set
> > 
> > CONFIG_SERIO=y
> > # CONFIG_SERIO_I8042 is not set
> 
>         IIRC, CONFIG_SERIO_I8042 must be set for you to have a keyboard 
> present. This is the chipset that the keyboard and mouse use. This has to be 
> set to y.
> 
> > CONFIG_I8042_REG_BASE=60
> > CONFIG_I8042_KBD_IRQ=1
> > CONFIG_I8042_AUX_IRQ=12
> 
>         Rest looks fine. give that a go, and see what you get.

-- 
Vojtech Pavlik
SuSE Labs
