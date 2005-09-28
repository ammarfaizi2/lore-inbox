Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVI1ImL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVI1ImL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVI1ImK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:42:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:57504 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1030216AbVI1ImJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:42:09 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
Mail-Copies-To: aj@dungeon.inka.de
Date: Wed, 28 Sep 2005 10:46:30 +0200
References: <20050927125300.24574.qmail@web51014.mail.yahoo.com> <43396A6A.30104@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20050928084206.38991212C7@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Fleury wrote:
> I might be wrong, but I don't think that there is any other way to get
> hardware information but through the /proc or /sys interface.
> 
> Can somebody comment on this ?

dmidecode will give you some hardware information on some systems.

for example my dell latitude c600 laptop the bios claims to support:
                        PCI is supported
                        PC Card (PCMCIA) is supported
                        PNP is supported
                        APM is supported
                        BIOS is upgradeable
                        BIOS shadowing is allowed
                        Boot from CD is supported
                        Selectable boot is supported
                        Boot from PC Card (PCMCIA) is supported
                        3.5"/720 KB floppy services are supported (int 13h)
                        Print screen service is supported (int 5h)
                        8042 keyboard services are supported (int 9h)
                        Serial services are supported (int 14h)
                        Printer services are supported (int 17h)
                        CGA/mono video services are supported (int 10h)
                        ACPI is supported
                        USB legacy is supported
                        AGP is supported
                        LS-120 boot is supported
                        ATAPI Zip drive boot is supported
                        Smart battery is supported
                        BIOS boot specification is supported

and the chipsets might include support for hardware that
is left dead. so it is nice to see which connectors the
mainboard has. dmidecode for example tells me:
Handle 0x0800
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: PARALLEL
                Internal Connector Type: None
                External Reference Designator: Not Specified
                External Connector Type: DB-25 female
                Port Type: Parallel Port PS/2
Handle 0x0801
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: SERIAL1
                Internal Connector Type: None
                External Reference Designator: Not Specified
                External Connector Type: DB-9 male
                Port Type: Serial Port 16550A Compatible

i.e. I have a serial and parallel connector. even more interesting
is:
Handle 0x0809
        DMI type 8, 9 bytes.
        Port Connector Information
                Internal Reference Designator: IrDA
                Internal Connector Type: None
                External Reference Designator: Not Specified
                External Connector Type: Infrared
                Port Type: Other

because irda hides behind a fake serial port, if I understand
things right, so now you know the first serial port is real,
the second not, but an irda port is missing.

also dmidecode has details on the cpu.

I hope that information helps? good luck!

Regards, Andreas
