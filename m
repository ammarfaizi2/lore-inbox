Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKANtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKANtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVKANtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:49:08 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:22717 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750767AbVKANtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:49:07 -0500
Message-ID: <43677257.4090506@free.fr>
Date: Tue, 01 Nov 2005 14:49:11 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net,
       usbatm@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org> <200511011340.41266.duncan.sands@math.u-psud.fr>
In-Reply-To: <200511011340.41266.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

Duncan Sands wrote:
> Hi Andrew,
> 
> 
> this code looks like a 'orrible hack to work around a common problem
> with USB modem's of this type: if the modem is plugged in while the
> system boots, the driver may look for firmware before the filesystem

No, it wasn't the problem, even when loading with insmod/modprobe the 
timeout occurs on some configurations. For example on 
http://atm.eagle-usb.org/wakka.php?wiki=TestUEagleAtmBaud123, you could 
see the 'firmware ueagle-atm/eagleIII.fw is not available' error.

It is only happen for pre-firmware modem (uea_load_firmware) ie where we 
just do a request_firmware in the probe without any initialisation before.
So the problem seems to appear when we do a request_firmware too early 
in the usb_probe.


Matthieu
