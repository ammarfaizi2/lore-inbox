Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270596AbUJTX5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270596AbUJTX5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270499AbUJTXzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:55:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:51624 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270464AbUJTXxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:53:35 -0400
Date: Wed, 20 Oct 2004 16:50:56 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: remove (unneeded proto) that causes a warning w/o CONFIG_PM
Message-ID: <20041020235056.GA16606@kroah.com>
References: <20041020023803.GF8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020023803.GF8597@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 07:38:03PM -0700, Chris Wedgwood wrote:
> remove (unneeded proto) that causes a warning w/o CONFIG_PM
> 
> Signed-off-by: cw@f00f.org
> 
> diff -Nru a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> --- a/drivers/usb/host/ohci-hcd.c	2004-10-19 17:48:05 -07:00
> +++ b/drivers/usb/host/ohci-hcd.c	2004-10-19 17:48:05 -07:00
> @@ -140,7 +140,6 @@
>  
>  static void ohci_dump (struct ohci_hcd *ohci, int verbose);
>  static int ohci_init (struct ohci_hcd *ohci);
> -static int ohci_restart (struct ohci_hcd *ohci);
>  static void ohci_stop (struct usb_hcd *hcd);
>  
>  #include "ohci-hub.c"

Wait, this patch causes problems if CONFIG_PM is enabled.  Not applied.

thanks,

greg k-h
