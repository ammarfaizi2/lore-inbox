Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVKBHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVKBHqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVKBHqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:46:02 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:30612 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932626AbVKBHqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:46:00 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 08:45:54 +0100
User-Agent: KMail/1.8.3
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <200511011340.41266.duncan.sands@math.u-psud.fr> <43677257.4090506@free.fr>
In-Reply-To: <43677257.4090506@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020845.56419.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this code looks like a 'orrible hack to work around a common problem
> > with USB modem's of this type: if the modem is plugged in while the
> > system boots, the driver may look for firmware before the filesystem
> 
> No, it wasn't the problem, even when loading with insmod/modprobe the 
> timeout occurs on some configurations. For example on 
> http://atm.eagle-usb.org/wakka.php?wiki=TestUEagleAtmBaud123, you could 
> see the 'firmware ueagle-atm/eagleIII.fw is not available' error.
> 
> It is only happen for pre-firmware modem (uea_load_firmware) ie where we 
> just do a request_firmware in the probe without any initialisation before.
> So the problem seems to appear when we do a request_firmware too early 
> in the usb_probe.

That sounds pretty strange.  Maybe when probe is called the driver model
device (sysfs) is not completely setup, in any case not enough to support
firmware loading?

Ciao,

Duncan.
