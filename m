Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSFUMXT>; Fri, 21 Jun 2002 08:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFUMXS>; Fri, 21 Jun 2002 08:23:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26894 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316578AbSFUMXR> convert rfc822-to-8bit; Fri, 21 Jun 2002 08:23:17 -0400
Message-ID: <3D131AB4.8090906@evision-ventures.com>
Date: Fri, 21 Jun 2002 14:23:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.5.23+ bootflag.c triggers __iounmap: bad address
References: <200206211156.NAA13885@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Mikael Pettersson napisa³:
> When booting 2.5.23/.24, my test boxes generate the following:
> 
> (an ASUS P4T-E which has SBF)
> __iounmap: bad address d0802100
> SBF: Simple Boot Flag extension found and enabled.
> __iounmap: bad address d0805040
> __iounmap: bad address d0808080
> SBF: Setting boot flags 0x1
> 
> (an old Intel AL440LX which doesn't have SBF)
> __iounmap: bad address c4800009
> __iounmap: bad address c4804b8c
> __iounmap: bad address c4802009
> 
> These warnings/errors are new since 2.5.23, which makes me
> suspect something's wrong in the 2.5.23 iounmap changes.

Just to complete the pattern: ASUS S8600 gives me the following:


PCI: Found IRQ 5 for device 00:0c.1
PCI: Sharing IRQ 5 with 00:00.2
PCI: Sharing IRQ 5 with 00:06.0
__iounmap: bad address cc800cb7
__iounmap: bad address cc804b64
SBF: Simple Boot Flag extension found and enabled.
__iounmap: bad address cc807bd8
__iounmap: bad address cc802cb7
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)


With the mapping beein:

BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e5800 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000bff0000 (usable)
  BIOS-e820: 000000000bff0000 - 000000000bfffc00 (ACPI data)
  BIOS-e820: 000000000bfffc00 - 000000000c000000 (ACPI NVS)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49136
zone(0): 4096 pages.
zone(1): 45040 pages.
zone(2): 0 pages.

