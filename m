Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUEEWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUEEWEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUEEWEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:04:41 -0400
Received: from skynet06.in-ulm.de ([217.10.0.16]:53666 "EHLO
	skynet06.in-ulm.de") by vger.kernel.org with ESMTP id S264815AbUEEWEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:04:35 -0400
Message-ID: <409964EE.4090805@natterer-legau.de>
Date: Thu, 06 May 2004 00:04:30 +0200
From: Simon Natterer <simon@natterer-legau.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ISDN/Capi Driver or PPP problem
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090008040100050308020600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090008040100050308020600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've got a problem with Kernel 2.6.6-rc2 and my AVM-B1 PCI card
together with a PPP connection.
When using Asterisk PBX I've got strange problems like dropped
connections (ppp) or hangups.
I captured this oops:
Can anyone help me interpreting the attached file, I'm not sure
if this problem is really ISDN related or has to do with PPP.

Thanks in advance

Simon


P. S.
Do I have to run ksymoops over this data? It seems I don't get
more data with this run.


Additional Info:
lspci
0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03)
0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt878 
Video Capture (rev 11)
0000:00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio 
Capture (rev 11)
0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8029(AS)
0000:00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer 
System GmbH B1 ISDN
0000:00:0c.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 
AGP (rev 01)

lsmod
Module                  Size  Used by
cls_u32                 7972  4
cls_fw                  5152  1
sch_sfq                 5600  4
sch_cbq                18208  1
ipt_MARK                2048  8
iptable_mangle          2816  1
b1pci                  10304  2
b1dma                  17252  1 b1pci
b1                     25792  2 b1pci,b1dma
capi                   18880  6
capifs                  5864  2 capi
kernelcapi             48768  4 b1pci,b1dma,b1,capi
psmouse                20680  0
parport_pc             35008  1
lp                     11204  0
parport                41832  2 parport_pc,lp
ppp_deflate             6336  0
zlib_deflate           22776  1 ppp_deflate
bsd_comp                6112  0
ppp_async              12256  1
af_packet              22472  6
ipv6                  255264  22
ppp_generic            30900  7 ppp_deflate,bsd_comp,ppp_async
slhc                    7488  1 ppp_generic
ipt_MASQUERADE          3776  2
ipt_state               2016  6
ipt_REJECT              6848  30
iptable_nat            24716  2 ipt_MASQUERADE
ip_conntrack           35552  3 ipt_MASQUERADE,ipt_state,iptable_nat
iptable_filter          2816  1
ip_tables              18080  7 
ipt_MARK,iptable_mangle,ipt_MASQUERADE,ipt_state,ipt_REJECT,iptable_nat,iptable_filter
dm_mod                 44416  0
tuner                  18604  0
tvaudio                22444  0
bttv                  153132  0
video_buf              21220  1 bttv
i2c_algo_bit            9800  1 bttv
v4l2_common             6144  1 bttv
btcx_risc               4808  1 bttv
i2c_core               23556  4 tuner,tvaudio,bttv,i2c_algo_bit
videodev                9920  1 bttv
ns558                   5728  0
gameport                4704  1 ns558
sb                     10596  0
sb_lib                 51056  1 sb
uart401                11684  1 sb_lib
sound                  84268  2 sb_lib,uart401
soundcore              10336  3 bttv,sb_lib,sound
apm                    18348  0
ne2k_pci                9312  0
8390                   10112  1 ne2k_pci


--------------090008040100050308020600
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

