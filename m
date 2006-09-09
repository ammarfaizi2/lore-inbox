Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWIIPLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWIIPLv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWIIPLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:11:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:47772 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932256AbWIIPLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:11:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rCg4t14Gx4PhmfFrrTQKy/cxAKQc8HEEknr/R7QdDhv+wDONM86Tljf5OsffKhCuvSwPX6utminJ6+3q2Y5SiNHQhwVcPllzZ2EqL3okywCFIfhTFNnBiDk3Wa0ozgkpUNrg956+b2mq4dLMILhWwpDMi3Q6ulKBS/TFJKiO91s=
Message-ID: <ec36785a0609090811m5ded669alc5e1bf361ca37b4@mail.gmail.com>
Date: Sat, 9 Sep 2006 12:11:48 -0300
From: "Reinaldo Carvalho" <reinaldow@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: agpgart v0.101 problem AMD K8 NorthBridge
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

agpgart detect incorrect aperture size (is set to 128Mb) and X crash
when use nvidia driver (any version). kernel 2.6.17

Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 32M @ 0xe8000000

config:

CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set

# modprobe -v nvidia
insmod /lib/modules/2.6.17/kernel/drivers/video/nvidia.ko
NVreg_EnableAGPSBA=1 NVreg_EnableAGPFW=1

Sep  9 12:00:34 akina kernel: ACPI: PCI Interrupt 0000:01:00.0[A] ->
GSI 16 (level, low) -> IRQ 20
Sep  9 12:00:34 akina kernel: NVRM: loading NVIDIA Linux x86 Kernel
Module  1.0-8774  Tue Aug  1 20:54:08 PDT 2006


lspci:

0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0282
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1282
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2282
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3282
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4282
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7282
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420
SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel
537 [AC97 Modem] (rev 80)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102
[Rhine-II] (rev 78)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown
device 0326 (rev a1)

0000:00:18.0 0600: 1022:1100
0000:00:18.1 0600: 1022:1101
0000:00:18.2 0600: 1022:1102
0000:00:18.3 0600: 1022:1103


0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00
40: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
50: 01 01 01 00 01 01 01 00 01 01 01 00 01 01 01 00
60: 00 00 00 00 e4 00 00 00 0f cc 00 0f 1c 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 08 00 01 21 20 00 11 11 22 05 35 80 02 00 00 00
90: 56 04 51 02 00 00 ff 00 07 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 03 00 00 00 00 00 1f 00 00 00 00 00 01 00 00 00
50: 00 00 00 00 02 00 00 00 00 00 00 00 03 00 00 00
60: 00 00 00 00 04 00 00 00 00 00 00 00 05 00 00 00
70: 00 00 00 00 06 00 00 00 00 00 00 00 07 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 03 0a 00 00 00 0b 00 00 03 00 20 00 00 ff ff 00
c0: 13 10 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 03 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 00 00 00 01 00 00 01 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 fe e0 00 00 fe e0 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 04 00 00 00 00 00 00 00 f2 6f f4 16 31 0b 00 00
90: 00 8c 0c 58 06 06 7b 3e 00 00 00 00 0d 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 7b b8 30 6d 66 00 00 00 94 ff 04 00 84 99 7c 0a
c0: 00 80 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: e9 76 12 0e d0 71 c4 d6 a3 ee 4e 51 c9 2a e3 31
e0: 2a f6 73 f6 76 64 92 8f 73 11 40 21 a2 b0 22 2d
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 7f 7d
60: a7 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 11 01 02 51 11 80 00 50 00 38 00 08 1b 22 00 00
80: 00 00 07 23 13 21 13 21 00 00 00 00 00 00 00 00
90: 01 00 00 00 70 10 00 00 00 d2 1f 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 3f 00 00 c0 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 a7 0d 00 00 00 40 00 00 00 00 00
e0: 00 00 00 00 20 09 53 14 08 05 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


nvagp+nvidia driver work.

-- 
Reinaldo Carvalho
