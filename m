Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVHDWqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVHDWqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVHDWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:44:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262707AbVHDWmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:42:54 -0400
Date: Thu, 4 Aug 2005 15:44:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Brown <some.nzguy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz, dtor_core@ameritech.net
Subject: Re: Fw: ati-remote strangeness from 2.6.12 onwards
Message-Id: <20050804154442.7e739886.akpm@osdl.org>
In-Reply-To: <1c1c863605080415233c6aac0@mail.gmail.com>
References: <20050730173253.693484a2.akpm@osdl.org>
	<1c1c8636050801220442d8351c@mail.gmail.com>
	<20050804101515.4a983b29.akpm@osdl.org>
	<1c1c863605080415233c6aac0@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Brown <some.nzguy@gmail.com> wrote:
>
> Sorry Andrew, but the diff was incorrectly made, the updated patch,
> reverts the changes too TV, DVD and OK Button, from 2.6.12-rc1.

hm, this was about 20 patches and 300 emails ago and I've forgotten what
we're discussing.  For poor old scatterbrains it really helps if people can
maintain a description of their patch alongside the patch itself.

> diff -ruN linux-2.6.12/drivers/usb/input/ati_remote.c
> linux-2.6.12-modified/drivers/usb/input/ati_remote.c
> --- linux-2.6.12/drivers/usb/input/ati_remote.c	2005-06-18
> 07:48:29.000000000 +1200
> +++ linux-2.6.12-modified/drivers/usb/input/ati_remote.c	2005-08-03
> 09:54:48.000000000 +1200
> @@ -252,8 +252,8 @@
>  	{KIND_FILTERED, 0xdd, 0x18, EV_KEY, KEY_KPENTER, 1},    /* "check" */
>  	{KIND_FILTERED, 0xdb, 0x16, EV_KEY, KEY_MENU, 1},       /* "menu" */
>  	{KIND_FILTERED, 0xc7, 0x02, EV_KEY, KEY_POWER, 1},      /* Power */
> -	{KIND_FILTERED, 0xc8, 0x03, EV_KEY, KEY_TV, 1},         /* TV */
> -	{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_DVD, 1},        /* DVD */
> +	{KIND_FILTERED, 0xc8, 0x03, EV_KEY, KEY_PROG1, 1},      /* TV */
> +	{KIND_FILTERED, 0xc9, 0x04, EV_KEY, KEY_PROG2, 1},      /* DVD */
>  	{KIND_FILTERED, 0xca, 0x05, EV_KEY, KEY_WWW, 1},        /* WEB */
>  	{KIND_FILTERED, 0xcb, 0x06, EV_KEY, KEY_BOOKMARKS, 1},  /* "book" */
>  	{KIND_FILTERED, 0xcc, 0x07, EV_KEY, KEY_EDIT, 1},       /* "hand" */
> @@ -263,7 +263,7 @@
>  	{KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right */
>  	{KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down */
>  	{KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
> -	{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK" */
> +	{KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
>  	{KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL + */
>  	{KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL - */
>  	{KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE  */

IOW: what does this (wordwrapped!) patch do?