May  5 22:33:00 na02 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004                   May  5 22:33:00 na02 kernel:  printing eip:
May  5 22:33:00 na02 kernel: d0a6dff3                                                                                       May  5 22:33:00 na02 kernel: *pde = 00000000
May  5 22:33:00 na02 kernel: Oops: 0002 [#1]                                                                                May  5 22:33:00 na02 kernel: PREEMPT
May  5 22:33:00 na02 kernel: CPU:    0                                                                                      May  5 22:33:00 na02 kernel: Stack: 00000004 00000000 00000001 41210a28 00000000 c4465180 c44651a0 00
May  5 22:33:00 na02 kernel: EFLAGS: 00010046   (2.6.6-rc2)                                                                 May  5 22:33:00 na02 kernel: EIP is at capi_read+0x53/0x220 [capi]
May  5 22:33:00 na02 kernel: eax: 00000000   ebx: cb3e9c80   ecx: 00000004   edx: 00000206                                  May  5 22:33:00 na02 kernel: esi: ca70c000   edi: c6315530   ebp: c63154a0   esp: ca70df54
May  5 22:33:00 na02 kernel: ds: 007b   es: 007b   ss: 0068                                                                 May  5 22:33:00 na02 kernel: Process asterisk (pid: 8087, threadinfo=ca70c000 task=cd3e2e90)
May  5 22:33:00 na02 kernel: Stack: 00000004 00000000 00000001 41210a28 00000000 c4465180 c44651a0 00000880                 May  5 22:33:00 na02 kernel:        c015201d c4465180 080f2168 00000880 c44651a0 c31758e0 00000009 c4465180
May  5 22:33:00 na02 kernel:        fffffff7 00000003 ca70c000 c01522f2 c4465180 080f2168 00000880 c44651a0                 May  5 22:33:00 na02 kernel: Call Trace:
May  5 22:33:00 na02 kernel:  [vfs_read+237/352] vfs_read+0xed/0x160                                                        May  5 22:33:00 na02 kernel:  [sys_read+66/112] sys_read+0x42/0x70
May  5 22:33:00 na02 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb                                                      May  5 22:33:00 na02 kernel:
May  5 22:33:00 na02 kernel: Code: 89 78 04 89 85 90 00 00 00 c7 43 04 00 00 00 00 c7 03 00 00                              May  5 22:33:00 na02 kernel:  <6>note: asterisk[8087] exited with preempt_count 1
May  5 22:34:53 na02 kernel: capilib_new_ncci: kcapi: appl 4 ncci 0x20201 up
May  5 22:40:20 na02 kernel: Unable to handle kernel paging request at virtual address 7b230b2a
May  5 22:40:20 na02 kernel:  printing eip:
May  5 22:40:20 na02 kernel: c029a2f4
May  5 22:40:20 na02 kernel: *pde = 00000000
May  5 22:40:20 na02 kernel: Oops: 0000 [#2]
May  5 22:40:20 na02 kernel: PREEMPT
May  5 22:40:20 na02 kernel: CPU:    0
May  5 22:40:20 na02 kernel: EIP:    0060:[skb_release_data+68/176]    Not tainted
May  5 22:40:20 na02 kernel: EFLAGS: 00010297   (2.6.6-rc2)
May  5 22:40:20 na02 kernel: EIP is at skb_release_data+0x44/0xb0
May  5 22:40:20 na02 kernel: eax: c88b7480   ebx: 00000000   ecx: c88b7480   edx: 7b230b2a
May  5 22:40:20 na02 kernel: esi: cda066a0   edi: cc183ec8   ebp: 00000057   esp: cc183d6c
May  5 22:40:20 na02 kernel: ds: 007b   es: 007b   ss: 0068
May  5 22:40:20 na02 kernel: Process pppoe (pid: 20338, threadinfo=cc182000 task=c5150d10)
May  5 22:40:20 na02 kernel: Stack: c029c3d4 cda066a0 cda066e8 c029a373 cda066a0 00000000 00000000 c029a433
May  5 22:40:20 na02 kernel:        cda066a0 000005f0 cc183f34 cda066a0 d0a3183b cda066a0 cda066a0 cc183ea8
May  5 22:40:20 na02 kernel:        00000057 c02b8bd0 cffcd6a0 00000057 00000000 000005f0 cc183f34 cc183de4
May  5 22:40:20 na02 kernel: Call Trace:
May  5 22:40:20 na02 kernel:  [skb_copy_datagram_iovec+84/576] skb_copy_datagram_iovec+0x54/0x240
May  5 22:40:20 na02 kernel:  [kfree_skbmem+19/48] kfree_skbmem+0x13/0x30
May  5 22:40:20 na02 kernel:  [__kfree_skb+163/320] __kfree_skb+0xa3/0x140
May  5 22:40:20 na02 kernel:  [__crc_copy_strings_kernel+1461661/3318524] packet_recvmsg+0x12b/0x160 [af_packet]
May  5 22:40:20 na02 kernel:  [ip_rcv_finish+0/640] ip_rcv_finish+0x0/0x280
May  5 22:40:20 na02 kernel:  [sock_recvmsg+150/192] sock_recvmsg+0x96/0xc0
May  5 22:40:20 na02 kernel:  [ip_rcv_finish+0/640] ip_rcv_finish+0x0/0x280
May  5 22:40:20 na02 kernel:  [__crc_copy_strings_kernel+1427723/3318524] ppp_receive_nonmp_frame+0x1a9/0x620 [ppp_generic]
May  5 22:40:20 na02 kernel:  [netif_receive_skb+443/544] netif_receive_skb+0x1bb/0x220
May  5 22:40:20 na02 kernel:  [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0
May  5 22:40:20 na02 kernel:  [schedule+813/1472] schedule+0x32d/0x5c0
May  5 22:40:20 na02 kernel:  [sockfd_lookup+28/128] sockfd_lookup+0x1c/0x80
May  5 22:40:20 na02 kernel:  [sys_recvfrom+178/288] sys_recvfrom+0xb2/0x120
May  5 22:40:20 na02 kernel:  [poll_freewait+68/80] poll_freewait+0x44/0x50
May  5 22:40:20 na02 kernel:  [do_select+431/720] do_select+0x1af/0x2d0
May  5 22:40:20 na02 kernel:  [sys_recv+51/64] sys_recv+0x33/0x40
May  5 22:40:20 na02 kernel:  [sys_socketcall+356/608] sys_socketcall+0x164/0x260
May  5 22:40:20 na02 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May  5 22:40:20 na02 kernel:
May  5 22:40:20 na02 kernel: Code: 8b 02 f6 c4 08 75 17 8b 42 04 85 c0 74 4a ff 4a 04 0f 94 c0
May  5 22:40:20 na02 kernel:  <6>kcapi: appl 4 ncci 0x20201 down

--------------090008040100050308020600--
