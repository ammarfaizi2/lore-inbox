Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274881AbTHKW6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274889AbTHKW6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:58:20 -0400
Received: from bay1-f142.bay1.hotmail.com ([65.54.245.142]:25614 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S274881AbTHKW5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:57:45 -0400
X-Originating-IP: [66.130.253.98]
X-Originating-Email: [n0px90@hotmail.com]
From: "n0p n0p" <n0px90@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cpu fan (acpi)
Date: Mon, 11 Aug 2003 22:57:41 +0000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_384d_904_e33"
Message-ID: <BAY1-F142BBDNfaOR6D00033331@hotmail.com>
X-OriginalArrivalTime: 11 Aug 2003 22:57:41.0785 (UTC) FILETIME=[F8232890:01C3605B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_384d_904_e33
Content-Type: text/plain; format=flowed

Sometime, the fan of my dell laptop goes to speed 3 even if the
temperature of the cpu is low.

The fan of my laptop run at speed 1 if the temperature is from 44C to 49C,
speed 2 from 50C to 59C and speed 3 from 60C to ... But sometime when I
write a text or something that isn't really using the cpu, my fan decide to
go to speed 3 without any reason. I can solve the problem if I restart my
computer or if I start a process that use the cpu a lot until the
tempurature reach 60C or more and then stop it.

I have a p4 using cpufreq and I don't use any modules for acpi in my kernel

# Power management options (ACPI, APM)
# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_SERIAL_8250_ACPI is not set

Here the interesting things about ACPI in dmesg :

ACPI: RSDP (v000 Acer                       ) @ 0x000fe030
ACPI: RSDT (v001 Acer   TMH2     00000.00001) @ 0x1ffe0000
ACPI: FADT (v001 Acer   TMH2     00000.00001) @ 0x1ffe0054
ACPI: BOOT (v001 Acer   TMH2     00000.00001) @ 0x1ffe002c
ACPI: DSDT (v001    H2       H2  00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist

cat /proc/version
Linux version 2.6.0-test3 (root@localhost) (gcc version 3.2.2) #2 Fri Aug 1
22:24:04 EDT 2003

I don't know if this is related to the problem but this is the listening of
dmesg when I have used my computer for some times :

B_.BAT0._BST] (Node dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS
    ACPI-0269: *** Error: Looking up [BUF0] in namespace, AE_ALREADY_EXISTS
    ACPI-1121: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node 
dff4d2a0), AE_ALREADY_EXISTS

radeon 115736 2 - Live 0xe1902000
orinoco_cs 7048 1 - Live 0xe18c4000
orinoco 44676 1 orinoco_cs, Live 0xe18d3000
hermes 7936 2 orinoco_cs,orinoco, Live 0xe18c1000

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
1800-18ff : PCI CardBus #07
1c00-1cff : PCI CardBus #07
7000-70ff : Realtek Semiconducto RTL-8139/8139C/8139C
  7000-70ff : 8139too
8000-801f : Intel Corp. 82801BA/BAM USB (Hub
  8000-801f : uhci-hcd
8060-807f : Intel Corp. 82801BA/BAM USB (Hub
  8060-807f : uhci-hcd
a000-afff : PCI Bus #01
  a000-a0ff : ATI Technologies Inc Radeon Mobility M6 L
b000-b0ff : Intel Corp. 82801BA/BAM AC'97 Au
  b000-b0ff : Intel ICH2
b400-b43f : Intel Corp. 82801BA/BAM AC'97 Au
  b400-b43f : Intel ICH2
b800-b8ff : Intel Corp. 82801BA/BAM AC'97 Mo
bc00-bc7f : Intel Corp. 82801BA/BAM AC'97 Mo
bc90-bc9f : Intel Corp. 82801BA IDE U100
  bc90-bc97 : ide0
  bc98-bc9f : ide1
f300-f30f : Intel Corp. 82801BA/BAM SMBus

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffdffff : System RAM
  00100000-00358838 : Kernel code
  00358839-0044f5ff : Kernel data
1ffe0000-1fff7fff : ACPI Non-volatile Storage
20000000-20000fff : Texas Instruments PCI1250 PC card Card
20001000-20001fff : Texas Instruments PCI1250 PC card Card (#2)
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
60000000-60000fff : card services
80100000-801007ff : Texas Instruments TSB43AB21 IEEE-1394a
80100800-801008ff : Realtek Semiconducto RTL-8139/8139C/8139C
  80100800-801008ff : 8139too
80104000-80107fff : Texas Instruments TSB43AB21 IEEE-1394a
80500000-805fffff : PCI Bus #01
  80500000-8050ffff : ATI Technologies Inc Radeon Mobility M6 L
80600000-900fffff : PCI Bus #01
  88000000-8fffffff : ATI Technologies Inc Radeon Mobility M6 L
    88000000-88ffffff : vesafb
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale
ffff0000-ffffffff : reserved

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 04)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05)
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05)
00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio 
(rev 05)
00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 05)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 
LY
02:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 
Controller (PHY/Link)
02:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
02:09.0 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)
02:09.1 CardBus bridge: Texas Instruments PCI1250 PC card Cardbus Controller 
(rev 01)

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.20GHz
stepping	: 4
cpu MHz		: 550.012
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 1085.44

