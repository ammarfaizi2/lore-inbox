Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCOTXZ>; Fri, 15 Mar 2002 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCOTXR>; Fri, 15 Mar 2002 14:23:17 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:13655 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293175AbSCOTWF>; Fri, 15 Mar 2002 14:22:05 -0500
Message-ID: <3C9249CB.2020901@ngforever.de>
Date: Fri, 15 Mar 2002 12:21:47 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9+) Gecko/20020314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tmscsi smashed in linux-2.5.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I downloaded the kernel 2.5.6 from kernel.org and tried to compile it on 
a amd k6-II with 384 megs of ram and asus p5a mainboard. this pc has a 
tekram dc-390 scsi host controller.
I might be able to do this on my own, but there ain't no time, I gotta 
leave right now.

gcc is version 3.0.4, binutils is 2.11.90.0.8

fortunately, it's not me who needs this kernel ;-)

tmscsim.c: In function `DC390_waiting_timed_out':
tmscsim.c:1077: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:1081: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c: In function `dc390_BuildSRB':
tmscsim.c:1149: structure has no member named `address'
In file included from tmscsim.c:1826:
scsiiom.c:9:2: #error Please convert me to Documentation/DMA-mapping.txt
In file included from tmscsim.c:1826:
scsiiom.c: In function `DC390_Interrupt':
scsiiom.c:267: `DC390_LOCK_IO' undeclared (first use in this function)
scsiiom.c:267: (Each undeclared identifier is reported only once
scsiiom.c:267: for each function it appears in.)
scsiiom.c:343: `DC390_UNLOCK_IO' undeclared (first use in this function)
scsiiom.c:229: warning: unused variable `iflags'
scsiiom.c: In function `dc390_DataOut_0':
scsiiom.c:384: structure has no member named `address'
scsiiom.c: In function `dc390_DataIn_0':
scsiiom.c:448: structure has no member named `address'
scsiiom.c:506: warning: passing arg 1 of 
`bus_to_virt_not_defined_use_pci_map' makes pointer from integer without 
a cast
scsiiom.c: In function `dc390_restore_ptr':
scsiiom.c:747: structure has no member named `address'
scsiiom.c:761: structure has no member named `address'
scsiiom.c:764: structure has no member named `address'
scsiiom.c: In function `dc390_DataIO_Comm':
scsiiom.c:898: structure has no member named `address'
scsiiom.c: In function `dc390_SRBdone':
scsiiom.c:1373: structure has no member named `address'
scsiiom.c:1448: structure has no member named `address'
scsiiom.c:1523: structure has no member named `address'
scsiiom.c: In function `dc390_RequestSense':
scsiiom.c:1764: structure has no member named `address'
tmscsim.c: In function `dc390_set_info':
tmscsim.c:2561: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2729: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2737: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2747: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2755: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2769: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2784: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2799: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2815: request for member `pScsiHost' in something not a 
structure or union
tmscsim.c:2823: request for member `pScsiHost' in something not a 
structure or union

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:06.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 
Audiodrive (rev 01)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev c3)
00:09.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 
[PCscsi] (rev 10)
00:0a.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane 
(rev 30)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 
(rev 04)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 01)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

Thunder
-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
 > uudecode $file | perl

