Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbVJRIaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVJRIaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJRIaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:30:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:20966 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932393AbVJRIaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:30:04 -0400
Date: Tue, 18 Oct 2005 10:30:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Input: evdev - allow querying EV_SW from compat_ioctl
Message-ID: <20051018083002.GB13969@ucw.cz>
References: <200510180151.47195.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510180151.47195.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 01:51:46AM -0500, Dmitry Torokhov wrote:
> Input: evdev - allow querying EV_SW bits from compat_ioctl

Yup. Twas missing.

> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
>  drivers/input/evdev.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: work/drivers/input/evdev.c
> ===================================================================
> --- work.orig/drivers/input/evdev.c
> +++ work/drivers/input/evdev.c
> @@ -566,6 +566,7 @@ static long evdev_ioctl_compat(struct fi
>  						case EV_LED: bits = dev->ledbit; max = LED_MAX; break;
>  						case EV_SND: bits = dev->sndbit; max = SND_MAX; break;
>  						case EV_FF:  bits = dev->ffbit;  max = FF_MAX;  break;
> +						case EV_SW:  bits = dev->swbit;  max = SW_MAX;  break;
>  						default: return -EINVAL;
>  					}
>  					bit_to_user(bits, max);
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
