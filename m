Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbTANOqs>; Tue, 14 Jan 2003 09:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTANOqs>; Tue, 14 Jan 2003 09:46:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32520 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262913AbTANOqr>;
	Tue, 14 Jan 2003 09:46:47 -0500
Date: Tue, 14 Jan 2003 06:55:29 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: usb broken in 2.5?
Message-ID: <20030114145529.GA14672@kroah.com>
References: <20030114024435.GA1293@fefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114024435.GA1293@fefe.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 03:44:35AM +0100, Felix von Leitner wrote:
> In 2.5.57 USB does not work.  The mainboard devices are still detected,
> and apparently also the USB devices are found, but then the USB code
> tries to remap them and fails.  It tries again with 1.5 Mb/s and fails
> again.

This sounds like the old iterrupt routing problem that ACPI causes at
times, and not a USB problem (the interrupts aren't getting to the
controller, nothing the USB controller can do about that...)

> > usb_control/bulk_msg: timeout
> > usb.c: USB device not accepting new address=3 (error=-110)
> 
> The same problem also happens with the WOLK kernel patch, which appears
> to also include a newer version of the USB code.

Newer version?  Where would the WOLK people get that from, as the stuff
in the main tree is the newest.

Since you said you are using ACPI, I'd suggest taking this up with the
ACPI developers.

thanks,

greg k-h
