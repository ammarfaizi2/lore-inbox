Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVEOJnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVEOJnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVEOJnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:43:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21007 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261592AbVEOJno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:43:44 -0400
Date: Sun, 15 May 2005 11:43:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.12-rc4-mm1: drivers/usb/gadget/ether.c compile error
Message-ID: <20050515094339.GO16549@stusta.de>
References: <20050512033100.017958f6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512033100.017958f6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 03:31:00AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc3-mm3:
>...
> +gregkh-04-USB-gregkh-usb-031_usb-ethernet_gadget_cleanups.patch
>...
>  USB tree
>...

This patch breaks compilation with CONFIG_USB_ETH=y and 
CONFIG_USB_ETH_RNDIS=n:

<--  snip  -->

...
  CC      drivers/usb/gadget/ether.o
drivers/usb/gadget/ether.c: In function `rx_submit':
drivers/usb/gadget/ether.c:1620: error: invalid application of `sizeof' to incomplete type `rndis_packet_msg_type' 
make[2]: *** [drivers/usb/gadget/ether.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

