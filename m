Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSGIQgN>; Tue, 9 Jul 2002 12:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSGIQgM>; Tue, 9 Jul 2002 12:36:12 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37040 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316434AbSGIQgK>;
	Tue, 9 Jul 2002 12:36:10 -0400
Date: Tue, 9 Jul 2002 18:38:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Piotr Sawuk <a9702387@unet.univie.ac.at>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: joystick.c
Message-ID: <20020709183841.A10953@ucw.cz>
References: <3D2AB938.52461BDE@unet.univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D2AB938.52461BDE@unet.univie.ac.at>; from a9702387@unet.univie.ac.at on Tue, Jul 09, 2002 at 10:21:44AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:21:44AM +0000, Piotr Sawuk wrote:

> Sorry if I'm off-topic here, since I don't read this list.
> also when replying please send me a copy...
> 
> in function js_correct(value,corr) I've found the instructions:
> 
> if (value < -32767) return -32767;
> if (value > 32767) return 32767;
> 
> what's the use of these? I'm asking because my new usb-joystick
> is returning those values somewhere in the middle of it's threshold
> and I was wondering if disabling the above would do any good?

The data coming from the joystick is defined to be bound by this range.
It's signed 16 bit anyway.

> however, the actual reason why I've looked into that file was
> because wine reported strange joystick-events 6,7,8,9 and I
> just can't figure out what those are supposed to do. I've found
> JS_EVENT 1 and 2 in the linux/joystick.h include, but no mention
> of anything related to the number '6'. does anyone know anything
> about those joystick events?

What joystick is it? This looks like a problem with the HID driver.

-- 
Vojtech Pavlik
SuSE Labs
