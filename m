Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280687AbRKBNeX>; Fri, 2 Nov 2001 08:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280689AbRKBNeN>; Fri, 2 Nov 2001 08:34:13 -0500
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:52229 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280687AbRKBNd4>; Fri, 2 Nov 2001 08:33:56 -0500
Date: Fri, 2 Nov 2001 14:33:54 +0100
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ (routing) problem with mediaGX
Message-ID: <20011102143354.E30033@bigmac.e-technik.uni-dortmund.de>
In-Reply-To: <20011026170143.B15834@bigmac.e-technik.uni-dortmund.de> <E15x9T9-0000VU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <E15x9T9-0000VU-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 26, 2001 at 05:04:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

sorry for making such a fuzz about such a simple problem... :)

I dropped natsemi.c from 2.4.4 in 2.4.13-ac5, and now network
works flawlessly, although the strange error message still remains:
(dmesg output):
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.0.5, April 17, 2001 Jeff Garzik, Tjeerd Mulder)
PCI: Found IRQ 10 for device 00:0e.0
IRQ routing conflict for 00:0e.0, have irq 11, want irq 10
eth0: NatSemi DP83815 at 0xc281f000, fb:ff:fb:ff:fb:ff, IRQ 11.
eth0: Transceiver status 0x7869 advertising 05e1.

The non-working natsemi.c dmesg output looks like this:
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.11, Oct 19, 2001  Jeff Garzi
k, Tjeerd Mulder)
PCI: Found IRQ 10 for device 00:0e.0
IRQ routing conflict for 00:0e.0, have irq 11, want irq 10
eth%d: EEPROM did not reload in 2000 usec.
eth0: NatSemi DP8381[56] at 0xc2820000, fb:ff:fb:ff:fb:ff, IRQ 11.
eth0: Transceiver status 0x7869 advertising 05e1.
eth0: link is back. Enabling watchdog.
eth0: Link changed: Autonegotiation advertising 05e1  partner 0000.
eth0: no link. Disabling watchdog.
eth0: Link wake-up event 00400617
eth0: Link changed: Autonegotiation advertising 05e1  partner 0000.

Note the additional transceiver messages!

The only difference of the first one to original 2.4.4 is the strange
occurence of IRQ10, but at least it works now... :)
(2.4.9 and 2.4.13 without any patches contain the same natsemi.c and
thus do _not_ work either) In case there is anything I can do to
help solve this strange IRQ mapping inconsistency, let me know!

Thanks to everybody!

Wolfgang

