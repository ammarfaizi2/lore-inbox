Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTHZHpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 03:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTHZHpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 03:45:50 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:44512 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262275AbTHZHpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 03:45:47 -0400
Date: Tue, 26 Aug 2003 09:45:42 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: Synaptics TouchPad and GPM (GPM patches)
Message-ID: <20030826074542.GA12430@ucw.cz>
References: <200308222146.56381.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308222146.56381.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:46:56PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Apologies for the semi-offtopic message but ever since support for 
> Synaptics' absolute mode went in many people complained that it 
> broke GPM. 
> 
> I did some work on extending evdev support in GPM, the new protocol
> implementation supports following subtypes:
> 
> 1. relative device - standard relative device like generic PS/2 mouse
>    reporting via /dev/input/eventX
> 2. absolute device - touch screens and tablets.
> 3. touchpad - device reporting absolute coordinates and pressure via
>    /dev/input/event, GPM recognizes normal and corner tapping.
> 4. synaptics - same as touchpad but also supports multi-finger taps
>    (expects MSC_GESTURE messages from the kernel).
> 
> Kernel has to support EV_SYNC for touchpad and synaptics support, 
> relative and absolute modes can be used with 2.4 kernels by specifying
> nosync option.

You should not need any options for this - it's all queryable via ioctls ...

> You will find the patches at:
> http://www.geocities.com/dt_or/gpm/patches/
> 
> RPMs (binary and source) built on RH8 are at:
> http://www.geocities.com/dt_or/gpm/RPMS/
> 
> The README is at:
> http://www.geocities.com/dt_or/gpm/gpm.html
> 
> The patches work pretty well for me and I hope they will work for others too.
> Because of limited hardware I could not test evdev with touchscreen or a 
> tablet.
> 
> Dmitry.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
