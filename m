Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVBGRRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVBGRRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBGRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:17:12 -0500
Received: from coderock.org ([193.77.147.115]:21694 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261196AbVBGRQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:16:53 -0500
Date: Mon, 7 Feb 2005 18:16:46 +0100
From: Domen Puncer <domen@coderock.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Mikkel Krautz <krautz@gmail.com>, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050207171646.GB15840@nd47.coderock.org>
References: <20050207154424.GB4742@omnipotens.localhost> <42079052.1050904@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42079052.1050904@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/05 07:59 -0800, Randy.Dunlap wrote:
> Mikkel Krautz wrote:
> >And, here's an updated version of hid-core.c:
> >
> >Signed-off-by: Mikkel Krautz <krautz@gmail.com>
> >---
> >--- clean/drivers/usb/input/hid-core.c
> >+++ dirty/drivers/usb/input/hid-core.c
...
> >+
> >+static unsigned int hid_mousepoll_interval;
> >+module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
> 
> Why is it writable by root?  IOW, will writing a new value to it
> change the operational value dynamically?
> 
> Also, from the kernel-parameters.txt patch:
> +	usbhid.mousepoll=
> +		[USBHID] The interval at wich mice are to be polled at.
> 
> (a) "which"
> (b) drop one of the "at"s... either one.

Is listing module parameters in kernel-parameters.txt the right thing
to do? (There are lots of them, not many are listed)

I see some options that might be better:
- Kconfig magic which extracts module_param* and MODULE_PARM_DESC from
  sources and appends them to help text.
- a userspace script, that goes trough all modules and generates
  kernel-module-parameters.txt for example.
- modinfo like tool (but i think it would require source or descriptions
  compiled in kernel)



	Domen
