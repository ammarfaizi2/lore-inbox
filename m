Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265550AbUABNRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUABNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:17:30 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:32641 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265550AbUABNR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:17:29 -0500
Date: Fri, 2 Jan 2004 14:17:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Go Taniguchi <go@turbolinux.co.jp>
Cc: vojtech@suse.cz, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 with JP106 keyboard
Message-ID: <20040102131737.GB395@ucw.cz>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <3FF4F8EA.6090602@turbolinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF4F8EA.6090602@turbolinux.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:51:54PM +0900, Go Taniguchi wrote:
> >
> >Vojtech Pavlik:
> >  o Fixes for keyboard 2.4 compatibility
> >
> 
> Hi,
> 2.6.1-rc1 with JP106 keybord. keycode was changed....
>                                         2.6.0 -> 2.6.1-rc1
> lower-right backslash (scancode 0x73)   89    -> 181
> upper-right backslash (scancode 0x7d)   183   -> 182

These two scancodes are defined as japanese language selection keys.
Hence the atkbd.c driver delivers these as such. What should be updated
is the default keymap (defkeymap.map, defkeymap.c).

> at atkbd_set2_keycode in drivers/input/keyboard/atkbd.c
> 
> -       122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
> +         0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
>              ^ scancode 0x73
> 
> -        85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
> +         0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
>                                                  ^ scancode 0x7d
> Is this correct?
> 2.6.0 is OK, but 2.6.1-rc1 does not get [|/_] keys.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
