Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUFOQD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUFOQD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFOQD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:03:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:14732 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265724AbUFOQDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:03:50 -0400
Date: Tue, 15 Jun 2004 18:05:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: Re: CONFIG_USB_HID vs. CONFIG_USB_HIDINPUT
Message-ID: <20040615160502.GA11059@ucw.cz>
References: <20040615140705.B6153@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615140705.B6153@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 02:07:05PM +0000, Karel Kulhavý wrote:
> Hello
> 
> When I enable CONFIG_USB_HID and not enable CONFIG_USB_HIDINPUT in 2.4.25, will
> I get something different from when I don't enable neither of them?
> 
> The <Help> says basically the same about both: that they control
> "keyboards, mice, joysticks, graphics tablets, or any other HID based devices"
> (CONFIG_USB_HID)
> "keyboard, mouse or joystick or any other HID input device"
> (CONFIG_USB_HIDINPUT)
> 
> I assume
> 1) it doesn't matter if "keyboard" or "keyboards" is in the <Help>
> 2) graphics tablets are assumed to be "any other HID input devices".

In that case you get the HID driver, but you won't get the Input
binding, so the devices will be detected, but won't be accessible by the
common means (keyboard through console, mouse via /dev/input/mice,
etc.). They still will be accessible via HIDDEV, if you enable that.

Enabling HID without either HIDINPUT or HIDDEV is pointless.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
