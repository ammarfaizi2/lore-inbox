Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVHCFy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVHCFy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVHCFy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:54:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47027 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262062AbVHCFy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:54:26 -0400
Date: Wed, 3 Aug 2005 07:54:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: mdew <some.nzguy@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Fw: ati-remote strangeness from 2.6.12 onwards
Message-ID: <20050803055413.GB1399@elf.ucw.cz>
References: <20050730173253.693484a2.akpm@osdl.org> <1c1c8636050801220442d8351c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1c8636050801220442d8351c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I discovered a minor change in 2.6.10-mm1, changing this value back
> corrects the "ok" button issue.
> 
> 
> diff -urN linux/drivers/usb/input/ati_remote.c
> linux-2.6.11/drivers/usb/input/ati_remote.c
> --- linux/drivers/usb/input/ati_remote.c        2005-08-02
> 17:56:26.000000000 +1200
> +++ linux-2.6.11/drivers/usb/input/ati_remote.c 2005-08-02
> 17:54:34.000000000 +1200
> @@ -263,7 +263,7 @@
>         {KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right */
>         {KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down */
>         {KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
> -       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
> +       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK" */
>         {KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL + */
>         {KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL - */
>         {KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE  */

I'd say that KEY_ENTER is perhaps more logical there? It is certainly
more usefull than "OK" key.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
