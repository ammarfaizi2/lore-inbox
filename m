Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277540AbRJOOQQ>; Mon, 15 Oct 2001 10:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJOOQH>; Mon, 15 Oct 2001 10:16:07 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:21256 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S277540AbRJOOPv>; Mon, 15 Oct 2001 10:15:51 -0400
Date: Mon, 15 Oct 2001 10:15:50 -0400 (EDT)
From: Ion Badulescu <ion@cs.columbia.edu>
X-X-Sender: <ion@guppy.limebrokerage.com>
To: Thomas Hood <jdthood@mail.com>
cc: <linux-kernel@vger.kernel.org>, <stelian.pop@fr.alcove.com>,
        <sduchene@mindspring.com>, <jurgen@botz.org>
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
In-Reply-To: <1002987648.764.23.camel@thanatos>
Message-ID: <Pine.LNX.4.33.0110151012240.10877-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Oct 2001, Thomas Hood wrote:

> Vaio users: Please make sure that this doesn't oops.
> Others: Try using setpnp to change the current configuration.
> Unload and reload the parport drivers to check that they
> reinitialize with the updated resource information provided
> by the PnP BIOS driver.

Works here on the inspiron 5k. Parport detects its config correctly, even 
after multiple loads/unloads, lspnp and setpnp seem to be doing the right 
thing, parport detects the new parameters after changing them with setpnp.

Relevant dmesg output:

PnPBIOS: Found PnP BIOS installation structure at 0xc00f7230.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa610, dseg 0x400.
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver.
PnPBIOS: PNP0c02: 0xfff80000-0xffffffff was already reserved
PnPBIOS: PNP0c01: 0xe8000-0xfffff was already reserved
PnPBIOS: PNP0c01: 0x100000-0xbffffff was already reserved
PnPBIOS: PNP0c02: 0x4d0-0x4d1 has been reserved
PnPBIOS: PNP0c02: 0x1000-0x103f has been reserved
PnPBIOS: PNP0c02: 0x1040-0x104f has been reserved
SBF: ACPI BOOT descriptor is wrong length (39)
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
parport: PnP BIOS reports device PNPBIOS PNP0401 (node number 0x16) is 
configured to use io 0x0378, io 0x0778, irq 7, dma 3
[and then after 'setpnp 16 dma 1']
parport: PnP BIOS reports device PNPBIOS PNP0401 (node number 0x16) is 
configured to use io 0x0378, io 0x0778, irq 7, dma 1

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

