Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUCVGPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUCVGPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:15:45 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15745 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261756AbUCVGPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:15:40 -0500
Date: Mon, 22 Mar 2004 07:16:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Dmitry Torokhov <dtor@mail.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
Message-ID: <20040322061657.GA346@ucw.cz>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c81lsnk.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 11:52:31PM +0100, Krzysztof Halasa wrote:
> Hi,
> 
> I have a notebook PC (an old Fujitsu-Siemens Liteline, celeron 600 etc)
> with a Synaptics touchpad:
> 
> Synaptics Touchpad, model: 1
>  Firmware: 4.6
>  Sensor: 19
>  new absolute packet format
>  Touchpad has extended capability bits
>  -> multifinger detection
>  -> palm detection
> input: SynPS/2 Synaptics TouchPad on isa0060/serio1
> 
> This notebook has external mouse+keyboard connector. Is it possible to
> have both the touchpad and the external mouse simultaneously active in
> their native modes? The hardware (keyboard controller) doesn't seem to
> support the active multiplexing mode (by Synaptics and others):
> 
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: 0f <- i8042 (return) [3]
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: a9 <- i8042 (return) [3]
> drivers/input/serio/i8042.c: d3 -> i8042 (command) [3]
> drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [3]
> drivers/input/serio/i8042.c: 5b <- i8042 (return) [3]
> 
> It looks the keyboard controller just forwards all data from both
> devices. I can set them (i.e. Linux and XFree86 driver) to IM PS/2 mode
> and they will both work (Linux treats them as one device), but I can't
> use touchpad's special features.

I'm sorry to say it, but it's not possible. Well, it might be, but still
the magic to recognize which device is sending the data would be rather
crazy.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
