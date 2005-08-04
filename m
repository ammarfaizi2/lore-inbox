Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVHDRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVHDRSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVHDRSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:18:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261512AbVHDRQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:16:33 -0400
Date: Thu, 4 Aug 2005 10:15:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: mdew <some.nzguy@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz, dtor_core@ameritech.net
Subject: Re: Fw: ati-remote strangeness from 2.6.12 onwards
Message-Id: <20050804101515.4a983b29.akpm@osdl.org>
In-Reply-To: <1c1c8636050801220442d8351c@mail.gmail.com>
References: <20050730173253.693484a2.akpm@osdl.org>
	<1c1c8636050801220442d8351c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdew <some.nzguy@gmail.com> wrote:
>
> I discovered a minor change in 2.6.10-mm1, changing this value back
>  corrects the "ok" button issue.
> 
> 
>  diff -urN linux/drivers/usb/input/ati_remote.c
>  linux-2.6.11/drivers/usb/input/ati_remote.c
>  --- linux/drivers/usb/input/ati_remote.c        2005-08-02
>  17:56:26.000000000 +1200
>  +++ linux-2.6.11/drivers/usb/input/ati_remote.c 2005-08-02
>  17:54:34.000000000 +1200
>  @@ -263,7 +263,7 @@
>          {KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right */
>          {KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down */
>          {KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
>  -       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
>  +       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK" */
>          {KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL + */
>          {KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL - */
>          {KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE  */

This appears to be already applied in 2.6.12-rc5.
