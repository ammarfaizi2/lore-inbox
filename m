Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031570AbWK3W1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031570AbWK3W1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031572AbWK3W1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:27:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:48199 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031570AbWK3W1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:27:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sqcY73Rm2yTN5dz+fr9YkkoqYIY7qLdzEMo6WPYw+d+7tG5lM8QTIb4Zq+ZmYD+NsWG9iky/wt/FrolufpxpgghgbsYB3GQgVwjmIhLDV958Ga0XZLvhnMA1Foy1JgYGHgJv+djBJzGCx29eQvEgPesLYJ61EsSYuiwUsUVDpkU=
Message-ID: <abe01d5c0611301427m4d7222fdgcd46abeade3328f5@mail.gmail.com>
Date: Thu, 30 Nov 2006 19:27:34 -0300
From: "Fausto Carvalho" <faustocarva@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [IDE0] Lost interrupt with CS5530A
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think some time ago somebody had the same problem:

"

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CS5530: ide CONTROLLER AT pci SLOT 0000:00:12.2
CS5530: chipset revision 0
CS5530: not 100% native mode: will probe irqs later
PCI: Enabling bus mastering for device 0000:00:12.2
PCI: Setting latency timer of device 0000:00:12.2 to 64
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: CF 32MB, CFA DISK drive
hda: IRQ probe failed (0xfeba)
ide0 at 0x1f0-0x1f7,0x3f6 on irq14
hdc: Hitachi CV 5.1.1, CFA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15 (serialized with ide0)
hda: max request size: 128KiB
hda: 62976 sectors (32MB) w/1KiB Cache, CHS=492/4/32
 hda:<4>hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

"

Windows and DOS works normaly, FreeBSD "timeout wainting for interrupt".
BIOS32 service directory not found.
PCI BIOS has not been found , using direct mode access.
The IRQ rounting table was not foud too.
I do not know if it is important but my BIOS is a XpressROM from NatiSemi.
And the chipset is a CS5530A not a Cs5530.
I have a lspci -xxx dump generated, if it can help:

00:00.0 Class 0600: Unknown device 1078:0001
00: 78 10 01 00 07 00 80 02 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 1e 10 00 c1 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 Class 0601: Unknown device 1078:0100 (rev 30)
00: 78 10 00 01 1f 00 80 02 30 00 01 06 04 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 89 18 ee 47 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 44 99 03 00 00 00 00 00 00 41 18 bb bb 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 a0 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 10 02 00 00 00 00 00 00 02 28 00 00 00 00
90: 04 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 0c 00 20 20 41 11 e9 12 00 00 00 00
c0: 1c ac 00 00 00 00 00 00 00 00 00 00 63 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.1 Class 0680: Unknown device 1078:0101
00: 78 10 01 01 02 00 80 02 00 00 80 06 00 00 00 00
10: 02 20 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 44 99 03 00 00 00 00 00 00 41 18 bb bb 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 a0 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 10 02 00 00 00 00 00 00 02 28 00 00 00 00
90: 04 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 0c 00 20 20 42 28 b4 12 00 00 00 00
c0: 1c ac 00 00 00 00 00 00 00 00 00 00 63 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.2 Class 0101: Unknown device 1078:0102
00: 78 10 02 01 05 00 80 02 00 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 44 99 03 00 00 00 00 00 00 41 18 bb bb 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 a0 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 10 02 00 00 00 00 00 00 02 28 00 00 00 00
90: 04 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 0c 00 20 20 43 02 96 12 00 00 00 00
c0: 1c ac 00 00 00 00 00 00 00 00 00 00 63 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.3 Class 0401: Unknown device 1078:0103
00: 78 10 03 01 06 00 80 02 00 00 01 04 00 00 00 00
10: 00 10 01 40 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 7b 44 99 03 00 00 00 00 00 00 41 18 bb bb 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 02 a0 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 07 00 10 02 00 00 00 00 00 00 02 28 00 00 00 00
90: 04 0b 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 0c 00 20 20 ef 01 b0 12 00 00 00 00
c0: 1c ac 00 00 00 00 00 00 00 00 00 00 63 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:12.4 Class 0300: Unknown device 1078:0104
00: 78 10 04 01 03 00 80 02 00 00 00 03 00 00 80 00
10: 00 00 80 40 00 00 01 40 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 78 10 4d 58
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 e8 3f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Any help is wellcome

-- 
Fausto Carvalho
