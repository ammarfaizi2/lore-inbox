Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSGMJES>; Sat, 13 Jul 2002 05:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSGMJER>; Sat, 13 Jul 2002 05:04:17 -0400
Received: from surf.viawest.net ([216.87.64.26]:65164 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S318130AbSGMJEP>;
	Sat, 13 Jul 2002 05:04:15 -0400
Date: Sat, 13 Jul 2002 02:07:02 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020713090702.GA1094@wizard.com>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com> <1026547292.1224.132.camel@psuedomode> <1026549957.1224.136.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026549957.1224.136.camel@psuedomode>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 1:50am  up 14 min,  2 users,  load average: 0.15, 0.10, 0.08
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 04:45:56AM -0400, Ed Sweetman wrote:
> Nope, failure.  I'm not getting any reaction from the kernel at all
> about the keyboard.  I'm including my config 
> 
> 

        You have network support compiled in. Are you able to get into the box 
remotely (ssh, telnet, etc)? If so, get onto the box, and mail me the output 
of `cat /proc/interrupts. I'd like to confirm something that's on my end as 
well. my guess is that  IRQ 1 is not listed. Another thing I should mention: 
I'm encountering this problem with 2.5.25, though I reported this in the 
2.5.20-dj tree. Vanilla 2.5.25 still has the legacy API there, so I'm able to 
fall back on that. I haven't run a -dj kernel since 2.5.20-dj3. 

> CONFIG_INPUT=y
> #
> # Userland interfaces
> #
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> CONFIG_SERIO=y
> # CONFIG_SERIO_I8042 is not set

        IIRC, CONFIG_SERIO_I8042 must be set for you to have a keyboard 
present. This is the chipset that the keyboard and mouse use. This has to be 
set to y.

> CONFIG_I8042_REG_BASE=60
> CONFIG_I8042_KBD_IRQ=1
> CONFIG_I8042_AUX_IRQ=12

        Rest looks fine. give that a go, and see what you get.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

