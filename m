Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269939AbUJGXrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269939AbUJGXrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbUJGXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:46:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:37510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269947AbUJGXlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:41:35 -0400
Date: Thu, 7 Oct 2004 16:40:38 -0700
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3
Message-ID: <20041007234038.GA2163@kroah.com>
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org> <20041007114040.GV9106@holomorphy.com> <1097184341l.10532l.0l@werewolf.able.es> <1097185597l.10532l.1l@werewolf.able.es> <20041007150708.5d60e1c3.akpm@osdl.org> <1097188883l.6408l.1l@werewolf.able.es> <20041007155441.5a8e8e3a.akpm@osdl.org> <1097190413l.6408l.3l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097190413l.6408l.3l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 11:06:53PM +0000, J.A. Magallon wrote:
> 
> On 2004.10.08, Andrew Morton wrote:
> >"J.A. Magallon" <jamagallon@able.es> wrote:
> >>
> >> Thanks, that made it work again !!
> >> 
> >> Total set of patches to boot:
> >> - your latest fix
> >> - revert optimize profile + Andi's patch
> >> - uhci fix (still needed ?)
> >
> >I don't know anything about the uhci fix.  Sending a changelogged,
> >signed-off patch would hep get the ball rolling.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109690445623905&w=2
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ===== drivers/usb/host/uhci-hcd.c 1.134 vs edited =====
> --- 1.134/drivers/usb/host/uhci-hcd.c	2004-09-30 13:58:40 -04:00
> +++ edited/drivers/usb/host/uhci-hcd.c	2004-10-04 10:37:21 -04:00
> @@ -2412,7 +2412,7 @@
> 		goto up_failed;
> 
> 	retval = pci_register_driver(&uhci_pci_driver);
> -	if (retval)
> +	if (retval < 0)
> 		goto init_failed;
> 
> 	return 0;

This should not be needed anymore, as I've fixed up the
pci_register_driver() call to be sane.  If you are having problems,
please let me know about it.

thanks,

greg k-h
