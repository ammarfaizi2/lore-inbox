Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbTD3WMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 18:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbTD3WMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 18:12:45 -0400
Received: from granite.he.net ([216.218.226.66]:48645 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262476AbTD3WMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 18:12:44 -0400
Date: Wed, 30 Apr 2003 15:27:08 -0700
From: Greg KH <greg@kroah.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.68-bk10 drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared
Message-ID: <20030430222708.GB25332@kroah.com>
References: <1051741247.4565.1.camel@flat41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051741247.4565.1.camel@flat41>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 11:20:48PM +0100, Grzegorz Jaskiewicz wrote:
> drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
> drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use
> in this function)
> drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported
> only once
> drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
> make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
> make[1]: *** [drivers/bluetooth] Error 2
> make: *** [drivers] Error 2
> 
> probably #define USB_ZERO_PACKET should help, but i am not convinent.

s/USB_ZERO_PACKET/URB_ZERO_PACKET/ in the driver will solve this one.
Care to send a patch to Max?

thanks,

greg k-h
