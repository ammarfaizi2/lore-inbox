Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUFOROy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUFOROy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUFOROy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:14:54 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:50048 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265775AbUFOROw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:14:52 -0400
Date: Tue, 15 Jun 2004 17:14:51 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_USB_HID vs. CONFIG_USB_HIDINPUT
Message-ID: <20040615171451.A6843@beton.cybernet.src>
References: <20040615140705.B6153@beton.cybernet.src> <20040615160502.GA11059@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615160502.GA11059@ucw.cz>; from vojtech@suse.cz on Tue, Jun 15, 2004 at 06:05:02PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 06:05:02PM +0200, Vojtech Pavlik wrote:
> On Tue, Jun 15, 2004 at 02:07:05PM +0000, Karel Kulhavý wrote:
> > Hello
> > 
> > When I enable CONFIG_USB_HID and not enable CONFIG_USB_HIDINPUT in 2.4.25, will
> > I get something different from when I don't enable neither of them?
> > 
> > The <Help> says basically the same about both: that they control
> > "keyboards, mice, joysticks, graphics tablets, or any other HID based devices"
> > (CONFIG_USB_HID)
> > "keyboard, mouse or joystick or any other HID input device"
> > (CONFIG_USB_HIDINPUT)
> > 
> > I assume
> > 1) it doesn't matter if "keyboard" or "keyboards" is in the <Help>
> > 2) graphics tablets are assumed to be "any other HID input devices".
> 
> In that case you get the HID driver, but you won't get the Input
> binding, so the devices will be detected, but won't be accessible by the
> common means (keyboard through console, mouse via /dev/input/mice,
> etc.). They still will be accessible via HIDDEV, if you enable that.
> 
> Enabling HID without either HIDINPUT or HIDDEV is pointless.

So they are 4 meaningful combinations:
0)nothing
1)HIDDEV
2)HIDINPUT
3)HIDINPUT+HIDDEV

There are 3 tickboxes with 5 possible combinations.  I suggest reducing this
count to 2 tickboxes with 4 naturally resulting combinations. I think it will
be less confusing for a user.

> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
