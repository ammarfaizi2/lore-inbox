Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269482AbSISNtz>; Thu, 19 Sep 2002 09:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbSISNtz>; Thu, 19 Sep 2002 09:49:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:51921 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S269482AbSISNty>;
	Thu, 19 Sep 2002 09:49:54 -0400
Date: Thu, 19 Sep 2002 15:54:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error in pre7-ac2: usb & input
Message-ID: <20020919155452.A75192@ucw.cz>
References: <Pine.LNX.4.44.0209191555240.1928-100000@ondatra.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0209191555240.1928-100000@ondatra.tartu-labor>; from mroos@linux.ee on Thu, Sep 19, 2002 at 04:04:08PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 04:04:08PM +0300, Meelis Roos wrote:
> drivers/usb/usbdrv.o: In function `hidinput_hid_event':
> drivers/usb/usbdrv.o(.text+0x11573): undefined reference to `input_event'
> drivers/usb/usbdrv.o(.text+0x115ee): undefined reference to `input_event'
> drivers/usb/usbdrv.o(.text+0x11600): undefined reference to `input_event'
> drivers/usb/usbdrv.o(.text+0x11641): undefined reference to `input_event'
> drivers/usb/usbdrv.o(.text+0x11664): undefined reference to `input_event'
> drivers/usb/usbdrv.o(.text+0x11682): more undefined references to `input_event' follow
> drivers/usb/usbdrv.o: In function `hidinput_connect':
> drivers/usb/usbdrv.o(.text+0x118d4): undefined reference to `input_register_device'
> drivers/usb/usbdrv.o: In function `hidinput_disconnect':
> drivers/usb/usbdrv.o(.text+0x118f3): undefined reference to `input_unregister_device'

Well, you enabled HID as built-in and Input as modular. HID needs Input.

As to why it was possible to enable this combination, I'll take a look.

-- 
Vojtech Pavlik
SuSE Labs
