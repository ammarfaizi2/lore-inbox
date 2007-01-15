Return-Path: <linux-kernel-owner+w=401wt.eu-S932101AbXAOImu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbXAOImu (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbXAOImt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:42:49 -0500
Received: from twin.jikos.cz ([213.151.79.26]:48452 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbXAOImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:42:49 -0500
Date: Mon, 15 Jan 2007 09:42:42 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Simon Budig <simon@budig.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for
 SpaceNavigator)
In-Reply-To: <20070114231135.GA29966@budig.de>
Message-ID: <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz>
References: <20070114231135.GA29966@budig.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Simon Budig wrote:

> This change introduces a mapping for LED indicators between the USB HID 
> specification and the Linux input subsystem. The previous code properly 
> mapped the LEDs relevant for Keyboards, but garbeled the remaining ones. 
> With this change all LED enums from the input system get mapped to more 
> or less equivalent LED numbers from the HID specification. This patch 
> also extends the debug output and ensures that the unused bits in a HID 
> report to the device are zeroed out. This makes the 3Dconnexion 
> SpaceNavigator fully usable with the linux input system.

Hi Simon,

thanks for the patch. It seems that it is based on pre-2.6.20-rc1 kernel 
(this is where the USBHID split happened and generic HID layer was 
introduced). Could you please rebase it against newer version of kernel 
and resend it?

All your changes happen to be in the transport-independent code, so it 
seems that this would be rather trivial task - probably only pathnames 
(and diff offsets) will change - your changes should now go to 
drivers/hid/hid-*, not drivers/usb/input/hid-*.

Thanks,

-- 
Jiri Kosina
