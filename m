Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143994AbRAHOgr>; Mon, 8 Jan 2001 09:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144048AbRAHOg2>; Mon, 8 Jan 2001 09:36:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64772 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143994AbRAHOgG>; Mon, 8 Jan 2001 09:36:06 -0500
Subject: Re: PATCH for 2.4.0: assign ad1848 mixer operations to correct module
To: rankinc@zipworld.com.au
Date: Mon, 8 Jan 2001 14:37:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <200101081308.f08D8iv01511@wittsend.ukgateway.net> from "Chris Rankin" at Jan 08, 2001 01:08:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FdQR-0004fZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> + if (owner)
> +   ad1848_mixer_operations.owner = owner;
> +
>   if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
>              dev_name,
>              &ad1848_mixer_operations,
> 
> BTW Isn't it ever-so-slightly dodgy modifying the static

Very.

> operations in exactly the same way as the ad1848_audio_driver
> structure, but doesn't this mean that the ad1848_init() function now
> "remembers" the owner from the previous call?

Yeah

> Or maybe the sound_install_XXXX() functions should accept "owner"
> parameters, so that the static structs could become "const"?

I think you either need owner as a parameter or to make a copy of the
ad1848_mixer_operations in your sscape driver and pass that ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
