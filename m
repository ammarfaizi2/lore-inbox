Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRJZBpi>; Thu, 25 Oct 2001 21:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277165AbRJZBp2>; Thu, 25 Oct 2001 21:45:28 -0400
Received: from zero.tech9.net ([209.61.188.187]:13834 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S277143AbRJZBpU>;
	Thu, 25 Oct 2001 21:45:20 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: Robert Love <rml@tech9.net>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins> 
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.24.21.44 (Preview Release)
Date: 25 Oct 2001 21:45:58 -0400
Message-Id: <1004060759.11258.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-25 at 21:37, Tachino Nobuhiro wrote:
>   Following patch may fix your oops. Please try.

Hm, I don't think so.  The last area is marked zero so code can know
when it ends.  This is common practice.

> diff -u -r linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c linux-2.4.12-ac5/drivers/sound/ac97_codec.c
> --- linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c	Mon Oct 22 09:34:21 2001
> +++ linux-2.4.12-ac5/drivers/sound/ac97_codec.c	Fri Oct 26 10:26:41 2001
> @@ -143,7 +143,6 @@
>  	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
>  	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
>  	{0x57454301, "Winbond 83971D",		&null_ops},
> -	{0,}
>  };
>  
>  static const char *ac97_stereo_enhancements[] =

	Robert Love

