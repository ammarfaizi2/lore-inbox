Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIBRBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbTIBQ6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:58:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:41651 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264052AbTIBQxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:53:46 -0400
Date: Tue, 2 Sep 2003 09:43:41 -0700
From: Greg KH <greg@kroah.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030902164341.GF17568@kroah.com>
References: <200309020139.08248.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309020139.08248.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 01:39:08AM +0800, Michael Frank wrote:
> PL2303 is used to connect the serial console on a classic serial port 
> of a test machine. HW nandshaking is used
> The test machine reboots once a minute and dumps lots of messages
> 
> Frequently:
> - driver hangs 
> - userspace (cu) can't be stopped
> - pl2303 and/or usbserial can't be unloaded 
> - USB interrupts stop
> - problems result in requiring a reboot.

Hm, it looks like you physically removed the device, is that correct?
Or were you just unloading the pl2303 and other USB drivers and then
reloading them?

What exactly were you doing in this log?

Oh, and can you send a copy of /proc/bus/usb/devices with your pl2303
device plugged in?

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 01:39:08AM +0800, Michael Frank wrote:
> PL2303 is used to connect the serial console on a classic serial port 
> of a test machine. HW nandshaking is used
> The test machine reboots once a minute and dumps lots of messages
> 
> Frequently:
> - driver hangs 
> - userspace (cu) can't be stopped
> - pl2303 and/or usbserial can't be unloaded 
> - USB interrupts stop
> - problems result in requiring a reboot.

Hm, it looks like you physically removed the device, is that correct?
Or were you just unloading the pl2303 and other USB drivers and then
reloading them?

What exactly were you doing in this log?

Oh, and can you send a copy of /proc/bus/usb/devices with your pl2303
device plugged in?

thanks,

greg k-h
