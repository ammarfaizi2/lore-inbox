Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTHTAHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbTHTAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:07:09 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:45885 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261595AbTHTAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:06:08 -0400
From: jjluza <jjluza@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.6-testXX and alcatel speedtouch usb modem
Date: Wed, 20 Aug 2003 02:06:20 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308200206.20798.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to make this modem working.
It works very well on kernel 2.4 series.
It work with some kernel 2.6 until test2-mm1.
But since test2-mm1, the newer kernel doesn't work anymore.
There is 2 related drivers for this modem.
The one which is included in the kernel and which can be found here :
http://www.linux-usb.org/SpeedTouch/
and the one which I've always used until now :
speedtouch.sourceforge.net

when I notice that the old one doesn't work anymore, I try with the driver 
which included in the kernel, without success.

It crashed when I do "pppd call adsl".
I can load the firmware.

And here is messages in syslog :
Aug 19 22:00:26 serveur modem_run[337]: modem_run version 1.1 started by root 
uid 0
Aug 19 22:00:28 serveur kernel: usb 1-2: bulk timeout on ep5in
Aug 19 22:00:28 serveur kernel: usbfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 
512 ret -110
Aug 19 22:00:43 serveur modem_run[337]: ADSL synchronization has been obtained
Aug 19 22:00:43 serveur modem_run[337]: ADSL line is up (608 kbit/s down | 160 
kbit/s up)
Aug 19 22:00:43 serveur modprobe: FATAL: Module ipv6 not found.
Aug 19 22:00:43 serveur pppd[345]: pppd 2.4.1 started by root, uid 0
Aug 19 22:00:43 serveur pppd[345]: Using interface ppp0
Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
Aug 19 22:00:44 serveur kernel: ip_conntrack version 2.1 (768 buckets, 6144 
max) - 300 bytes per conntrack
Aug 19 22:00:44 serveur pppoa3[346]: PPPoA3 version 1.1 started by root (uid 
0)
Aug 19 22:00:44 serveur pppoa3[346]: Control thread ready
Aug 19 22:00:44 serveur pppoa3[352]: ppp(d) --> pppoa3 --> modem  stream ready
Aug 19 22:00:44 serveur pppoa3[353]: modem  --> pppoa3 --> ppp(d) stream ready
Aug 19 22:00:44 serveur pppoa3[353]: Error reading usb urb
Aug 19 22:00:44 serveur pppoa3[346]: Woken by a sem_post event -> Exiting
Aug 19 22:00:44 serveur pppoa3[346]: Read from ppp Canceled
Aug 19 22:00:44 serveur pppoa3[346]: Write to ppp Canceled
Aug 19 22:00:44 serveur pppoa3[346]: Exiting
Aug 19 22:00:44 serveur pppd[345]: Modem hangup
Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a release() 
function, it is broken and must
be fixed.
Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at 
drivers/base/class.c:201
Aug 19 22:00:44 serveur kernel: Call Trace:
Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64] 
kobject_cleanup+0x36/0x40
Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464] 
netdev_run_todo+0x10b/0x1d0
Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712] 
ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712] 
ppp_ioctl+0x802/0x820 [ppp_generic]
Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640] sys_ioctl+0x107/0x280
Aug 19 22:00:44 serveur kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 19 22:00:44 serveur kernel:
Aug 19 22:00:44 serveur kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 19 22:00:44 serveur pppd[345]: Using interface ppp0
Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
Aug 19 22:00:44 serveur pppoa3[364]: PPPoA3 version 1.1 started by root (uid 
0)
Aug 19 22:00:44 serveur pppoa3[364]: Control thread ready
Aug 19 22:00:44 serveur pppoa3[374]: ppp(d) --> pppoa3 --> modem  stream ready
Aug 19 22:00:44 serveur pppoa3[375]: modem  --> pppoa3 --> ppp(d) stream ready
Aug 19 22:00:44 serveur pppoa3[375]: Error reading usb urb
Aug 19 22:00:44 serveur pppoa3[364]: Woken by a sem_post event -> Exiting
Aug 19 22:00:44 serveur pppoa3[364]: Read from ppp Canceled
Aug 19 22:00:44 serveur pppoa3[364]: Write to ppp Canceled
Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
Aug 19 22:00:44 serveur pppoa3[364]: Exiting
Aug 19 22:00:44 serveur pppd[345]: Modem hangup
Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a release() 
function, it is broken and must
be fixed.
Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at 
drivers/base/class.c:201
Aug 19 22:00:44 serveur kernel: Call Trace:
Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64] 
kobject_cleanup+0x36/0x40
Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464] 
netdev_run_todo+0x10b/0x1d0
Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712] 
ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712] 
ppp_ioctl+0x802/0x820 [ppp_generic]
Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640] sys_ioctl+0x107/0x280
Aug 19 22:00:44 serveur kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 19 22:00:44 serveur kernel:
Aug 19 22:00:44 serveur pppoa3[386]: PPPoA3 version 1.1 started by root (uid 
0)
Aug 19 22:00:44 serveur pppoa3[386]: Control thread ready
Aug 19 22:00:44 serveur pppoa3[389]: ppp(d) --> pppoa3 --> modem  stream ready
Aug 19 22:00:44 serveur pppoa3[390]: modem  --> pppoa3 --> ppp(d) stream ready
Aug 19 22:00:44 serveur pppoa3[390]: Error reading usb urb
Aug 19 22:00:44 serveur pppoa3[386]: Woken by a sem_post event -> Exiting
Aug 19 22:00:44 serveur pppoa3[386]: Read from ppp Canceled
Aug 19 22:00:44 serveur pppoa3[386]: Write to ppp Canceled
Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
Aug 19 22:00:44 serveur pppd[345]: Using interface ppp0
Aug 19 22:00:44 serveur pppoa3[386]: Exiting
Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
Aug 19 22:00:44 serveur pppd[345]: ioctl(PPPIOCSASYNCMAP): Inappropriate ioctl 
for device(25)
Aug 19 22:00:44 serveur pppd[345]: tcflush failed: Input/output error
Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a release() 
function, it is broken and must
be fixed.
Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at 
drivers/base/class.c:201
Aug 19 22:00:44 serveur kernel: Call Trace:
Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64] 
kobject_cleanup+0x36/0x40
Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464] 
netdev_run_todo+0x10b/0x1d0
Aug 19 22:00:45 serveur kernel:  [_end+114517535/1070384712] 
ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
Aug 19 22:00:45 serveur kernel:  [_end+114504362/1070384712] 
ppp_ioctl+0x802/0x820 [ppp_generic]
Aug 19 22:00:45 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
Aug 19 22:00:45 serveur kernel:  [sys_ioctl+263/640] sys_ioctl+0x107/0x280
Aug 19 22:00:45 serveur kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 19 22:00:45 serveur kernel:
Aug 19 22:00:45 serveur pppd[345]: Exit.


