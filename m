Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUJ2Xdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUJ2Xdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUJ2X3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:29:17 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:35817 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S263533AbUJ2XVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:21:33 -0400
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] usbnet.c: remove an unused function
Date: Fri, 29 Oct 2004 16:17:30 -0700
User-Agent: KMail/1.6.2
Cc: dbrownell@users.sourceforge.net, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20041028232455.GK3207@stusta.de> <20041029002850.GD29142@stusta.de>
In-Reply-To: <20041029002850.GD29142@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410291617.30136.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 17:28, Adrian Bunk wrote:
> [ this time without the problems due to a digital signature... ]
> 
> The patch below removes an unused function from drivers/usb/net/usbnet.c

Actually in this case I'd rather leave the function there;
the documentation on this chip is hard to find, and this
function will be needed when someone finally spends the time
to fix some of the init/reset handshake issues for these
PL2301/2302 chips.  The current init code cloned some
very ancient code from about the 2.2.10 (!) or so kernel.

Speaking of which ... anyone motivated to solve that can
probably find answers in a file transfer package I saw
a while back (but lost!) for file transferring files
to/from Linux, especialy for Playstation 2 boxes.  That
used a very different handshaking scheme... possibly one
that's incompatible with Linux 2.2, but evidently one
that worked reliably and noticed connect change events.
(Neither is true of the current PL2301/2302 code!)

- Dave

p.s. Last I looked, GCC ignored unused inlines; no code
     generated, no warnings.  Did that change?

> 
> diffstat output:
>  drivers/usb/net/usbnet.c |    6 ------
>  1 files changed, 6 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c.old	2004-10-28 
23:32:50.000000000 +0200
> +++ linux-2.6.10-rc1-mm1-full/drivers/usb/net/usbnet.c	2004-10-28 
23:33:23.000000000 +0200
> @@ -2127,12 +2127,6 @@
>  }
>  
>  static inline int
> -pl_clear_QuickLink_features (struct usbnet *dev, int val)
> -{
> -	return pl_vendor_req (dev, 1, (u8) val, 0);
> -}
> -
> -static inline int
>  pl_set_QuickLink_features (struct usbnet *dev, int val)
>  {
>  	return pl_vendor_req (dev, 3, (u8) val, 0);
> 
