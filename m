Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbUKDS24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUKDS24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUKDSZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:25:30 -0500
Received: from wang.choosehosting.com ([212.42.1.230]:23249 "EHLO
	wang.choosehosting.com") by vger.kernel.org with ESMTP
	id S262353AbUKDSWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:22:12 -0500
From: Thomas Stewart <thomas@stewarts.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: belkin usb serial converter (mct_u232), break not working
Date: Thu, 4 Nov 2004 19:20:21 +0100
User-Agent: KMail/1.6.2
References: <200410201946.35514.thomas@stewarts.org.uk> <1098362487.2815.9.camel@deimos.microgate.com> <1098387861.3288.51.camel@deimos.microgate.com>
In-Reply-To: <1098387861.3288.51.camel@deimos.microgate.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411041820.21847.thomas@stewarts.org.uk>
X-Scanner: Exiscan on wang.choosehosting.com at 2004-11-04 18:21:46
X-Spam-Score: 0.0
X-Spam-Bars: /
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 20:44, Paul Fulghum wrote:
> I looked at mct_232.h and noticed the comment:
>
> "There seem to be two bugs in the Win98 driver:
> the break does not work (bit 6 is not asserted) and the
> stick parity bit is not cleared when set once."
> The driver was reverse engineered from the Win98 driver.
>
> Even though the LCR for this device is similar to
> the LCR of a 16550 UART, some bits work differently.
>
> This suggests to me that either the device does not
> properly support break, or that the break is
> controlled through a different USB request and not
> through MCT_U232_SET_LINE_CTRL_REQUEST
>
> The Linux and FreeBSD drivers do the same thing
> for setting break, so no new info there.
> I don't have access to the device or manufacturer docs.
>
> The only thing I can suggest is if you have
> access to a Windows 2000/XP machine, try and generate
> a break with the manufacturer provided drivers.
> If you can't, then the device does not support break.
> If you can, then maybe you can use USB sniffer
> software to look at the USB requests going to the device.

I tried the converter on a XP machine and unfortunately while using the 
manufacturer provided drivers I was unable to produce a break :-(

As a last resort I tried Belkins tech support line. The first time I called I 
was told the product (F5U109ea) was designed for PDA use only and it would 
generate breaks fine if connected to them. Admittedly it is marketed as such 
(http://catalog.belkin.com/IWCatProductPage.process?Product_Id=103226). I was 
told to buy a F5U103 instead 
(http://catalog.belkin.com/IWCatProductPage.process?Product_Id=66002). Not 
happy with this I rang back to talk to another person, this time I was not 
fobbed off as quickly and although the tech support guy did not know what a 
break was, he offered to look into it and call me back. I've not heard back 
(yet), but I'm not too surprised.

Interestingly I got my hands on a F5U103 and it works fine (uses another chip 
and consequently module). However they are so much more bulky I don't think 
I'm going to bother changing over.

Thanks for all the help :-)

Regards
-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID  [0x68A70C48]
