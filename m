Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272623AbRHaHhI>; Fri, 31 Aug 2001 03:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272624AbRHaHg7>; Fri, 31 Aug 2001 03:36:59 -0400
Received: from mail.arcor-ip.de ([145.253.2.10]:47009 "EHLO mail.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S272623AbRHaHgv>;
	Fri, 31 Aug 2001 03:36:51 -0400
Date: Fri, 31 Aug 2001 09:36:41 +0200
From: Christopher Ruehl <ruehlc@europe.com>
To: linux-kernel@vger.kernel.org
Subject: usb_control/bulk_msg
Message-ID: <20010831093641.A1257@pegasus>
Reply-To: Christopher Ruehl <ruehlc@europe.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
OS: Linux pegasus 2.4.9-ac5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

! PLEASE CC to me i'am not registered to this list

i'll try to use the usb-storage with my Sony DSC
but since kernel version 2.4.7 it's seems to be brocken.

look like a problem with the interrupt handling with the
usb-uhci which shares it's interupt with the sym53c8xx driver.

i use a 'dualhead' SCSI controller from DIGIAL with
two 53c875 chipset.

any idea?

cheers
chris ruehl

info follows:
$PCI Status for kernel:  Linux 2.4.9-ac5 i686

$PCI up; bus count is 3
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0b.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
02:00.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 04)
02:01.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 04)
02:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)

$USB Status for kernel:  Linux 2.4.9-ac5 i686

$USB up; bus count is 1
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=e000
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub

Aug 31 09:15:14 pegasus kernel: Initializing USB Mass Storage driver... 
Aug 31 09:15:14 pegasus kernel: usb.c: registered new driver usb-storage 
Aug 31 09:15:14 pegasus kernel: USB Mass Storage support registered. 
Aug 31 09:15:35 pegasus kernel: hub.c: USB new device connect on bus1/2, assigned device number 2 
Aug 31 09:15:35 pegasus kernel: Manufacturer: Sony 
Aug 31 09:15:35 pegasus kernel: Product: Sony DSC 
Aug 31 09:15:36 pegasus kernel: scsi2 : SCSI emulation for USB Mass Storage devices 
Aug 31 09:15:36 pegasus kernel:   Vendor: Sony      Model: Sony DSC          Rev: 2.10 
Aug 31 09:15:36 pegasus kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02 
Aug 31 09:15:38 pegasus kernel: Attached scsi removable disk sdc at scsi2, channel 0, id 0, lun 0 
Aug 31 09:15:39 pegasus kernel: SCSI device sdc: 126848 512-byte hdwr sectors (65 MB) 
Aug 31 09:15:39 pegasus kernel: usb-uhci.c: interrupt, status 3, frame# 1033 
Aug 31 09:15:39 pegasus kernel: usb_control/bulk_msg: timeout

[root@pegasus chris]# cat /proc/interrupts 
CPU0       
0:     139465          XT-PIC  timer
1:       3326          XT-PIC  keyboard
2:          0          XT-PIC  cascade
5:          8          XT-PIC  eth0
8:          1          XT-PIC  rtc
10:       7816          XT-PIC  sym53c8xx
11:        102          XT-PIC  sym53c8xx, usb-uhci
12:      22185          XT-PIC  PS/2 Mouse
15:       7896          XT-PIC  HiSax
NMI:          0 
ERR:          0

-- 
       """"
Linux, O  O  we work on it!
        (    help the commnuity and find the BUGS.
       +__/ 