so, the last kernel which work with this adsl modem is test2-mm1.
here is some informations when I'm running this kernel :

/proc/modules :
ipt_state 1248 12 - Live 0xc70d8000
ipt_multiport 1408 3 - Live 0xc70d6000
ipt_MASQUERADE 2656 1 - Live 0xc70d4000
iptable_filter 1952 1 - Live 0xc70cb000
ip_nat_irc 3248 0 - Live 0xc70c9000
ip_conntrack_irc 70100 1 ip_nat_irc, Live 0xc70b6000
ip_nat_ftp 3824 0 - Live 0xc704d000
iptable_nat 19436 4 ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp, Live 0xc70a4000
ip_tables 15328 5 
ipt_state,ipt_multiport,ipt_MASQUERADE,iptable_filter,iptable_nat, Live 
0xc70aa000
ip_conntrack_ftp 70708 1 ip_nat_ftp, Live 0xc7091000
ip_conntrack 24336 7 
ipt_state,ipt_MASQUERADE,ip_nat_irc,ip_conntrack_irc,ip_nat_ftp,iptable_nat,ip_conntrack_ftp, 
Live 0xc706f000
n_hdlc 8228 1 - Live 0xc706b000
ppp_async 8992 0 - Live 0xc705e000
ppp_synctty 7040 1 - Live 0xc7015000
ppp_generic 26416 6 ppp_async,ppp_synctty, Live 0xc7063000
slhc 5984 1 ppp_generic, Live 0xc7039000
ohci_hcd 16064 0 - Live 0xc7048000
usbcore 92412 3 ohci_hcd, Live 0xc7076000
vfat 12448 0 - Live 0xc7043000
fat 39040 1 vfat, Live 0xc704f000
8139too 20064 0 - Live 0xc703d000
mii 3712 1 8139too, Live 0xc701a000
crc32 3776 1 8139too, Live 0xc7018000
unix 22064 16 - Live 0xc701d000


lspci -vvv :
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 6400 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:12.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e3001000 (32-bit, non-prefetchable) [size=4K]

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 6800 [size=256]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:14.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG [Mystique] 
(rev 02) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at e1000000 (32-bit, prefetchable) [size=8M]
        Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

