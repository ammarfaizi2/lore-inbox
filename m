Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758998AbWLDXQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758998AbWLDXQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759808AbWLDXQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:16:14 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:56390 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758998AbWLDXQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:16:13 -0500
Date: Mon, 4 Dec 2006 15:13:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>, dbrownell@users.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] USB_RTL8150 must select MII
Message-Id: <20061204151324.15288113.randy.dunlap@oracle.com>
In-Reply-To: <20061204200206.GA7027@stusta.de>
References: <20061204200206.GA7027@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 21:02:06 +0100 Adrian Bunk wrote:

> USB_RTL8150 must select MII to avoid link errors.
> 
> Stolen from a patch by Randy Dunlap.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks, Adrian.

David B. may prefer a patch similar to the one that was
merged for USB_NET_MCS7830, which does:

	select USB_USBNET_MII

although I don't see why...

> ---
> 
> This patch was already sent on:
> - 4 Nov 2006
> 
> --- linux-2619-rc3-pv.orig/drivers/usb/net/Kconfig
> +++ linux-2619-rc3-pv/drivers/usb/net/Kconfig
> @@ -84,6 +84,7 @@ config USB_PEGASUS
>  config USB_RTL8150
>  	tristate "USB RTL8150 based ethernet device support (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL
> +	select MII
>  	help
>  	  Say Y here if you have RTL8150 based usb-ethernet adapter.
>  	  Send me <petkan@users.sourceforge.net> any comments you may have.

---
~Randy
