Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbSAHJrG>; Tue, 8 Jan 2002 04:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbSAHJq4>; Tue, 8 Jan 2002 04:46:56 -0500
Received: from mta01ps.bigpond.com ([144.135.25.133]:35066 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S281772AbSAHJqr>; Tue, 8 Jan 2002 04:46:47 -0500
Message-Id: <5.1.0.14.0.20020108203421.00af4940@pop-server.bigpond.net.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 08 Jan 2002 20:46:38 +1100
To: linux-kernel@vger.kernel.org
From: Glenn Geers <dgeers@bigpond.net.au>
Subject: PCI SCSI interrupt clash
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I check the kernel archive and found reference to the PCI interrupt clash 
between the 2940 (aic7xxx) and other cards. I also have the problem and it 
can lock up my entire machine.
The problem really rears its head when I  overclock my box (BX400 dual PIII 
450 MHZ) by as little as 10% (504 MHz, 112 MHZ bus). Both my soundblaster 
live and my onboard AIC7891 are assigned IRQ 19. My PCI slots are full 
(ethernet, 1394 card, soundblaster live, tv card, and Matrox G400). I 
enclose the win2k interrupt allocation for your perusal and comment (it's 
weird!)

Current kernel version is 2.4.17 but the problem has been evident since 
2.4.5 (at least). The 2.2 series does not exhibit the problem.

System Information report written at: 08/01/2002 08:44:11 PM
[IRQs]

IRQ Number	Device
5	Sound Blaster 16 or AWE32 or compatible (WDM)
128	Matrox Millennium G400 DualHead MAX
14	Primary IDE Channel
15	Secondary IDE Channel
11	Intel 82371AB/EB PCI to USB Universal Host Controller
36	Adaptec AHA-2940U2/U2W PCI SCSI Controller
52	Realtek RTL8139/810X Family PCI Fast Ethernet NIC
56	Hauppauge Win/TV 878/9 VFW Video Driver
56	Hauppauge Win/TV 878/9 VFW Audio Driver
60	Creative SB Live! Value (WDM)
64	Texas Instruments OHCI Compliant IEEE 1394 Host Controller
1	PC/AT Enhanced PS/2 Keyboard (101/102-Key)
4	Communications Port (COM1)
3	Communications Port (COM2)
6	Standard floppy disk controller
8	System CMOS/real time clock
13	Numeric data processor
12	Other Logitech Mouse PS/2

I hope someone can shed some light on the very high (>20) interrupt 
numbers. I'd really like and will help to get to the bottom of the problem.

Regards,
	Glenn

