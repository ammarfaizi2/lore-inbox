Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVKEWVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVKEWVj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 17:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKEWVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 17:21:39 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:50574
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932208AbVKEWVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 17:21:38 -0500
Message-ID: <436D305D.3000705@linuxwireless.org>
Date: Sat, 05 Nov 2005 16:21:17 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ipw2100 Development List <ipw2100-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, James Ketrenos <jketreno@linux.intel.com>
Subject: IPW2200 and 2.6.14-git
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have an IBM T42 with Debian Sid, since the last kernel-image I 
made Firday 4, November at 7PM EST.

Basically, it would hang so bad that I will not be able to even modprobe 
-r ipw2200

I don't have this problem with another kernel Image that I did like on 
Monday.

This is against 2.6.14-linusGit with the develpment drivers and not the 
inline ones.

ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI: PCI interrupt for device 0000:02:02.0 disabled
ieee80211_crypt: unregistered algorithm 'NULL' (deinit)
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, 1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 11 (level, 
low) -> IRQ 11
PCI: Enabling bus mastering for device 0000:02:02.0
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
eth1: no IPv6 routers present
ipw2200: Firmware error detected.  Restarting.
ipw2200: Sysfs 'error' log captured.
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c0341326
*pde = 00000000
Oops: 0000 [#3]
PREEMPT
Modules linked in: ipw2200 ieee80211 ieee80211_crypt firmware_class ipv6 
thermal fan button ac battery autofs4 af_packet nls_iso8859_1 nls_cp437 
joydev nvram hdaps speedstep_centrino processor radeon pcmcia 
yenta_socket i810_audio ac97_codec rsrc_nonstatic soundcore e1000 
pcmcia_core i2c_i801 shpchp pci_hotplug i2c_core intel_agp ehci_hcd 
evdev uhci_hcd irtty_sir sir_dev irda crc_ccitt mousedev rtc pcspkr unix
CPU:    0
EIP:    0060:[<c0341326>]    Not tainted VLI
EFLAGS: 00010097   (2.6.14)
EIP is at skb_release_data+0x4b/0x98
eax: cd473c00   ebx: d1d3f200   ecx: d60d6924   edx: 00000008
esi: 00000000   edi: cdbda6f0   ebp: 0000000f   esp: ceb97f18
ds: 007b   es: 007b   ss: 0068
Process ipw2200/0 (pid: 6475, threadinfo=ceb96000 task=cdb29a90)
Stack: d1d3f200 d60d692c c034137e d1d3f200 d60d6800 e152a038 d1d3f200 
00000286
       fffffffb cdbda6f0 ceb96000 00000000 e1537433 cdbda6f0 cdbda6f0 
cdbdb358
       ceb96000 00000287 e1526e3a cdbda6f0 cdbda6f0 e1526e63 cdbda6f0 
cdbdb35c
Call Trace:
 [<c034137e>] kfree_skbmem+0xb/0x67
 [<e152a038>] ipw_load+0x155/0x8cc [ipw2200]
 [<e1537433>] ipw_up+0xe6/0x34f [ipw2200]
 [<e1526e3a>] ipw_adapter_restart+0x32/0x47 [ipw2200]
 [<e1526e63>] ipw_bg_adapter_restart+0x14/0x20 [ipw2200]
 [<c01259bb>] worker_thread+0x17d/0x207
 [<e1526e4f>] ipw_bg_adapter_restart+0x0/0x20 [ipw2200]
 [<c0115e43>] default_wake_function+0x0/0x12
 [<c012583e>] worker_thread+0x0/0x207
 [<c0128c50>] kthread+0x68/0x95
 [<c0128be8>] kthread+0x0/0x95
 [<c01012b9>] kernel_thread_helper+0x5/0xb
Code: 31 d2 81 c2 01 00 01 00 f7 da 89 d1 0f c1 08 89 c8 01 d0 85 c0 75 
5e 8b 83 9c 00 00 00 31 f6 83 78 04 00 75 21 eb 2a 8b 54 f0 18 <8b> 42 
04 40 75 02 0f 0b 83 42 04 ff 0f 98 c0 84 c0 74 07 89 d0
 <6>note: ipw2200/0[6475] exited with preempt_count 1


debian:/home/abonilla# kill -9 6642
debian:/home/abonilla# ps aux | grep ipw2200
root      6642  0.0  0.1   1592   568 ?        D    16:07   0:00 
modprobe -r ipw2200
root      6697  0.0  0.1   1924   592 pts/2    R+   16:12   0:00 grep 
ipw2200

