Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTGPFuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270151AbTGPFuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:50:09 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:44748 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S270148AbTGPFuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:50:03 -0400
Date: Wed, 16 Jul 2003 16:04:43 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716060443.GA784@zip.com.au>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715161127.GA2925@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 09:11:27AM -0700, Greg KH wrote:
> On Tue, Jul 15, 2003 at 07:07:27PM +1000, CaT wrote:
> So, if you don't have any i2c code loaded, everything works?  How about

Yes.

> just loading the i2c driver and not the sensor driver?

All's fine.

> Oh, how about enabiling debugging in the i2c driver that you are using?

Well this is what I did:

11 [15:53:38] root@theirongiant:/usr/src/linux/drivers/i2c>> grep 'define DEBUG' . -r
./i2c-core.c:#define DEBUG 1            /* needed to pick up the dev_dbg() calls */
./scx200_acb.c:#define DEBUG 0
./i2c-sensor.c:#define DEBUG 1
./i2c-algo-bit.c:/* #define DEBUG 1 */
./i2c-dev.c:#define DEBUG 1
./i2c-algo-pcf.c:/* #define DEBUG 1 */          /* to pick up dev_dbg calls */
./busses/i2c-amd756.c:/* #define DEBUG 1 */
./busses/i2c-ali15x3.c:/* #define DEBUG 1 */
./busses/i2c-i801.c:/* #define DEBUG 1 */
./busses/i2c-piix4.c:#define DEBUG 1
./busses/i2c-sis96x.c:/* #define DEBUG */
./busses/i2c-ali1535.c:/* #define DEBUG 1 */
./chips/adm1021.c:#define DEBUG 1
./chips/lm75.c:/* #define DEBUG 1 */

Did I do the right thing?

> Any interesting info in the kernel log would be appreciated.

Unfortunately I didn't get anything special:

serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
i2c-piix4 version 2.7.0 (20021208)
piix4-smbus 0000:00:07.3: Found Intel Corp. 82371AB/EB/MB PIIX4  device
registering 0-004d
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
PCI: Enabling device 0000:00:0c.0 (0000 -> 0003)

I let it boot, thinking I might try using it but I must've pressed 
ctrl-alt-del because when I woke up an hour later (ahm - it got REALLY
boring watching the laptop boot :) it was midway through a reboot. What's
more is that I believe the problem survived the reboot because my default
kernel the hasn't any i2c code in it got as far as:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DV-28E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15

By the time I woke up and it was't getting anywhere fast. I got impatient
then though and just power-cycled my laptop and all was well.

Anything else I can do? I've got a null-modem cable now so I can do
anything where that might come in handy.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
