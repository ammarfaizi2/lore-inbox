Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUAERiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUAERhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:37:48 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6784 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265218AbUAERhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:37:41 -0500
Date: Mon, 5 Jan 2004 18:37:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mouse info in 2.6.1-rc1
Message-ID: <20040105173759.GB359@ucw.cz>
References: <Pine.LNX.4.58.0401051716590.23750@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051716590.23750@student.dei.uc.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:25:41PM +0000, Marcos D. Marado Torres wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi there...
> I don't really know if this is only in -rc1-mm1 but I suppose -rc1 is affected also.
> 
> The new changes about synaptics (I think that it was it) made that we don't have
> anymore a boolean (selectable) option in Device Drivers -> Input Device Support
> - -> Mouse Interface;
> Although, it we so to the "non-selectable" option Mouse Interface, the help info
> exists and talks about "slect it if...", so...

It IS selectable if EMBEDDED.

>  Please apply the patch:
> 
> - --- linux-2.6.1-rc1-mm2/drivers/input/Kconfig   2003-12-18 03:58:08.000000000 +0100
> +++ linux-2.6.1-rc1-mm2-mbn1/drivers/input/Kconfig      2004-01-05 13:38:10.000000000 +0100
> @@ -28,17 +28,6 @@
>         tristate "Mouse interface" if EMBEDDED
>         default y
>         depends on INPUT
> - -       ---help---
> - -         Say Y here if you want your mouse to be accessible as char devices
> - -         13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
> - -         emulated IntelliMouse Explorer PS/2 mouse. That way, all user space
> - -         programs (includung SVGAlib, GPM and X) will be able to use your
> - -         mouse.
> - -
> - -         If unsure, say Y.
> - -
> - -         To compile this driver as a module, choose M here: the
> - -         module will be called mousedev.
> 
>  config INPUT_MOUSEDEV_PSAUX
>         bool "Provide legacy /dev/psaux device" if EMBEDDED
> 
> 
> - --
> ==================================================
> Marcos Daniel Marado Torres AKA Mind Booster Noori
> /"\               http://student.dei.uc.pt/~marado
> \ /                       marado@student.dei.uc.pt
>  X   ASCII Ribbon Campaign
> / \  against HTML e-mail and Micro$oft attachments
> ==================================================
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Made with pgp4pine 1.76
> 
> iD8DBQE/+Z4ZmNlq8m+oD34RArVtAKDJjHjADGuxtCCT9RHC98s7hDBoOACcDfIT
> 6Zc5scaGgrtRoOOVBc8RPbA=
> =cNaw
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
