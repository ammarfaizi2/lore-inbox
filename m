Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTDNHSw (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 03:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTDNHSw (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 03:18:52 -0400
Received: from gate.perex.cz ([194.212.165.105]:28431 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262792AbTDNHSv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 03:18:51 -0400
Date: Mon, 14 Apr 2003 09:28:48 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Adam Belay <ambx1@neo.rr.com>
Subject: Re: BUG: sleeping function called from illegal context
In-Reply-To: <200304132131.03545.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.44.0304140926210.1255-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003, Daniel Ritz wrote:

> i saw that one after modprobe snd-sb16...
> kernel 2.5.67-bk
> 
> rgds
> -daniel
> 
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1664
> Call Trace:
>  [<c0120777>] __might_sleep+0x5f/0x68
>  [<c0148f35>] kmalloc+0x61/0x174
>  [<c01292f7>] __request_region+0x1b/0xb4
>  [<c01293aa>] __check_region+0x1a/0x40
>  [<c01dc533>] pnp_check_port+0x5f/0x13c

Adam, could you consider to use mutexes rather than spinlocks in your 
code? I think that the pnp configuration is not time critical.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

