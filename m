Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTK3JHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTK3JHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:07:50 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:3771 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262375AbTK3JHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:07:48 -0500
Date: Sun, 30 Nov 2003 10:07:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sean Callanan <spyffe@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [MOUSE] "Virtual PC" mouse no longer works
Message-ID: <20031130090740.GA17190@ucw.cz>
References: <3FC99B0B.6010701@cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC99B0B.6010701@cs.sunysb.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 02:23:55AM -0500, Sean Callanan wrote:
> Dear mailing list,
> 
> I'm running Debian inside Connectix Virtual PC 6.0.1. This software 
> simulates Pentium-based hardware on a Macintosh. It lets the guest OS 
> "captue" the Macintosh mouse - when the guest OS wants to use the mouse, 
> the Macintosh pointer disappears and the guest OS receives mouse events. 
> This is done using a virtual PS/2 device.
> 
> This functionality works with the following kernels (with relevant 
> configuration options). They are stock Debian kernels.
> 
> 2.2.20:
>    CONFIG_MOUSE=y
>    CONFIG_PSMOUSE=y
> 2.4.18:
>    CONFIG_PSMOUSE=y
> 
> The mouse is free until X starts up (getting mouse events from 
> /dev/psaux) and is then "captured" and usable in X. But with 
> 2.6.0-test11, this functionality is broken. The relevant parameters in 
> my .config are:
> 
>    CONFIG_INPUT=y
>    CONFIG_INPUT_MOUSEDEV=y
>    CONFIG_INPUT_MOUSEDEV_PSAUX=y
>    CONFIG_INPUT_MOUSE=y
>    CONFIG_MOUSE_PS2=y
>    CONFIG_BUSMOUSE=y
> 
> I have tried:
>  1) Using /dev/input/mice and /dev/psaux in my XF86Config
>  2) Passing psmouse_noext=1 to the kernel
> Neither gave any success.
> 
> Please cc: me on any replies as I am not subscribed. Thank you for your 
> time.

Enable DEBUG in drivers/input/serio/i8042.c and look at dmesg output
(and send it to me, too). There one can see what went wrong, what's
not being emulated correctly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
