Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSEKIEo>; Sat, 11 May 2002 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314494AbSEKIEn>; Sat, 11 May 2002 04:04:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4115 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314448AbSEKIEn>;
	Sat, 11 May 2002 04:04:43 -0400
Message-ID: <3CDCD159.8F9049C4@zip.com.au>
Date: Sat, 11 May 2002 01:07:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@actcom.co.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com 3c905cx-tx-nm "unknown device"
In-Reply-To: <20020511103650.A790@actcom.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> 
> Hello,
> 
> I have new 3com PCI NIC, which purpots to be a "3c905cx-tx-nm". The
> 3c59x module (kernel 2.4.19-pre3-ac2, I'll try -pre8 in a bit) fails
> to recognize the card.

Well it would...

> lspci -vx (with the latest pci.ids file) shows:
> 
> 00:09.0 Ethernet controller: 3Com Corporation: Unknown device ffff (rev 78)
>      Flags: bus master, medium devsel, latency 64, IRQ 11
>      I/O ports at 6500 [size=128]
>      Expansion ROM at <unassigned> [disabled] [size=128K]
>      Capabilities: [dc] Power Management version 2
> 00: b7 10 ff ff 07 00 10 02 78 00 00 02 08 40 00 00
> 10: 01 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 1e 3f

PCI IDs are 0xffff.  Normally that is supplied from the EEPROM (we think).

Try setting the NIC up with 3com's DOS-based setup program 
ftp://ftp.3com.com/pub/nic/3c90x/3c90xx2.exe and also check your
BIOS power management settings, PnP OS settings, etc.

Try to work out why the EEPROM hasn't been powered up - could be
a dead card (test it under Windows) or a BIOS thing.

-
