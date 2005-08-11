Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbVHKUgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVHKUgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVHKUgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:36:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44968 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932443AbVHKUgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:36:31 -0400
Message-ID: <42FBB6C5.2070404@pobox.com>
Date: Thu, 11 Aug 2005 16:36:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
References: <200508111424.43150.bjorn.helgaas@hp.com>
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work-vga/drivers/ide/Kconfig
> ===================================================================
> --- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
> +++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
> @@ -276,6 +276,7 @@
>  
>  config IDE_GENERIC
>  	tristate "generic/default IDE chipset support"
> +	depends on !IA64


hmmmmmmmmm.  Are you POSITIVE that the legacy IDE ports are never enabled?

In modern Intel chipsets, this still occurs with e.g. combined mode.

	Jeff