The real speed of my cpu is 2200.048 but I told you I'm using cpufreq...

P.S. I joined the same message but in the original format (Txt file).

_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*.  
http://join.msn.com/?page=features/featuredemail

------=_NextPart_000_384d_904_e33
Content-Type: application/octet-stream; name="acpi"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpi"

U29tZXRpbWUsIHRoZSBmYW4gb2YgbXkgZGVsbCBsYXB0b3AgZ29lcyB0byBz
cGVlZCAzIGV2ZW4gaWYgdGhlCnRlbXBlcmF0dXJlIG9mIHRoZSBjcHUgaXMg
bG93LgoKVGhlIGZhbiBvZiBteSBsYXB0b3AgcnVuIGF0IHNwZWVkIDEgaWYg
dGhlIHRlbXBlcmF0dXJlIGlzIGZyb20gNDRDIHRvIDQ5QywKc3BlZWQgMiBm
cm9tIDUwQyB0byA1OUMgYW5kIHNwZWVkIDMgZnJvbSA2MEMgdG8gLi4uIEJ1
dCBzb21ldGltZSB3aGVuIEkKd3JpdGUgYSB0ZXh0IG9yIHNvbWV0aGluZyB0
aGF0IGlzbid0IHJlYWxseSB1c2luZyB0aGUgY3B1LCBteSBmYW4gZGVjaWRl
IHRvCmdvIHRvIHNwZWVkIDMgd2l0aG91dCBhbnkgcmVhc29uLiBJIGNhbiBz
b2x2ZSB0aGUgcHJvYmxlbSBpZiBJIHJlc3RhcnQgbXkKY29tcHV0ZXIgb3Ig
aWYgSSBzdGFydCBhIHByb2Nlc3MgdGhhdCB1c2UgdGhlIGNwdSBhIGxvdCB1
bnRpbCB0aGUKdGVtcHVyYXR1cmUgcmVhY2ggNjBDIG9yIG1vcmUgYW5kIHRo
ZW4gc3RvcCBpdC4KCkkgaGF2ZSBhIHA0IHVzaW5nIGNwdWZyZXEgYW5kIEkg
ZG9uJ3QgdXNlIGFueSBtb2R1bGVzIGZvciBhY3BpIGluIG15IGtlcm5lbAoK
IyBQb3dlciBtYW5hZ2VtZW50IG9wdGlvbnMgKEFDUEksIEFQTSkKIyBBQ1BJ
IFN1cHBvcnQKQ09ORklHX0FDUEk9eQpDT05GSUdfQUNQSV9CT09UPXkKQ09O
RklHX0FDUElfQUM9eQpDT05GSUdfQUNQSV9CQVRURVJZPXkKQ09ORklHX0FD
UElfQlVUVE9OPXkKQ09ORklHX0FDUElfRkFOPXkKQ09ORklHX0FDUElfUFJP
Q0VTU09SPXkKQ09ORklHX0FDUElfVEhFUk1BTD15CiMgQ09ORklHX0FDUElf
QVNVUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FDUElfVE9TSElCQSBpcyBub3Qg
c2V0CiMgQ09ORklHX0FDUElfREVCVUcgaXMgbm90IHNldApDT05GSUdfQUNQ
SV9CVVM9eQpDT05GSUdfQUNQSV9JTlRFUlBSRVRFUj15CkNPTkZJR19BQ1BJ
X0VDPXkKQ09ORklHX0FDUElfUE9XRVI9eQpDT05GSUdfQUNQSV9QQ0k9eQpD
T05GSUdfQUNQSV9TWVNURU09eQojIENPTkZJR19YODZfQUNQSV9DUFVGUkVR
IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VSSUFMXzgyNTBfQUNQSSBpcyBub3Qg
c2V0CgpIZXJlIHRoZSBpbnRlcmVzdGluZyB0aGluZ3MgYWJvdXQgQUNQSSBp
biBkbWVzZyA6CgpBQ1BJOiBSU0RQICh2MDAwIEFjZXIgICAgICAgICAgICAg
ICAgICAgICAgICkgQCAweDAwMGZlMDMwCkFDUEk6IFJTRFQgKHYwMDEgQWNl
ciAgIFRNSDIgICAgIDAwMDAwLjAwMDAxKSBAIDB4MWZmZTAwMDAKQUNQSTog
RkFEVCAodjAwMSBBY2VyICAgVE1IMiAgICAgMDAwMDAuMDAwMDEpIEAgMHgx
ZmZlMDA1NApBQ1BJOiBCT09UICh2MDAxIEFjZXIgICBUTUgyICAgICAwMDAw
MC4wMDAwMSkgQCAweDFmZmUwMDJjCkFDUEk6IERTRFQgKHYwMDEgICAgSDIg
ICAgICAgSDIgIDAwMDAwLjA0MDk2KSBAIDB4MDAwMDAwMDAKQUNQSTogQklP
UyBwYXNzZXMgYmxhY2tsaXN0CgpjYXQgL3Byb2MvdmVyc2lvbiAKTGludXgg
dmVyc2lvbiAyLjYuMC10ZXN0MyAocm9vdEBsb2NhbGhvc3QpIChnY2MgdmVy
c2lvbiAzLjIuMikgIzIgRnJpIEF1ZyAxCjIyOjI0OjA0IEVEVCAyMDAzCgpJ
IGRvbid0IGtub3cgaWYgdGhpcyBpcyByZWxhdGVkIHRvIHRoZSBwcm9ibGVt
IGJ1dCB0aGlzIGlzIHRoZSBsaXN0ZW5pbmcgb2YKZG1lc2cgd2hlbiBJIGhh
dmUgdXNlZCBteSBjb21wdXRlciBmb3Igc29tZSB0aW1lcyA6CgpCXy5CQVQw
Ll9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAg
IEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBu
YW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoq
KiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAu
X0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAg
QUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5h
bWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioq
IEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5f
QlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBB
Q1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFt
ZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiog
RXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9C
U1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKU3luYXB0
aWNzIGRyaXZlciBsb3N0IHN5bmMgYXQgMXN0IGJ5dGUKU3luYXB0aWNzIGRy
aXZlciBsb3N0IHN5bmMgYXQgMXN0IGJ5dGUKU3luYXB0aWNzIGRyaXZlciBs
b3N0IHN5bmMgYXQgMXN0IGJ5dGUKU3luYXB0aWNzIGRyaXZlciBsb3N0IHN5
bmMgYXQgMXN0IGJ5dGUKU3luYXB0aWNzIGRyaXZlciBsb3N0IHN5bmMgYXQg
MXN0IGJ5dGUKU3luYXB0aWNzIGRyaXZlciByZXN5bmNlZC4KICAgIEFDUEkt
MDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3Bh
Y2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJv
cjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0g
KE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0w
MjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFj
ZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9y
OiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAo
Tm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAy
Njk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNl
LCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6
IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChO
b2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2
OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2Us
IEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjog
TWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5v
ZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5
OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwg
QUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBN
ZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9k
ZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6
ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBB
RV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1l
dGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2Rl
IGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTog
KioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFF
X0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0
aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUg
ZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAq
KiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVf
QUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRo
b2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBk
ZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoq
KiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9B
TFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhv
ZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRm
ZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioq
IEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FM
UkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9k
IGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZm
NGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiog
RXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxS
RUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2Qg
ZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0
ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBF
cnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJF
QURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBl
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRk
MmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVy
cm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVB
RFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4
ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQy
YTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJy
b3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFE
WV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhl
Y3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJh
MCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJv
cjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZ
X0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEw
KSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9y
OiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlf
RVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1
dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTAp
LCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6
IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9F
WElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0
aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCks
IEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjog
TG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VY
SVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwg
QUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBM
b29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJ
U1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlv
biBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBB
RV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExv
b2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElT
VFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9u
IGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFF
X0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9v
a2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNU
UwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVf
QUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29r
aW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RT
CiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBm
YWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9B
TFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tp
bmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMK
ICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZh
aWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FM
UkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2lu
ZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwog
ICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxS
RUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5n
IHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAg
ICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWls
ZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJF
QURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcg
dXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAg
IEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxl
ZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVB
RFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1
cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAg
QUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFE
WV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVw
IFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBB
Q1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQg
W1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZ
X0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAg
W0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFD
UEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBb
XF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlf
RVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBb
QlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQ
SS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9F
WElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtC
VUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJ
LTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xf
U0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VY
SVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JV
RjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEkt
MTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9T
Ql8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJ
U1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVG
MF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0x
MTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElT
VFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYw
XSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTEx
MjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0Jf
LkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNU
UwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBd
IGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEy
MTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8u
QkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RT
CiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0g
aW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIx
OiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5C
QVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMK
ICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBp
biBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6
ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJB
VDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwog
ICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGlu
IG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTog
KioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFU
MC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAg
ICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4g
bmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAq
KiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQw
Ll9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAg
IEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBu
YW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoq
KiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAu
X0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAg
QUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5h
bWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioq
IEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5f
QlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBB
Q1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFt
ZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiog
RXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9C
U1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFD
UEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1l
c3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBF
cnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JT
VF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQ
SS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVz
cGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVy
cm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNU
XSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJ
LTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNw
YWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJy
b3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1Rd
IChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEkt
MDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3Bh
Y2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJv
cjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0g
KE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0w
MjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFj
ZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9y
OiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAo
Tm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAy
Njk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNl
LCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6
IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChO
b2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2
OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2Us
IEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjog
TWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5v
ZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5
OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwg
QUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBN
ZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9k
ZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6
ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBB
RV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1l
dGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2Rl
IGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTog
KioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFF
X0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0
aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUg
ZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAq
KiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVf
QUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRo
b2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBk
ZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoq
KiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9B
TFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhv
ZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRm
ZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioq
IEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FM
UkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9k
IGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZm
NGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiog
RXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxS
RUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2Qg
ZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0
ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBF
cnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJF
QURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBl
eGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRk
MmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVy
cm9yOiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVB
RFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4
ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQy
YTApLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJy
b3I6IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFE
WV9FWElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhl
Y3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJh
MCksIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJv
cjogTG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZ
X0VYSVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVj
dXRpb24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEw
KSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9y
OiBMb29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlf
RVhJU1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1
dGlvbiBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTAp
LCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6
IExvb2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9F
WElTVFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0
aW9uIGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCks
IEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjog
TG9va2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VY
SVNUUwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRp
b24gZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwg
QUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBM
b29raW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJ
U1RTCiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlv
biBmYWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBB
RV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExv
b2tpbmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElT
VFMKICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9u
IGZhaWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFF
X0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9v
a2luZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNU
UwogICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24g
ZmFpbGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVf
QUxSRUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29r
aW5nIHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RT
CiAgICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBm
YWlsZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9B
TFJFQURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tp
bmcgdXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMK
ICAgIEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZh
aWxlZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FM
UkVBRFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2lu
ZyB1cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwog
ICAgQUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFp
bGVkIFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxS
RUFEWV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5n
IHVwIFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAg
ICBBQ1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWls
ZWQgW1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJF
QURZX0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcg
dXAgW0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAg
IEFDUEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxl
ZCBbXF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVB
RFlfRVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1
cCBbQlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAg
QUNQSS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVk
IFtcX1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFE
WV9FWElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVw
IFtCVUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBB
Q1BJLTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQg
W1xfU0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZ
X0VYSVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAg
W0JVRjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFD
UEktMTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBb
XF9TQl8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlf
RVhJU1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBb
QlVGMF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQ
SS0xMTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtc
X1NCXy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9F
WElTVFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtC
VUYwXSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJ
LTExMjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xf
U0JfLkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VY
SVNUUwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JV
RjBdIGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEkt
MTEyMTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9T
Ql8uQkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJ
U1RTCiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVG
MF0gaW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0x
MTIxOiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NC
Xy5CQVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElT
VFMKICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYw
XSBpbiBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTEx
MjE6ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0Jf
LkJBVDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNU
UwogICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBd
IGluIG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEy
MTogKioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8u
QkFUMC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RT
CiAgICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0g
aW4gbmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIx
OiAqKiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5C
QVQwLl9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMK
ICAgIEFDUEktMDI2OTogKioqIEVycm9yOiBMb29raW5nIHVwIFtCVUYwXSBp
biBuYW1lc3BhY2UsIEFFX0FMUkVBRFlfRVhJU1RTCiAgICBBQ1BJLTExMjE6
ICoqKiBFcnJvcjogTWV0aG9kIGV4ZWN1dGlvbiBmYWlsZWQgW1xfU0JfLkJB
VDAuX0JTVF0gKE5vZGUgZGZmNGQyYTApLCBBRV9BTFJFQURZX0VYSVNUUwog
ICAgQUNQSS0wMjY5OiAqKiogRXJyb3I6IExvb2tpbmcgdXAgW0JVRjBdIGlu
IG5hbWVzcGFjZSwgQUVfQUxSRUFEWV9FWElTVFMKICAgIEFDUEktMTEyMTog
KioqIEVycm9yOiBNZXRob2QgZXhlY3V0aW9uIGZhaWxlZCBbXF9TQl8uQkFU
MC5fQlNUXSAoTm9kZSBkZmY0ZDJhMCksIEFFX0FMUkVBRFlfRVhJU1RTCiAg
ICBBQ1BJLTAyNjk6ICoqKiBFcnJvcjogTG9va2luZyB1cCBbQlVGMF0gaW4g
bmFtZXNwYWNlLCBBRV9BTFJFQURZX0VYSVNUUwogICAgQUNQSS0xMTIxOiAq
KiogRXJyb3I6IE1ldGhvZCBleGVjdXRpb24gZmFpbGVkIFtcX1NCXy5CQVQw
Ll9CU1RdIChOb2RlIGRmZjRkMmEwKSwgQUVfQUxSRUFEWV9FWElTVFMKCnJh
ZGVvbiAxMTU3MzYgMiAtIExpdmUgMHhlMTkwMjAwMApvcmlub2NvX2NzIDcw
NDggMSAtIExpdmUgMHhlMThjNDAwMApvcmlub2NvIDQ0Njc2IDEgb3Jpbm9j
b19jcywgTGl2ZSAweGUxOGQzMDAwCmhlcm1lcyA3OTM2IDIgb3Jpbm9jb19j
cyxvcmlub2NvLCBMaXZlIDB4ZTE4YzEwMDAKCjAwMDAtMDAxZiA6IGRtYTEK
MDAyMC0wMDIxIDogcGljMQowMDQwLTAwNWYgOiB0aW1lcgowMDYwLTAwNmYg
OiBrZXlib2FyZAowMDcwLTAwNzcgOiBydGMKMDA4MC0wMDhmIDogZG1hIHBh
Z2UgcmVnCjAwYTAtMDBhMSA6IHBpYzIKMDBjMC0wMGRmIDogZG1hMgowMGYw
LTAwZmYgOiBmcHUKMDEwMC0wMTNmIDogb3Jpbm9jb19jcwowMTcwLTAxNzcg
OiBpZGUxCjAxZjAtMDFmNyA6IGlkZTAKMDM3Ni0wMzc2IDogaWRlMQowM2Mw
LTAzZGYgOiB2ZXNhZmIKMDNmNi0wM2Y2IDogaWRlMAowM2Y4LTAzZmYgOiBz
ZXJpYWwKMGNmOC0wY2ZmIDogUENJIGNvbmYxCjEwMDAtMTBmZiA6IFBDSSBD
YXJkQnVzICMwMwoxNDAwLTE0ZmYgOiBQQ0kgQ2FyZEJ1cyAjMDMKMTgwMC0x
OGZmIDogUENJIENhcmRCdXMgIzA3CjFjMDAtMWNmZiA6IFBDSSBDYXJkQnVz
ICMwNwo3MDAwLTcwZmYgOiBSZWFsdGVrIFNlbWljb25kdWN0byBSVEwtODEz
OS84MTM5Qy84MTM5QwogIDcwMDAtNzBmZiA6IDgxMzl0b28KODAwMC04MDFm
IDogSW50ZWwgQ29ycC4gODI4MDFCQS9CQU0gVVNCIChIdWIKICA4MDAwLTgw
MWYgOiB1aGNpLWhjZAo4MDYwLTgwN2YgOiBJbnRlbCBDb3JwLiA4MjgwMUJB
L0JBTSBVU0IgKEh1YgogIDgwNjAtODA3ZiA6IHVoY2ktaGNkCmEwMDAtYWZm
ZiA6IFBDSSBCdXMgIzAxCiAgYTAwMC1hMGZmIDogQVRJIFRlY2hub2xvZ2ll
cyBJbmMgUmFkZW9uIE1vYmlsaXR5IE02IEwKYjAwMC1iMGZmIDogSW50ZWwg
Q29ycC4gODI4MDFCQS9CQU0gQUMnOTcgQXUKICBiMDAwLWIwZmYgOiBJbnRl
bCBJQ0gyCmI0MDAtYjQzZiA6IEludGVsIENvcnAuIDgyODAxQkEvQkFNIEFD
Jzk3IEF1CiAgYjQwMC1iNDNmIDogSW50ZWwgSUNIMgpiODAwLWI4ZmYgOiBJ
bnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBBQyc5NyBNbwpiYzAwLWJjN2YgOiBJ
bnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBBQyc5NyBNbwpiYzkwLWJjOWYgOiBJ
bnRlbCBDb3JwLiA4MjgwMUJBIElERSBVMTAwCiAgYmM5MC1iYzk3IDogaWRl
MAogIGJjOTgtYmM5ZiA6IGlkZTEKZjMwMC1mMzBmIDogSW50ZWwgQ29ycC4g
ODI4MDFCQS9CQU0gU01CdXMKCjAwMDAwMDAwLTAwMDlmYmZmIDogU3lzdGVt
IFJBTQowMDA5ZmMwMC0wMDA5ZmZmZiA6IHJlc2VydmVkCjAwMGEwMDAwLTAw
MGJmZmZmIDogVmlkZW8gUkFNIGFyZWEKMDAwYzAwMDAtMDAwYzdmZmYgOiBW
aWRlbyBST00KMDAwZjAwMDAtMDAwZmZmZmYgOiBTeXN0ZW0gUk9NCjAwMTAw
MDAwLTFmZmRmZmZmIDogU3lzdGVtIFJBTQogIDAwMTAwMDAwLTAwMzU4ODM4
IDogS2VybmVsIGNvZGUKICAwMDM1ODgzOS0wMDQ0ZjVmZiA6IEtlcm5lbCBk
YXRhCjFmZmUwMDAwLTFmZmY3ZmZmIDogQUNQSSBOb24tdm9sYXRpbGUgU3Rv
cmFnZQoyMDAwMDAwMC0yMDAwMGZmZiA6IFRleGFzIEluc3RydW1lbnRzIFBD
STEyNTAgUEMgY2FyZCBDYXJkCjIwMDAxMDAwLTIwMDAxZmZmIDogVGV4YXMg
SW5zdHJ1bWVudHMgUENJMTI1MCBQQyBjYXJkIENhcmQgKCMyKQoyMDQwMDAw
MC0yMDdmZmZmZiA6IFBDSSBDYXJkQnVzICMwMwoyMDgwMDAwMC0yMGJmZmZm
ZiA6IFBDSSBDYXJkQnVzICMwMwoyMGMwMDAwMC0yMGZmZmZmZiA6IFBDSSBD
YXJkQnVzICMwNwoyMTAwMDAwMC0yMTNmZmZmZiA6IFBDSSBDYXJkQnVzICMw
Nwo2MDAwMDAwMC02MDAwMGZmZiA6IGNhcmQgc2VydmljZXMKODAxMDAwMDAt
ODAxMDA3ZmYgOiBUZXhhcyBJbnN0cnVtZW50cyBUU0I0M0FCMjEgSUVFRS0x
Mzk0YQo4MDEwMDgwMC04MDEwMDhmZiA6IFJlYWx0ZWsgU2VtaWNvbmR1Y3Rv
IFJUTC04MTM5LzgxMzlDLzgxMzlDCiAgODAxMDA4MDAtODAxMDA4ZmYgOiA4
MTM5dG9vCjgwMTA0MDAwLTgwMTA3ZmZmIDogVGV4YXMgSW5zdHJ1bWVudHMg
VFNCNDNBQjIxIElFRUUtMTM5NGEKODA1MDAwMDAtODA1ZmZmZmYgOiBQQ0kg
QnVzICMwMQogIDgwNTAwMDAwLTgwNTBmZmZmIDogQVRJIFRlY2hub2xvZ2ll
cyBJbmMgUmFkZW9uIE1vYmlsaXR5IE02IEwKODA2MDAwMDAtOTAwZmZmZmYg
OiBQQ0kgQnVzICMwMQogIDg4MDAwMDAwLThmZmZmZmZmIDogQVRJIFRlY2hu
b2xvZ2llcyBJbmMgUmFkZW9uIE1vYmlsaXR5IE02IEwKICAgIDg4MDAwMDAw
LTg4ZmZmZmZmIDogdmVzYWZiCmUwMDAwMDAwLWVmZmZmZmZmIDogSW50ZWwg
Q29ycC4gODI4NDUgODQ1IChCcm9va2RhbGUKZmZmZjAwMDAtZmZmZmZmZmYg
OiByZXNlcnZlZAoKMDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycC4g
ODI4NDUgODQ1IChCcm9va2RhbGUpIENoaXBzZXQgSG9zdCBCcmlkZ2UgKHJl
diAwNCkKMDA6MDEuMCBQQ0kgYnJpZGdlOiBJbnRlbCBDb3JwLiA4Mjg0NSA4
NDUgKEJyb29rZGFsZSkgQ2hpcHNldCBBR1AgQnJpZGdlIChyZXYgMDQpCjAw
OjFlLjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycC4gODI4MDFCQS9DQS9EQiBQ
Q0kgQnJpZGdlIChyZXYgMDUpCjAwOjFmLjAgSVNBIGJyaWRnZTogSW50ZWwg
Q29ycC4gODI4MDFCQSBJU0EgQnJpZGdlIChMUEMpIChyZXYgMDUpCjAwOjFm
LjEgSURFIGludGVyZmFjZTogSW50ZWwgQ29ycC4gODI4MDFCQSBJREUgVTEw
MCAocmV2IDA1KQowMDoxZi4yIFVTQiBDb250cm9sbGVyOiBJbnRlbCBDb3Jw
LiA4MjgwMUJBL0JBTSBVU0IgKEh1YiAjMSkgKHJldiAwNSkKMDA6MWYuMyBT
TUJ1czogSW50ZWwgQ29ycC4gODI4MDFCQS9CQU0gU01CdXMgKHJldiAwNSkK
MDA6MWYuNCBVU0IgQ29udHJvbGxlcjogSW50ZWwgQ29ycC4gODI4MDFCQS9C
QU0gVVNCIChIdWIgIzIpIChyZXYgMDUpCjAwOjFmLjUgTXVsdGltZWRpYSBh
dWRpbyBjb250cm9sbGVyOiBJbnRlbCBDb3JwLiA4MjgwMUJBL0JBTSBBQyc5
NyBBdWRpbyAocmV2IDA1KQowMDoxZi42IE1vZGVtOiBJbnRlbCBDb3JwLiBJ
bnRlbCA1MzcgWzgyODAxQkEvQkFNIEFDJzk3IE1vZGVtXSAocmV2IDA1KQow
MTowMC4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEFUSSBUZWNobm9s
b2dpZXMgSW5jIFJhZGVvbiBNb2JpbGl0eSBNNiBMWQowMjowMy4wIEZpcmVX
aXJlIChJRUVFIDEzOTQpOiBUZXhhcyBJbnN0cnVtZW50cyBUU0I0M0FCMjEg
SUVFRS0xMzk0YS0yMDAwIENvbnRyb2xsZXIgKFBIWS9MaW5rKQowMjowNS4w
IEV0aGVybmV0IGNvbnRyb2xsZXI6IFJlYWx0ZWsgU2VtaWNvbmR1Y3RvciBD
by4sIEx0ZC4gUlRMLTgxMzkvODEzOUMvODEzOUMrIChyZXYgMTApCjAyOjA5
LjAgQ2FyZEJ1cyBicmlkZ2U6IFRleGFzIEluc3RydW1lbnRzIFBDSTEyNTAg
UEMgY2FyZCBDYXJkYnVzIENvbnRyb2xsZXIgKHJldiAwMSkKMDI6MDkuMSBD
YXJkQnVzIGJyaWRnZTogVGV4YXMgSW5zdHJ1bWVudHMgUENJMTI1MCBQQyBj
YXJkIENhcmRidXMgQ29udHJvbGxlciAocmV2IDAxKQoKcHJvY2Vzc29yCTog
MAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDE1Cm1v
ZGVsCQk6IDIKbW9kZWwgbmFtZQk6IEludGVsKFIpIFBlbnRpdW0oUikgNCBD
UFUgMi4yMEdIegpzdGVwcGluZwk6IDQKY3B1IE1IegkJOiA1NTAuMDEyCmNh
Y2hlIHNpemUJOiA1MTIgS0IKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5v
CmYwMGZfYnVnCTogbm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVzCmZwdV9l
eGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAyCndwCQk6IHllcwpmbGFn
cwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IHNlcCBt
dHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBt
bXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bQpib2dvbWlwcwk6IDEwODUuNDQK
ClRoZSByZWFsIHNwZWVkIG9mIG15IGNwdSBpcyAyMjAwLjA0OCBidXQgSSB0
b2xkIHlvdSBJJ20gdXNpbmcgY3B1ZnJlcS4uLg==


------=_NextPart_000_384d_904_e33--
