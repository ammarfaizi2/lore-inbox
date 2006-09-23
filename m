Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWIWJik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWIWJik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWIWJij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:38:39 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62655 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751417AbWIWJii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:38:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ray-gmail@madrabbit.org
Subject: Re: Bcm43xx softMac Driver in 2.6.18
Date: Sat, 23 Sep 2006 11:41:25 +0200
User-Agent: KMail/1.9.1
Cc: "Larry Finger" <Larry.Finger@lwfinger.net>, dbtsai@gmail.com,
       "John Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
References: <4513E308.10507@lwfinger.net> <2c0942db0609222303o50e47156xe6af9a50ed8301c8@mail.gmail.com>
In-Reply-To: <2c0942db0609222303o50e47156xe6af9a50ed8301c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231141.26090.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 23 September 2006 08:03, Ray Lee wrote:
> On 9/22/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> > When we found the cause of NETDEV watchdog timeouts in the wireless-2.6 code,
> > I knew that the 2.6.18 release code would cause a serious regression.
> 
> I don't know if this is the lockup you're trying to address, but
> 2.6.18's bcm43xx has definitely regressed for me versus 2.6.17.x.
> 
> 2.6.18 vanilla and 2.6.18 with your patch both lock my system hard
> with bcm43xx. I've got an HP/Compaq nx6125 laptop. Symptoms are that
> it will associate fine on its own and send traffic to/fro upon ifup,
> but when I do an iwconfig, ifdown, ifup to change the access point,
> the system locks (somewhat randomly) during one of those operations.
> Well, the iwconfig or the ifup, actually.

I have observed similar symptoms on HPC nx6325, although I haven't managed
to get the adapter associate with an AP.

This is a PCI-E card so I need some additional patches to make the driver
detect it, and I use the firmware cut from wl_apsta.o.  The kernel is also
64-bit, 2.6.18-rc6-mm2.

lspci -v:

30:00.0 Network controller: Broadcom Corporation BCM4310 UART (rev 01)
        Subsystem: Hewlett-Packard Company Unknown device 1361
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at c8000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
        Capabilities: [d0] Express Legacy Endpoint IRQ 0

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
