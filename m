Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWFHHmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWFHHmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 03:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWFHHmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 03:42:49 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:52352 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932545AbWFHHmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 03:42:49 -0400
From: Duncan Sands <baldrick@free.fr>
To: Stephen.Clark@seclark.us
Subject: Re: usb error? linux 2.6.15-1.1831_FC4
Date: Thu, 8 Jun 2006 09:42:45 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <4486CE78.2040506@seclark.us>
In-Reply-To: <4486CE78.2040506@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080942.45792.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyone have an idea how I could fix this - I plugged in an ActionTec 
> dualpc modem
> configured so it would ask for a new flash. Where do I put the 
> cxacru-fw.bin file?

The usual place nowadays seems to be in /lib/firmware/
Depends on your distribution though.  If you are using
hotplug rather than udev, you can find a list of firmware
directories in hotplug's firmware script.

> Jun  3 17:43:16 joker kernel: usb 1-2: new full speed USB device using 
> uhci_hcd
> and address 65
> Jun  3 17:43:16 joker kernel: NET: Registered protocol family 8
> Jun  3 17:43:16 joker kernel: NET: Registered protocol family 20
> Jun  3 17:43:18 joker kernel: usbcore: registered new driver cxacru
> Jun  3 17:43:19 joker kernel: cxacru 1-2:1.0: firmware (cxacru-fw.bin) 
> unavailab
> le (hotplug misconfiguration?)

If the cxacru module is being loaded from an initrd, then it
may not be able to find the firmware if the root filesystem
hasn't been mounted yet.  In that case the simplest thing is
probably to place the firmware appropriately in the initrd.

Ciao,

Duncan.
