Return-Path: <linux-kernel-owner+w=401wt.eu-S1750738AbXAICST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbXAICST (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXAICST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:18:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63196 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXAICSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:18:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=monQi3FI6Y4qd8XGtci1ddY0VjGs8aFJzyP1Bm0NXvSzPFVgqxcz7XLXyOr2n7Drmyldrsh4Xfrn3dlzI3qEAjrW/poG8P5LIuJ2dgmI1uY9kesWhjRUZM5zc3EwOo27kgv6zTjfNkvLxE6SsaMQzH1B8PRpn8D796lRWpdPGH0=
Message-ID: <47ed01bd0701081818k64925913p2b5d8d9d8ffa045c@mail.gmail.com>
Date: Mon, 8 Jan 2007 21:18:17 -0500
From: "Dylan Taft" <d13f00l@gmail.com>
To: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] USB MASS STORAGE: US_FL_IGNORE_RESIDUE needed for Aiptek MP3 Player - retry
In-Reply-To: <47ed01bd0701080350w2a10fedei6e1724268905453d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47ed01bd0701080350w2a10fedei6e1724268905453d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gmail for some reason isn't letting me paste this patch without word
wrapping, even if it's not wrapped in my editor.
Does it show up right for anyone else?  Sigh.

On 1/8/07, Dylan Taft <d13f00l@gmail.com> wrote:
> From: Dylan Taft <d13f00l@gmail.com>
>
> Device will not work as a mass storage device without US_FL_IGNORE_RESIDUE.
>
> Signed-off-by: Dylan Taft <d13f00l@gmail.com>
> ---
> --- ./drivers/usb/storage/unusual_devs.bak      2006-12-09
> 20:50:33.000000000 -0500
> +++ ./drivers/usb/storage/unusual_devs.h        2007-01-07
> 22:17:13.000000000 -0500
> @@ -1075,6 +1075,15 @@ UNUSUAL_DEV(  0x08bd, 0x1100, 0x0000, 0x
>                US_SC_DEVICE, US_PR_DEVICE, NULL,
>                US_FL_SINGLE_LUN),
>
> +/* Submitted by Dylan Taft <d13f00l@gmail.com>
> + * US_FL_IGNORE_RESIDUE Needed
> + */
> +UNUSUAL_DEV(  0x08ca, 0x3103, 0x0100, 0x0100,
> +                "AIPTEK",
> +                "Aiptek USB Keychain MP3 Player",
> +                US_SC_DEVICE, US_PR_DEVICE, NULL,
> +                US_FL_IGNORE_RESIDUE),
> +
>  /* Entry needed for flags. Moreover, all devices with this ID use
>  * bulk-only transport, but _some_ falsely report Control/Bulk instead.
>  * One example is "Trumpion Digital Research MYMP3".
>
