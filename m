Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUBWWXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUBWWXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:23:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262057AbUBWWXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:23:20 -0500
Date: Mon, 23 Feb 2004 17:23:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Hunold <hunold@linuxtv.org>
cc: torvalds@osdl.org, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] Update the DVB subsystem docs
In-Reply-To: <10775702813893@convergence.de>
Message-ID: <Pine.LNX.4.53.0402231708440.4872@chaos>
References: <10775702813893@convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Michael Hunold wrote:

> +
> +Getting the card going
> +
> +   To  power  up  the  card,  load  the  following modules in the
> +   following order:
> +
> +     * insmod dvb-core.o
> +     * modprobe bttv.o
> +     * insmod bt878.o
> +     * insmod dvb-bt8xx.o
> +     * insmod sp887x.o
> +
> +   The  current version of the frontend module sp887x.o, contains
> +   no firmware drivers?, so the first time you open it with a DVB
> +   utility  the driver will try to download some initial firmware
> +   to  the card. You will need to download this firmware from the
> +   web,  or  copy  it from an installation of the Windows drivers
> +   that probably came with your card, before you can use it.
> +
> +   The  default  Linux  filesystem  location for this firmware is
> +   /usr/lib/hotplug/firmware/sc_main.mc .

What does this have to do with the kernel? Isn't this for some
utility that starts Aver/TV? Surely the kernel doesn't read files.

I run this same TV card in W$ and the W$ program loads firmware
and starts the card. Who's process context gets stolen to read
these files from within the kernel?

> +
> +   The  Windows  drivers  for the Avermedia DVB-T can be obtained
> +   from: http://babyurl.com/H3U970 and you can get an application
> +   to extract the firmware from:
> +   http://www.kyz.uklinux.net/cabextract.php.
> +     _________________________________________________________

Truly bizarre, weird........

> +Known Limitations
> +

Truly bizarre, weird........

> @@ -20,7 +20,7 @@
>  		extracted from the Windows driver (Sc_main.mc).
>  - tda1004x: firmware is loaded from path specified in
>  		DVB_TDA1004X_FIRMWARE_FILE kernel config

WTF? The __kernel__ doesn't read files. User mode programs
use the kernel to read files for them, on their behalf.

> -		variable (default /etc/dvb/tda1004x.bin); the
> +		variable (default /usr/lib/hotplug/firmware/tda1004x.bin); the
>  		firmware binary must be extracted from the windows
>  		driver

Truly bizarre, weird........ It's not April 1st yet!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


